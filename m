From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 1 Feb 2015 15:28:20 +0100
Subject: [PATCH v3 07/10] ARM: dts: sunxi: Add usb3_vbus regulator to
 common regulators dtsi
In-Reply-To: <20150201142007.GH4827@lukather>
References: <1422388455-25923-1-git-send-email-wens@csie.org>
 <1422388455-25923-8-git-send-email-wens@csie.org>
 <20150201142007.GH4827@lukather>
Message-ID: <CAGb2v64SaEQiJ1LYUGWj+cv_UG-oEn_gtUuoGGndGuX_pJbZWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 1, 2015 at 3:20 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Jan 28, 2015 at 03:54:12AM +0800, Chen-Yu Tsai wrote:
>> Some SoCs have a total of 4 possible USB controllers. One such example
>> is the A80, which has one USB3 dual role device and 3 EHCI/OHCI pairs.
>>
>> Add a common VBUS regulator for the last host controller.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sunxi-common-regulators.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sunxi-common-regulators.dtsi b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
>> index e02baa66b33c..97fe8d73c4f7 100644
>> --- a/arch/arm/boot/dts/sunxi-common-regulators.dtsi
>> +++ b/arch/arm/boot/dts/sunxi-common-regulators.dtsi
>> @@ -130,6 +130,16 @@
>>               status = "disabled";
>>       };
>>
>> +     reg_usb3_vbus: usb3-vbus {
>> +             compatible = "regulator-fixed";
>> +             pinctrl-names = "default";
>> +             regulator-name = "usb3-vbus";
>> +             regulator-min-microvolt = <5000000>;
>> +             regulator-max-microvolt = <5000000>;
>> +             enable-active-high;
>> +             status = "disabled";
>> +     };
>> +
>
> I don't think you replied to this one. What other SoC is using the
> USB3 regulator? Is it worth it to put it in there and bloat all the
> other DTS for something that is only used on a single board so far?

Yes I missed this one. The only other one is A31, which has OHCI2,
but no board routes it to a USB connector with a VBUS regulator.

So yeah, I'll move it to the board DTS.

ChenYu
