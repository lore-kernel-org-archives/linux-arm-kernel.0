From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 25 Aug 2015 23:03:29 +0200
Subject: [PATCH] ARM: stm32: Reduce FORCE_MAX_ZONEORDER to 9
In-Reply-To: <3551937.qa4lRhD8e3@wuerfel>
References: <1440533237-5831-1-git-send-email-mcoquelin.stm32@gmail.com>
 <3551937.qa4lRhD8e3@wuerfel>
Message-ID: <55DCD821.5040600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/25/2015 10:36 PM, Arnd Bergmann wrote:
> On Tuesday 25 August 2015 22:07:17 Maxime Coquelin wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a750c14..57d53af 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1734,7 +1734,7 @@ config FORCE_MAX_ZONEORDER
>>          int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
>>          range 11 64 if ARCH_SHMOBILE_LEGACY
>>          default "12" if SOC_AM33XX
>> -       default "9" if SA1111 || ARCH_EFM32
>> +       default "9" if SA1111 || ARCH_EFM32 || ARCH_STM32
>>          default "11"
>>
> This looks wrong now that we can enable multiple ARMV7M platforms
> together. In practice it doesn't matter much, because you wouldn't
> do that for a real-life system, but out of principle this seems
> like something you'd better put into the defconfig file for
> both ARCH_EFM32 and ARCH_STM32. We could also think about changing
> the default to "9" for any ARM_SINGLE_ARMV7M config and increasing
> it again in defconfig for any platform that actually has a lot of
> RAM (if any).
>

Both proposals seem reasonable.
I propose to make this entry configurable in defconfig if ARM_SINGLE_ARMV7M,
keeping the default to 11. Then, in efm32 and stm32 defconfig files, 
select value 9.

Uwe, is it ok for you?

Regards,
Maxime
