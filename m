From: codekipper@gmail.com (Code Kipper)
Date: Tue, 20 Dec 2016 16:56:13 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun4i: A1000: add axp209 regulator
 nodes
In-Reply-To: <20161220141613.czhs54laqpovidej@lukather>
References: <20161220102242.2423-1-codekipper@gmail.com>
 <20161220141613.czhs54laqpovidej@lukather>
Message-ID: <CAEKpxB=1dew+R0S2xRL0Xk1aa1wKq0Ukmr+XGyJfWER7QZso6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 December 2016 at 15:16, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Dec 20, 2016 at 11:22:42AM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> This patch adds the regulator nodes for the axp209 by including
>> the axp209 dtsi.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun4i-a10-a1000.dts | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> index 68c6bdb2cf7c..e7394d701856 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
>> @@ -196,6 +196,40 @@
>>       };
>>  };
>>
>> +#include "axp209.dtsi"
>> +
>> +&reg_dcdc2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1000000>;
>> +     regulator-max-microvolt = <1400000>;
>> +     regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc3 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <1000000>;
>> +     regulator-max-microvolt = <1250000>;
>> +     regulator-name = "vdd-int-dll";
>> +};
>> +
>> +&reg_ldo1 {
>> +     regulator-name = "vdd-rtc";
>> +};
>> +
>> +&reg_ldo2 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <3000000>;
>> +     regulator-max-microvolt = <3000000>;
>> +     regulator-name = "avcc";
>> +};
>> +
>> +&reg_ldo3 {
>> +     regulator-always-on;
>> +     regulator-min-microvolt = <2800000>;
>> +     regulator-max-microvolt = <2800000>;
>> +     regulator-name = "vcc-wifi";
>
> If this is used only for the wifi, there's no point in keeping it
> enabled.
>
> Also, taking the chance to enable cpufreq by setting the cpu-suplly
> property would be a good idea.
Ack....fortunately my A1000 was out of it's box as I've been looking
at the channel reversal issue. I'll respin now.
CK
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
