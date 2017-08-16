From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Aug 2017 14:55:52 +0200
Subject: [PATCH v3 3/5] reset: stm32: use the reset-simple driver
In-Reply-To: <1502887920.2586.35.camel@synopsys.com>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-4-p.zabel@pengutronix.de>
 <1502887920.2586.35.camel@synopsys.com>
Message-ID: <41f0ff01-84d4-e26b-c3fe-52accb7e0443@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eugeniy,

Am 16.08.2017 um 14:52 schrieb Eugeniy Paltsev:
> On Wed, 2017-08-16 at 11:46 +0200, Philipp Zabel wrote:
>> The reset-simple driver can be used without changes.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> [snip]
>>
>> --- a/drivers/reset/reset-simple.c
>> +++ b/drivers/reset/reset-simple.c
>> @@ -120,6 +120,7 @@ static const struct reset_simple_devdata
>> reset_simple_active_low = {
>>  
>>  static const struct of_device_id reset_simple_dt_ids[] = {
>>  	{ .compatible = "altr,rst-mgr", .data =
>> &reset_simple_socfpga },
>> +	{ .compatible = "st,stm32-rcc", },
>>  	{ .compatible = "allwinner,sun6i-a31-clock-reset",
>>  		.data = &reset_simple_active_low },
>>  	{ /* sentinel */ },
> 
> What about adding generic compatible strings for future use?

Please see 1/5 for the same discussion, raised by Andre and me.

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
