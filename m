From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 29 Jan 2015 10:40:49 +0100
Subject: [PATCH] pcmcia: at91_cf: depend on !ARCH_MULTIPLATFORM
In-Reply-To: <54B63517.9030809@atmel.com>
References: <1421173685-21559-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54B63517.9030809@atmel.com>
Message-ID: <54CA0021.7000706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 14/01/2015 10:21, Nicolas Ferre a ?crit :
> Le 13/01/2015 19:28, Alexandre Belloni a ?crit :
>> Until the driver is corrected to stop including mach/at91_ramc.h and using
>> mach/io.h, it won't compile in a ARCH_MULTIPLATFORM configuration.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Arnd, Olof, Kevin,

It seems that nobody is taking this lonely patch. It can be interesting
to have it for 3.20.
So, can you please add it to the "drivers" branch so that the switch to
multi-platform is possible soon.

Here is the reference of it in patchwork:

https://patchwork.kernel.org/patch/5623391/

Tell me if it's better to ask Greg or Andrew.

Bye,

>> ---
>>  drivers/pcmcia/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
>> index 910e90bf16c6..45f67c63d385 100644
>> --- a/drivers/pcmcia/Kconfig
>> +++ b/drivers/pcmcia/Kconfig
>> @@ -276,6 +276,7 @@ config BFIN_CFPCMCIA
>>  config AT91_CF
>>  	tristate "AT91 CompactFlash Controller"
>>  	depends on PCMCIA && ARCH_AT91
>> +	depends on !ARCH_MULTIPLATFORM
>>  	help
>>  	  Say Y here to support the CompactFlash controller on AT91 chips.
>>  	  Or choose M to compile the driver as a module named "at91_cf".
>>
> 
> 


-- 
Nicolas Ferre
