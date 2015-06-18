From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Jun 2015 16:22:44 +0200
Subject: [PATCH] net/macb: add config for Atmel sama5d2 SoCs
In-Reply-To: <20150618133022.GD27492@piout.net>
References: <1434622699-2689-1-git-send-email-nicolas.ferre@atmel.com>
 <20150618133022.GD27492@piout.net>
Message-ID: <5582D434.7030906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/06/2015 15:30, Alexandre Belloni a ?crit :
> On 18/06/2015 at 12:18:19 +0200, Nicolas Ferre wrote :
>> From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>
>> Add the compatible string for Atmel sama5d2 SoC family as the configuration
>> options differ from other instances of the GEM.
>>
>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/net/ethernet/cadence/macb.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
>> index 740d04fd2223..caeb39561567 100644
>> --- a/drivers/net/ethernet/cadence/macb.c
>> +++ b/drivers/net/ethernet/cadence/macb.c
>> @@ -2713,6 +2713,13 @@ static const struct macb_config pc302gem_config = {
>>  	.init = macb_init,
>>  };
>>  
>> +static const struct macb_config sama5d2_config = {
>> +	.caps = 0,
>> +	.dma_burst_length = 16,
>> +	.clk_init = macb_clk_init,
>> +	.init = macb_init,
>> +};
>> +
>>  static const struct macb_config sama5d3_config = {
>>  	.caps = MACB_CAPS_SG_DISABLED | MACB_CAPS_GIGABIT_MODE_AVAILABLE,
>>  	.dma_burst_length = 16,
>> @@ -2756,6 +2763,7 @@ static const struct of_device_id macb_dt_ids[] = {
>>  	{ .compatible = "cdns,macb" },
>>  	{ .compatible = "cdns,pc302-gem", .data = &pc302gem_config },
>>  	{ .compatible = "cdns,gem", .data = &pc302gem_config },
>> +	{ .compatible = "atmel,sama5d2-gem", .data = &sama5d2_config },
> 
> This compatible has to be documented

Sure, I re-send a series right now (and add some documentation fixes).

Thanks, bye,

> 
>>  	{ .compatible = "atmel,sama5d3-gem", .data = &sama5d3_config },
>>  	{ .compatible = "atmel,sama5d4-gem", .data = &sama5d4_config },
>>  	{ .compatible = "cdns,at91rm9200-emac", .data = &emac_config },
>> -- 
>> 2.1.3
>>
> 


-- 
Nicolas Ferre
