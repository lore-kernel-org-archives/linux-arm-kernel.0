From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 15 Oct 2015 13:29:11 +0200
Subject: [PATCH 2/7] includes: dt-bindings: Add STM32F429 pinctrl DT
 bindings
In-Reply-To: <561F8AB3.9010103@linaro.org>
References: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1444853247-31114-3-git-send-email-mcoquelin.stm32@gmail.com>
 <561F8AB3.9010103@linaro.org>
Message-ID: <CALszF6Aj3xBqVKWhyBc5ihqm_YVTq4M3bidB0W+1RvtMVZqaDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-15 13:14 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 14/10/15 21:07, Maxime Coquelin wrote:
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>   include/dt-bindings/pinctrl/pinctrl-stm32.h     |   12 +
>>   include/dt-bindings/pinctrl/stm32f429-pinfunc.h | 1241
>> +++++++++++++++++++++++
>>   2 files changed, 1253 insertions(+)
>>   create mode 100644 include/dt-bindings/pinctrl/pinctrl-stm32.h
>>   create mode 100644 include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>>
>> diff --git a/include/dt-bindings/pinctrl/pinctrl-stm32.h
>> b/include/dt-bindings/pinctrl/pinctrl-stm32.h
>> new file mode 100644
>> index 0000000..a2e7222
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/pinctrl-stm32.h
>> @@ -0,0 +1,12 @@
>> +#ifndef _DT_BINDINGS_PINCTRL_STM32_H
>> +#define _DT_BINDINGS_PINCTRL_STM32_H
>> +
>> +#define STM32_PIN_NO(x) ((x) << 8)
>> +#define STM32_GET_PIN_NO(x) ((x) >> 8)
>> +#define STM32_GET_PIN_FUNC(x) ((x) & 0xff)
>> +
>> +#define STM32_PIN_GPIO         0
>> +#define STM32_PIN_AF(x)                ((x) + 1)
>> +#define STM32_PIN_ANALOG       (STM32_PIN_AF(15) + 1)
>> +
>> +#endif /* _DT_BINDINGS_PINCTRL_STM32_H */
>> diff --git a/include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>> b/include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>> new file mode 100644
>> index 0000000..979e4eb
>> --- /dev/null
>> +++ b/include/dt-bindings/pinctrl/stm32f429-pinfunc.h
>> @@ -0,0 +1,1241 @@
>> +#ifndef _DT_BINDINGS_STM32F429_PINFUNC_H
>> +#define _DT_BINDINGS_STM32F429_PINFUNC_H
>> +
>> +#include <dt-bindings/pinctrl/pinctrl-stm32.h>
>> +
>> +#define STM32F429_PA0_FUNC_GPIO (STM32_PIN_NO(0) | STM32_PIN_GPIO)
>> +#define STM32F429_PA0_FUNC_TIM2_CH1 TIM2_ETR (STM32_PIN_NO(0) |
>> STM32_PIN_AF(1))
>
>
> For the clock driver I was advised to get rid of this sort of "heroics" and
> expose raw numbers from the datasheet directly to DT bindings users.
>
> Should the same logic apply to this *huge* collection of macros?

I'm open to change, I just took example on the Mediatek implementation.
Advantage is that checkpatch will be more silent, drawback is that it
will be a little harder to understand how these values are generated.
If we decide to change to raw values, then the DT Bindings
documentation will need to be more verbose on the way these values are
generated.

Note that it will not be painful, as I can generate them from a script.

Regards,
Maxime
