From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 27 Mar 2013 11:36:47 -0700
Subject: [PATCH v2 4/4] ARM: dts: Add adc and thermistors for
 exynos5250-snow
In-Reply-To: <CAHfPSqDnbfmHVeuDeDFZearm1sSVA9YsJ5668iwtKHUt_gEDRw@mail.gmail.com>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-5-git-send-email-dianders@chromium.org>
 <CAHfPSqDmu52D42qiGM4rT3qeYWu0b5jxOOCNOXLa=1JZH4j9rw@mail.gmail.com>
 <CAHfPSqDnbfmHVeuDeDFZearm1sSVA9YsJ5668iwtKHUt_gEDRw@mail.gmail.com>
Message-ID: <CAHfPSqCNvX6PhWPYOh8whjV=TmOwy5B7FX0QAno_cfghYGx5_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2013 08:42, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
> On 15 March 2013 15:54, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
>> Doug,
>>
>> On 14 March 2013 02:10, Doug Anderson <dianders@chromium.org> wrote:
>>> Hook up the exynos5250-snow thermistors via the device tree now that
>>> there's a driver available to use them.
>>>
>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> used these changes to test on snow before submitting the ADC and NTC
> driver changes.
Kukjin, Any update on this patch. you want us to rebase it ?

>>> ---
>>> Changes in v2:
>>> - Match 'uV' -> 'uv' change in Naveen's bindings.
>>>
>>>  arch/arm/boot/dts/cros5250-common.dtsi |  4 ++++
>>>  arch/arm/boot/dts/exynos5250-snow.dts  | 31 +++++++++++++++++++++++++++++++
>>>  2 files changed, 35 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
>>> index 46c0980..f7cc835 100644
>>> --- a/arch/arm/boot/dts/cros5250-common.dtsi
>>> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
>>> @@ -167,6 +167,10 @@
>>>                 status = "disabled";
>>>         };
>>>
>>> +       adc at 12D10000 {
>>> +               vdd-supply = <&buck5_reg>;
>>> +       };
>>> +
>>>         hdmi {
>>>                 hpd-gpio = <&gpx3 7 0xf 1 3>;
>>>         };
>>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
>>> index 17dd951..b78da7c 100644
>>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>>> @@ -40,4 +40,35 @@
>>>                                 <&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
>>>                 };
>>>         };
>>> +
>>> +       adc at 12D10000 {
>>> +               ncp15wb473 at 3 {
>>> +                       compatible = "ntc,ncp15wb473";
>>> +                       pullup-uv = <1800000>;
>>> +                       pullup-ohm = <47000>;
>>> +                       pulldown-ohm = <0>;
>>> +                       io-channels = <&adc 3>;
>>> +               };
>>> +               ncp15wb473 at 4 {
>>> +                       compatible = "ntc,ncp15wb473";
>>> +                       pullup-uv = <1800000>;
>>> +                       pullup-ohm = <47000>;
>>> +                       pulldown-ohm = <0>;
>>> +                       io-channels = <&adc 4>;
>>> +               };
>>> +               ncp15wb473 at 5 {
>>> +                       compatible = "ntc,ncp15wb473";
>>> +                       pullup-uv = <1800000>;
>>> +                       pullup-ohm = <47000>;
>>> +                       pulldown-ohm = <0>;
>>> +                       io-channels = <&adc 5>;
>>> +               };
>>> +               ncp15wb473 at 6 {
>>> +                       compatible = "ntc,ncp15wb473";
>>> +                       pullup-uv = <1800000>;
>>> +                       pullup-ohm = <47000>;
>>> +                       pulldown-ohm = <0>;
>>> +                       io-channels = <&adc 6>;
>>> +               };
>>> +       };
>>>  };
>> Thanks for the upload, i've tested with a similar changes.
>>> --
>>> 1.8.1.3
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>
>> --
>> Shine bright,
>> (: Nav :)
>
>
>
> --
> Shine bright,
> (: Nav :)



--
Shine bright,
(: Nav :)
