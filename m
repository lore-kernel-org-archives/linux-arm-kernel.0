From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Sat, 30 May 2015 10:16:12 +0200
Subject: [PATCH] ARM: Kconfig: Select clocksource in STM32 entry
In-Reply-To: <5569714A.2010706@gmail.com>
References: <1432331452-2350-1-git-send-email-mcoquelin.stm32@gmail.com>
 <5569714A.2010706@gmail.com>
Message-ID: <556971CC.2060102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Daniel's valid address.

On 05/30/2015 10:14 AM, Maxime Coquelin wrote:
> Hi Arnd,
>
> On 05/22/2015 11:50 PM, Maxime Coquelin wrote:
>> STM32 clocksource driver needs to be selected if ARCH_STM32.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>> Hi Arnd,
>>
>>    This patch applies on top of arm-soc's next/soc branch, so that 
>> you don't
>> get conflicts with Stefan's ARM_SINGLE_ARMV7M patch.Hi
>>
>> Regards,
>> Maxime
>> ---
>>   arch/arm/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index b7a7d15..1cb59af 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -978,6 +978,7 @@ config ARCH_STM32
>>       depends on ARM_SINGLE_ARMV7M
>>       select ARCH_HAS_RESET_CONTROLLER
>>       select ARMV7M_SYSTICK
>> +    select CLKSRC_STM32
>>       select RESET_CONTROLLER
>>       help
>>         Support for STMicroelectronics STM32 processors.
>
> This patch is needed for STM32 to boot.
> Can you pick it for v4.2?
>
> Thanks,
> Maxime
