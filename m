From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 19 May 2015 10:55:56 +0200
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <555AF143.2060807@linaro.org>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-10-git-send-email-mcoquelin.stm32@gmail.com>
 <5559E4B0.70506@linaro.org>
 <CALszF6CK7axU0qrWNf38aqrt2R2126ZACn7wx5jNY_1KE+4H+g@mail.gmail.com>
 <555AF143.2060807@linaro.org>
Message-ID: <CALszF6CwGuKqgbX6gVrya1-_YOgvtrgC7pVqKTNjCRif_o532A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-19 10:16 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 05/18/2015 04:03 PM, Maxime Coquelin wrote:
>>
>> 2015-05-18 15:10 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>>
>>> On 05/09/2015 09:53 AM, Maxime Coquelin wrote:
>>>>
>>>>
>>>> STM32 MCUs feature 16 and 32 bits general purpose timers with
>>>> prescalers.
>>>> The drivers detects whether the time is 16 or 32 bits, and applies a
>>>> 1024 prescaler value if it is 16 bits.
>>>>
>>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>>> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>> ---
>>>>    drivers/clocksource/Kconfig       |   8 ++
>>>>    drivers/clocksource/Makefile      |   1 +
>>>>    drivers/clocksource/timer-stm32.c | 184
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 193 insertions(+)
>>>>    create mode 100644 drivers/clocksource/timer-stm32.c
>>>>
>>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>>> index bf9364c..2443520 100644
>>>> --- a/drivers/clocksource/Kconfig
>>>> +++ b/drivers/clocksource/Kconfig
>>>> @@ -106,6 +106,14 @@ config CLKSRC_EFM32
>>>>            Support to use the timers of EFM32 SoCs as clock source and
>>>> clock
>>>>            event device.
>>>>
>>>> +config CLKSRC_STM32
>>>> +       bool "Clocksource for STM32 SoCs" if !ARCH_STM32
>>>> +       depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
>>>
>>>
>>>
>>> Are the interactive bool and the 'COMPILE_TEST' necessary ?
>>>
>>
>> The interactive bool is necessary if we want to be able to
>> select/deselect it in COMPILE_TEST configuration.
>> And personnaly, I think COMPILE_TEST use makes sense.
>>
>> Note that other timer drivers are doing the same thing today
>> (CLKSRC_EFM32, SH_TIMER_CMT, EM_TIMER_STI...).
>>
>> Do you have a specific concern regarding COMPILE_TEST?
>
>
> Actually, we try to keep the timer selection non-interactive and let the
> platform's Kconfig to select the timer.

Ok.

>
> I like when the code is consistent. The COMPILE_TEST was introduced and
> created a precedence. I would like to get rid of the interactive timer
> selection but I did not have time to go through this yet.

Indeed, consistency is important.
On my side, I don't have a strong opinion regarding the COMPILE_TEST thing.
IMHO, it is more a subsystem's maintainer choice.

So, if as a maintainer you don't use it and prefer not supporting it,
I'm fine to provide you a new version without COMPILE_TEST.
Doing that, the interactive selection will disappear too.

I can provide you a new version this evenning.

Best regards,
Maxime

>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
