From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Jul 2013 19:58:57 +0530
Subject: [PATCH] ARM: omap2: add select of TI_PRIV_EDMA
In-Reply-To: <20130710075017.GM5523@atomide.com>
References: <1373359054-5007-1-git-send-email-olof@lixom.net>
 <20130710075017.GM5523@atomide.com>
Message-ID: <51DD6FA9.8080908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/10/2013 1:20 PM, Tony Lindgren wrote:
> * Olof Johansson <olof@lixom.net> [130709 01:44]:
>> "ARM: OMAP: build mach-omap code only if needed" moved around the
>> ARCH_OMAP2PLUS stanza, but accidentally dropped the seleciton of
>> TI_PRIV_EDMA in the process. Add it back.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
>> Signed-off-by: Olof Johansson <olof@lixom.net>

Thinking more, I do not think we should be selecting TI_PRIV_EDMA for
OMAP2PLUS. There is no part of mach-omap2 that depends directly on
TI_PRIV_EDMA being enabled.

Instead, TI_PRIV_EDMA should be selected by the DMA engine driver as
done in the patch here:

http://www.spinics.net/lists/kernel/msg1563777.html

Its the DMA engine driver which makes the private DMA calls so this
patch is better.

Thanks,
Sekhar

>>
>> ---
>>
>> I noticed the original patch was a bit down in the fixes branch, so
>> instead of rebasing I checked this in on top.
>>
>> -Olof
>>
>>  arch/arm/mach-omap2/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index 5c14051..58152b1 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -99,6 +99,7 @@ config ARCH_OMAP2PLUS
>>  	select PROC_DEVICETREE if PROC_FS
>>  	select SOC_BUS
>>  	select SPARSE_IRQ
>> +	select TI_PRIV_EDMA
>>  	select USE_OF
>>  	help
>>  	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
>> -- 
>> 1.8.1.192.gc4361b8
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
