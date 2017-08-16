From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 16 Aug 2017 14:03:57 +0100
Subject: [PATCH v3 3/5] reset: stm32: use the reset-simple driver
In-Reply-To: <1502887920.2586.35.camel@synopsys.com>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-4-p.zabel@pengutronix.de>
 <1502887920.2586.35.camel@synopsys.com>
Message-ID: <eed2f3aa-be3b-76fd-41cb-f1f88ff36cdc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/08/17 13:52, Eugeniy Paltsev wrote:
> Hi Philipp,
> 
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

Exactly ;-) (see my previous email)
But we still need the pre-existing strings in here, of course.

> I mean next:
> 
> --------------------->8---------------------
> 
> static const struct of_device_id reset_simple_dt_ids[] = {
> 	{ .compatible = "reset-simple-active-low",
> 		.data = &reset_simple_active_low },
> 	{ .compatible = "reset-simple-active-high",
> 		.data = &reset_simple_active_high },

Either that or maybe even better define a "simple-reset" string and add
standard properties like "active-low".

Cheers,
Andre.

> 	/* ... */
> 	{ /* sentinel */ },
> };
> 
> static const struct reset_simple_devdata reset_simple_active_high = {
> 	.active_low = false,
> };
> 
> static const struct reset_simple_devdata reset_simple_active_low = {
> 	.active_low = true,
> };
> 
> --------------------->8---------------------
> 
