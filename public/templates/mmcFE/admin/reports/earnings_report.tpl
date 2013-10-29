{include file="global/block_header.tpl" ALIGN="left" BLOCK_STYLE="width: 100%" BLOCK_HEADER="Earnings Report Last {$BLOCKLIMIT} Blocks For User: {$USERNAME}"  STYLE="padding-left:5px;padding-right:5px;"}
  <table class="left" width="100%" class="sortable" style="font-size:12px;">
    <thead>
      <tr style="background-color:#B6DAFF;">
        <th >Block</th>
        <th class="right">Round Shares</th>
        <th class="right">Round Valid</th>
        <th class="right">Invalid</th>
        <th class="right">Invalid %</th>
        <th class="right">Round %</th>
        {if $GLOBAL.config.payout_system == 'pplns'}
        <th class="right">PPLNS Shares</th>
        <th class="right">PPLNS Valid</th>
        <th class="right">Invalid</th>
        <th class="right">Invalid %</th>
        <th class="right">PPLNS %</th>
        <th class="right">Variance</th>
        {/if}
        <th class="right">Amount</th>
      </tr>
    </thead>
    <tbody>
{assign var=percentage value=0}
{assign var=percentage1 value=0}
{assign var=percentage2 value=0}
{assign var=totalvalid value=0}
{assign var=totalinvalid value=0}
{assign var=totalshares value=0}
{assign var=usertotalshares value=0}
{assign var=totalpercentage value=0}
{assign var=pplnsshares value=0}
{assign var=userpplnsshares value=0}
{assign var=pplnsvalid value=0}
{assign var=pplnsinvalid value=0}
{assign var=amount value=0}
{section txs $REPORTDATA}
      {assign var="totalshares" value=$totalshares+$REPORTDATA[txs].shares}
      {assign var=totalvalid value=$totalvalid+$REPORTDATA[txs]['user'].valid}
      {assign var=totalinvalid value=$totalinvalid+$REPORTDATA[txs]['user'].invalid}
      {assign var="pplnsshares" value=$pplnsshares+$REPORTDATA[txs].pplns_shares}
      {assign var=pplnsvalid value=$pplnsvalid+$REPORTDATA[txs]['user'].pplns_valid}
      {assign var=pplnsinvalid value=$pplnsinvalid+$REPORTDATA[txs]['user'].pplns_invalid}
      {assign var=amount value=$amount+$REPORTDATA[txs].user_credit}
      {if $REPORTDATA[txs]['user'].pplns_valid > 0}
        {assign var="userpplnsshares" value=$userpplnsshares+$REPORTDATA[txs].pplns_shares}
      {/if}
      {if $REPORTDATA[txs]['user'].valid > 0}
        {assign var="usertotalshares" value=$usertotalshares+$REPORTDATA[txs].shares}
      {/if}
      <tr>
        <td><a href="{$smarty.server.PHP_SELF}?page=statistics&action=round&height={$REPORTDATA[txs].height}">{$REPORTDATA[txs].height|default:"0"}</a></td>
        <td class="right">{$REPORTDATA[txs].shares|default:"0"}</td>
        <td class="right">{$REPORTDATA[txs]['user'].valid|number_format|default:"0"}</td>
        <td class="right">{$REPORTDATA[txs]['user'].invalid|number_format|default:"0"}</td>
      	<td class="right">{if $REPORTDATA[txs]['user'].invalid > 0 }{($REPORTDATA[txs]['user'].invalid / $REPORTDATA[txs]['user'].valid * 100)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
        <td class="right">{if $REPORTDATA[txs]['user'].valid > 0 }{(( 100 / $REPORTDATA[txs].shares) * $REPORTDATA[txs]['user'].valid)|number_format:"2"}{else}0.00{/if}</td>
        {if $GLOBAL.config.payout_system == 'pplns'}
        <td class="right">{$REPORTDATA[txs].pplns_shares|number_format|default:"0"}</td>
        <td class="right">{$REPORTDATA[txs]['user'].pplns_valid|number_format|default:"0"}</td>
        <td class="right">{$REPORTDATA[txs]['user'].pplns_invalid|number_format|default:"0"}</td>
	<td class="right">{if $REPORTDATA[txs]['user'].pplns_invalid > 0 && $REPORTDATA[txs]['user'].pplns_valid > 0 }{($REPORTDATA[txs]['user'].pplns_invalid / $REPORTDATA[txs]['user'].pplns_valid * 100)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
	<td class="right">{if $REPORTDATA[txs].shares > 0 && $REPORTDATA[txs]['user'].pplns_valid > 0}{(( 100 / $REPORTDATA[txs].pplns_shares) * $REPORTDATA[txs]['user'].pplns_valid)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
        <td class="right">{if $REPORTDATA[txs]['user'].valid > 0 && $REPORTDATA[txs]['user'].pplns_valid > 0}{math assign="percentage1" equation=(100 / ((( 100 / $REPORTDATA[txs].shares) * $REPORTDATA[txs]['user'].valid) / (( 100 / $REPORTDATA[txs].pplns_shares) * $REPORTDATA[txs]['user'].pplns_valid)))}{else if $REPORTDATA[txs]['user'].pplns_valid == 0}{assign var=percentage1 value=0}{else}{assign var=percentage1 value=100}{/if}
          <font color="{if ($percentage1 >= 100)}green{else}red{/if}">{$percentage1|number_format:"2"|default:"0"}</font></b></td>
        {/if}
        <td class="right">{$REPORTDATA[txs].user_credit|default:"0"|number_format:"8"}</td>
        {assign var=percentage1 value=0}
      </tr>
{/section}
    <tr>
      <td><b>Totals</b></td>
      <td class="right">{$totalshares|number_format}</td>
      <td class="right">{$totalvalid|number_format}</td>
      <td class="right">{$totalinvalid|number_format}</td>
      <td class="right">{if $totalinvalid > 0 && $totalvalid > 0 }{($totalinvalid / $totalvalid * 100)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
      	<td class="right">{if $usertotalshares > 0 && $totalvalid > 0}{(( 100 / $usertotalshares) * $totalvalid)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
      {if $GLOBAL.config.payout_system == 'pplns'}
      <td class="right">{$pplnsshares|number_format}</td>
      <td class="right">{$pplnsvalid|number_format}</td>
      <td class="right">{$pplnsinvalid|number_format}</td>
      <td class="right">{if $pplnsinvalid > 0 && $pplnsvalid > 0 }{($pplnsinvalid / $pplnsvalid * 100)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
      	<td class="right">{if $userpplnsshares > 0 && $pplnsvalid > 0}{(( 100 / $userpplnsshares) * $pplnsvalid)|number_format:"2"|default:"0"}{else}0.00{/if}</td>
        <td class="right">{if $totalvalid > 0 && $pplnsvalid > 0}{math assign="percentage2" equation=(100 / ((( 100 / $usertotalshares) * $totalvalid) / (( 100 / $userpplnsshares) * $pplnsvalid)))}{else if $pplnsvalid == 0}{assign var=percentage2 value=0}{else}{assign var=percentage2 value=100}{/if}
          <font color="{if ($percentage2 >= 100)}green{else}red{/if}">{$percentage2|number_format:"2"|default:"0"}</font></b></td>
        {/if}
        <td class="right">{$amount|default:"0"|number_format:"8"}</td>
        {assign var=percentage2 value=0}
    </tr>
    </tbody>
  </table>
{include file="global/block_footer.tpl"}
