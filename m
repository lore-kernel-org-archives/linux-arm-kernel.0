From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 6 Mar 2015 10:57:08 +0100
Subject: [PATCH v2 11/18] pinctrl: Add pinctrl driver for STM32 MCUs
In-Reply-To: <CACRpkdbuJ5B_GwvRXax2Y4V37ihh5e6H7=2no0fYTMZPXwDdCw@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-12-git-send-email-mcoquelin.stm32@gmail.com>
 <CACRpkdbuJ5B_GwvRXax2Y4V37ihh5e6H7=2no0fYTMZPXwDdCw@mail.gmail.com>
Message-ID: <CALszF6C2qESwxmZ=q+QKdAooQnttpv49yheAiWVUEaGWeGSubA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-06 10:24 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
> On Fri, Feb 20, 2015 at 7:01 PM, Maxime Coquelin
> <mcoquelin.stm32@gmail.com> wrote:
>
>> This driver adds pinctrl and GPIO support to STMicrolectronic's
>> STM32 family of MCUs.
>>
>> Pin muxing and GPIO handling have been tested on STM32F429
>> based Discovery board.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>
> (...)
>> +config PINCTRL_STM32
>> +       bool "STMicroelectronics STM32 pinctrl driver"
>> +       depends on OF
>> +       depends on ARCH_STM32 || COMPILE_TEST
>> +       select PINMUX
>> +       select PINCONF
>> +       select GPIOLIB_IRQCHIP
>> +       help
>> +         This selects the device tree based generic pinctrl driver for STM32.
>
> Good start! Especially that you use GPIOLIB_IRQCHIP.
>
> But this (as discussed earlier) should select GENERIC_PINCONF
>
> Stopping review here so you can reengineer it a bit using GENERIC_PINCONF
> for next submission.
>
> Also think about pinmux in single registers, whether you want to do this
> with a single value for a register or using strings to identify groups
> and functions.

Thanks for the review.
I will digest all this, and come back with another solution :)

Best regards,
Maxime

>
> Yours,
> Linus Walleij
