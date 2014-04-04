From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 04 Apr 2014 15:02:40 +0100
Subject: [PATCH] arm: Fix DEBUG_LL for multi-platform kernels (without
 PL01X)
In-Reply-To: <8799740.0uZJLUBGY1@wuerfel>
References: <1396610269-11580-1-git-send-email-daniel.thompson@linaro.org>
 <8799740.0uZJLUBGY1@wuerfel>
Message-ID: <533EBB80.4080307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 12:39, Arnd Bergmann wrote:
>> Problem is fixed by only deploying the compatibility options for SPEAr
>> when ARCH_MULTIPLATFORM is not set.
> 
> The assumption is actually wrong: SPEAr does not support single
> platform builds any more. The PLAT_SPEAR_SINGLE symbol in Kconfig
> is a leftover from an earlier patch I did that never got merged,
> and we should just remove that.

Thanks. I did make a wrong conclusion based on that symbol.


>> ---
>>  arch/arm/Kconfig.debug | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>> index 0531da8..f10c784 100644
>> --- a/arch/arm/Kconfig.debug
>> +++ b/arch/arm/Kconfig.debug
>> @@ -991,9 +991,9 @@ config DEBUG_LL_INCLUDE
>>  config DEBUG_UART_PL01X
>>         def_bool ARCH_EP93XX || \
>>                 ARCH_INTEGRATOR || \
>> -               ARCH_SPEAR3XX || \
>> -               ARCH_SPEAR6XX || \
>> -               ARCH_SPEAR13XX || \
>> +               (ARCH_SPEAR3XX && !ARCH_MULTIPLATFORM) || \
>> +               (ARCH_SPEAR6XX && !ARCH_MULTIPLATFORM) || \
>> +               (ARCH_SPEAR13XX && !ARCH_MULTIPLATFORM) || \
>>                 ARCH_VERSATILE
> 
> Removing the SPEAR lines seems correct here, but the lines
> you add don't make any sense.

Will fix.
