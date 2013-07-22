From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Mon, 22 Jul 2013 21:36:42 +0200
Subject: [PATCH 1/1] ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos
In-Reply-To: <3136364.6D0qu7zGk3@amdc1227>
References: <1372054438-15693-1-git-send-email-sachin.kamat@linaro.org>
 <CAK9yfHzmF_oxc3DsuT5wtXX2C5O+wLxz4C2Ps3cVPnKLb8jOEw@mail.gmail.com>
 <0ad601ce868c$d88bff40$89a3fdc0$@org> <3136364.6D0qu7zGk3@amdc1227>
Message-ID: <51ED89CA.2040908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 07:21 PM, Tomasz Figa wrote:
> On Monday 22 of July 2013 12:37:52 Kukjin Kim wrote:
>> Sachin Kamat wrote:
>>> On 22 July 2013 07:18, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>>>> Sachin Kamat wrote:
>>>>> With the recent cleanup in Exynos platform code notably commits
>>>>> 17859bec ("ARM: EXYNOS: Do not select legacy Kconfig symbols any
>>>>> more") and b9222210 ("ARM: EXYNOS: Remove mach/gpio.h"), the
>>>>> definition
>>>>> of ARCH_NR_GPIOS got removed. This started causing problems on SoCs
>>>
>>> like
>>>
>>>>> Exynos4412 which have more (285) than the default number of GPIOs
>>
>> (255).
>>
>>>>> Thus define this number in Kconfig file. Without this patch we get
>>>>> the
>>>>> following errors during boot:
>>>>>
>>>>> gpiochip_add: gpios 251..258 (gpv0) failed to register
>>>>> samsung-pinctrl 106e0000.pinctrl: failed to register gpio_chip gpv0,
>>>>> error code: -22
>>>>> samsung-pinctrl: probe of 106e0000.pinctrl failed with error -22
>>>>>
>>>>> Signed-off-by: Sachin Kamat<sachin.kamat@linaro.org>
>>>>> Cc: Tomasz Figa<t.figa@samsung.com>
>>>>> ---
>>>>> Based on Kukjin's for-next tree.
>>>>> ---
>>>>>
>>>>>   arch/arm/Kconfig |    1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index ddf2667..380a53b 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -1578,6 +1578,7 @@ config ARCH_NR_GPIO
>>>>>
>>>>>        default 512 if SOC_OMAP5
>>>>>        default 392 if ARCH_U8500
>>>>>        default 352 if ARCH_VT8500
>>>>>
>>>>> +     default 288 if ARCH_EXYNOS
>>>>>
>>>>>        default 288 if ARCH_SUNXI
>>>>>        default 264 if MACH_H4700
>>>>>        default 0
>>>>>
>>>>> --
>>>>> 1.7.9.5
>>>>
>>>> Hmm, BTW, I'm wondering why it is 288 not 285 or other specific
>>
>> number...
>>
>>> I wasn't really sure if we can have any number there. I chose the
>>> closest one (288) which was already used by other platform.
>>> If there is no problem to use 285 itself then I can resend with that
>>> number. Please let me know.
>>
>> If there is no reason, please don't use bigger value than necessary one.
>
> Hmm, what about some GPIO expanders that would require bigger GPIO address
> space? I would reserve some space just in case, i.e. define this value to be
> the highest number of GPIOs on all Exynos SoCs + some extra, like 32 or 64.

That sounds like a good idea. IIRC I once had to increase ARCH_NR_GPIO to
make the wm8994 GPIO controller working. The wm8994 driver also handles
WM1811 audio codec that some Exynos development boards are shipped with.

--
Regards,
Sylwester
