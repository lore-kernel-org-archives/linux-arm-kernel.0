From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 23 Feb 2016 21:02:16 +0900
Subject: [PATCH] ARM: dts: add support for gpio buttons for
 exynos5422-odroidxu3
In-Reply-To: <CANAwSgTRu6pb9cdA50AzBSNLS+Y+sssyc_CX7FKuV=FDYWaOsA@mail.gmail.com>
References: <1456214467-3344-1-git-send-email-linux.amoon@gmail.com>
 <56CC167A.8040303@samsung.com> <56CC194F.6080905@samsung.com>
 <CANAwSgTRu6pb9cdA50AzBSNLS+Y+sssyc_CX7FKuV=FDYWaOsA@mail.gmail.com>
Message-ID: <CAJKOXPftm7P44Zxn9rHt1THJOX3Oxu-mg5GD7=T3se4iRe1DkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-23 18:17 GMT+09:00 Anand Moon <linux.amoon@gmail.com>:
> Hi Krzysztof,
>
> On 23 February 2016 at 14:03, Krzysztof Kozlowski
>>>>      };
>>>> +
>>>> +    gpio_keys {
>>>> +            compatible = "gpio-keys";
>>>> +            pinctrl-names = "default";
>>>> +            pinctrl-0 = <&gpio_power_key>;
>>>> +
>>>> +            power_key {
>>>> +                    interrupt-parent = <&gpx0>;
>>>> +                    interrupts = <3 IRQ_TYPE_NONE>;
>>>
>>> Hmmm.... why you specify the interrupts?
>>>
>>>> +                    gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
>>
>> Please, explain it to me. The SW2 key is connected to PWRON of PMIC.
>> However you are adding a GPIO key for external interrupt source 3
>> (XE.INT3)... which comes from PMIC's ONOB.
>>
>> It's interesting.... how does it work? The PMIC will generate ONOB
>> interrupt on PWRON low->high change (when PWRHOLD is high)?
>>
>> Best regards,
>> Krzysztof
>>
>
> I have re-base my changes on HK dts.
> I could not find much details for the schematic diagram.
> I don't know much low level detains on this.

If I understand this correctly: you just took some vendor code,
similar to existing code of Odroid U3, and without full understanding
of the code nor checking with public schematics, you sent it.

Taking vendor stuff is okay but you need to think about it, use it as
an example and deliver proper solution based on that. Not copy-paste.

> How dose this works: This changes will initial the shudown/reboot on Ubuntu.
> I have also tested this similar feature on Odroid U3.

Great :), yes it works because ONOB interrupt from PMIC is generated
on key press. However this is not a strictly speaking key... I don't
really know what to do with this commit and your explanation
(Hardkernel has such code) is not sufficient to convince me.

Best regards,
Krzysztof
