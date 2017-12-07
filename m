From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Thu, 7 Dec 2017 17:34:03 +0100
Subject: [PATCH v2] clocksource: tcb_clksrc: Fix clock speed message
In-Reply-To: <6f3d309e-2e71-3f60-5910-0d8b1f051836@linaro.org>
References: <20171201122233.21828-1-romain.izard.pro@gmail.com>
 <6f3d309e-2e71-3f60-5910-0d8b1f051836@linaro.org>
Message-ID: <99fd8a35-9522-bb80-9aea-e4c266cdbc62@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2017 at 12:01, Daniel Lezcano wrote:
> On 01/12/2017 13:22, Romain Izard wrote:
>> The clock speed displayed at boot in an information message was 500 kHz
>> too high compared to its real value. As the value is not used anywhere,
>> there is no functional impact.
>>
>> Fix the rounding formula to display the correct value.
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>> v2: rebase over v4.15-rc1
>>
>> There is no specified maintainer for this file, only supporters.
> 
> That is not correct, it defaults to Thomas and me, the maintainers of
> drivers/clocksource :)
> 
>> Nicolas, could you pick this through the at91 tree as the TCB block
>> is an AT91 peripheral ?
> 
> Nicolas, do you agree with this change ? If yes, I will take it.

Yes, fine with me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Daniel for the "heads-up".

Best regards,
  Nicolas

>>  drivers/clocksource/tcb_clksrc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
>> index 9de47d4d2d9e..43f4d5c4d6fa 100644
>> --- a/drivers/clocksource/tcb_clksrc.c
>> +++ b/drivers/clocksource/tcb_clksrc.c
>> @@ -384,7 +384,7 @@ static int __init tcb_clksrc_init(void)
>>  
>>  	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
>>  			divided_rate / 1000000,
>> -			((divided_rate + 500000) % 1000000) / 1000);
>> +			((divided_rate % 1000000) + 500) / 1000);
>>  	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
>>  		/* use apropriate function to read 32 bit counter */
>>
> 
> 


-- 
Nicolas Ferre
