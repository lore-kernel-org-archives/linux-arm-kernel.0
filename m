From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 18 Aug 2015 11:43:28 +0530
Subject: [2/2] ARM: dts: Add missing irq pinctrl for max77686 on smdk5250
In-Reply-To: <CAJKOXPdzhqXFWT0=eXpr+jjs8R4kFAMq2DSSsFHVEZq_PdAN2w@mail.gmail.com>
References: <1416312509-11530-2-git-send-email-yadi.brar@samsung.com>
 <553F68CC.6030504@samsung.com> <5544657A.7010006@gmail.com>
 <CAJKOXPdzhqXFWT0=eXpr+jjs8R4kFAMq2DSSsFHVEZq_PdAN2w@mail.gmail.com>
Message-ID: <55D2CD08.7050106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Monday 17 August 2015 11:20 AM, Krzysztof Kozlowski wrote:
> 2015-05-02 14:49 GMT+09:00 Krzysztof Kozlowski <k.kozlowski.k@gmail.com>:
>> W dniu 28.04.2015 o 20:02, Pankaj Dubey pisze:
>>> Hi Kukjin,
>>>
>>> Any updated for this patch. Without this PMIC RTC is not working on
>>> SMDK5250.
>>>
>>
>> Could you resend the patch after rebasing it?
>>
>> Best regards,
>> Krzysztof
>
> Dear Pankaj and Yadwinder,
>
> Do you plan to do anything with this patch?
>

Thanks for reminding us. Somehow I missed this.
I will resend the patch shortly after rebasing and testing.

Thanks,
Pankaj Dubey

> Best regards,
> Krzysztof
>
>
>>> Thanks,
>>> Pankaj Dubey
>>>
>>> On Tuesday 18 November 2014 05:38 PM, Yadwinder Singh Brar wrote:
>>>> This patch adds pinctrl configuration for using configuring gpx3-2 as an
>>>> external interrupt from max77686. Though max77686 RTC is enabled and gets
>>>> probed by default, it doesnt work as its unable to get interrupt.
>>>>
>>>> This patch makes max77686 RTC work and also configures it as wakeup
>>>> source.
>>>>
>>>> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
>>>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>>
>>>> ---
>>>> arch/arm/boot/dts/exynos5250-smdk5250.dts |   12 ++++++++++++
>>>>    1 files changed, 12 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>>>> b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>>>> index 95b5b51..19cd918 100644
>>>> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
>>>> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
>>>> @@ -131,6 +131,9 @@
>>>>            reg = <0x09>;
>>>>            interrupt-parent = <&gpx3>;
>>>>            interrupts = <2 IRQ_TYPE_NONE>;
>>>> +        pinctrl-names = "default";
>>>> +        pinctrl-0 = <&max77686_irq>;
>>>> +        wakeup-source;
>>>>
>>>>            voltage-regulators {
>>>>                ldo1_reg: LDO1 {
>>>> @@ -411,3 +414,12 @@
>>>>            };
>>>>        };
>>>>    };
>>>> +
>>>> +&pinctrl_0 {
>>>> +    max77686_irq: max77686-irq {
>>>> +        samsung,pins = "gpx3-2";
>>>> +        samsung,pin-function = <0xf>;
>>>> +        samsung,pin-pud = <0>;
>>>> +        samsung,pin-drv = <0>;
>>>> +    };
>>>> +};
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> linux-samsung-soc" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
