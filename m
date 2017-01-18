From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 18 Jan 2017 12:16:44 +0100
Subject: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
In-Reply-To: <20170118101628.GG18989@ulmo.ba.sec>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
 <20170118101628.GG18989@ulmo.ba.sec>
Message-ID: <CA+M3ks4NKApD-FGY9=KGcngA2aaiLop8QFtbVmgz2yeOSo7E=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-18 11:16 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
> [...]
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index f92dd41..88035c0 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -397,6 +397,15 @@ config PWM_STI
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-sti.
>>
>> +config PWM_STM32
>> +     tristate "STMicroelectronics STM32 PWM"
>> +     depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
>
> One other thing: is the dependency on ARCH_STM32 and OF necessary here?
> ARCH_STM32 and OF are both pulled in by MFD_STM32_TIMERS. The dependency
> is probably fine for MFD_STM32_TIMERS, though even there && OF seems too
> much, since it's already pulled in via ARCH_STM32 -> ARM_SINGLE_ARMV7M
> -> USE_OF.

Said like that MFD_STM32_TIMERS is enough so I will keep this one

Thanks

>
> Thierry



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
