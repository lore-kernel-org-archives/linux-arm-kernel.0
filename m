From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 10 Aug 2016 09:29:11 +0100
Subject: [PATCH] ARM: no need to select SMP_ON_UP explicitly
In-Reply-To: <20160809084416.GS4678@tiger>
References: <1469199369-25746-1-git-send-email-vladimir.murzin@arm.com>
 <20160809084416.GS4678@tiger>
Message-ID: <57AAE5D7.2080009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/16 09:44, Shawn Guo wrote:
> On Fri, Jul 22, 2016 at 03:56:09PM +0100, Vladimir Murzin wrote:
>> SMP_ON_UP is already defaulted to "y" and has all dependencies expressed
>> - no need to select it per platform level
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>
>> This time sent to LAKML
>>
>>  arch/arm/mach-imx/Kconfig      |    3 ---
>>  arch/arm/mach-realview/Kconfig |    1 -
> 
> I cannot take mach-realview changes.  I think you need to ether split
> the changes, or ask arm-soc folks to apply.  In case of the latter, here
> is my ACK:
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Thanks!

RealView is not mentioned under MAINTAINERS, so it'd be easier if
arm-soc team pick this patch.

Arnd, what is your preference?

Cheers
Vladimir

> 
>>  2 files changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
>> index dd905b9..cfb1120 100644
>> --- a/arch/arm/mach-imx/Kconfig
>> +++ b/arch/arm/mach-imx/Kconfig
>> @@ -92,7 +92,6 @@ config SOC_IMX31
>>  	select CPU_V6
>>  	select IMX_HAVE_PLATFORM_MXC_RNGA
>>  	select MXC_AVIC
>> -	select SMP_ON_UP if SMP
>>  
>>  config SOC_IMX35
>>  	bool
>> @@ -100,7 +99,6 @@ config SOC_IMX35
>>  	select HAVE_EPIT
>>  	select MXC_AVIC
>>  	select PINCTRL_IMX35
>> -	select SMP_ON_UP if SMP
>>  
>>  if ARCH_MULTI_V4T
>>  
>> @@ -589,7 +587,6 @@ config SOC_VF610
>>  	select ARM_GIC if ARCH_MULTI_V7
>>  	select PINCTRL_VF610
>>  	select PL310_ERRATA_769419 if CACHE_L2X0
>> -	select SMP_ON_UP if SMP
>>  
>>  	help
>>  	  This enables support for Freescale Vybrid VF610 processor.
>> diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
>> index 70ab4a2..739800e 100644
>> --- a/arch/arm/mach-realview/Kconfig
>> +++ b/arch/arm/mach-realview/Kconfig
>> @@ -24,7 +24,6 @@ config REALVIEW_DT
>>  	select POWER_RESET
>>  	select POWER_RESET_VERSATILE
>>  	select POWER_SUPPLY
>> -	select SMP_ON_UP if SMP
>>  	select SOC_REALVIEW
>>  	select USE_OF
>>  	help
>> -- 
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
