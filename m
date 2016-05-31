From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 31 May 2016 21:28:18 +0200
Subject: [PATCH 4/6] ARM: dts: exynos: Add Thermal Management Unit to
 Exynos5410
In-Reply-To: <25549eaa-a286-7579-8407-411f0c1834ae@osg.samsung.com>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-4-git-send-email-krzk@kernel.org>
 <25549eaa-a286-7579-8407-411f0c1834ae@osg.samsung.com>
Message-ID: <CAJKOXPeDw4BQm8HU0Pe1f1=5C8kHa_ZXGbYZR=o7Ah0mZX1H=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 9:21 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Krzysztof,
>
> On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
>> Add nodes for Thermal Management Unit to exynos5410.dtsi. Use the same
>> compatible as for Exynos5420 however without second base for TRIMINFO
>> register.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  arch/arm/boot/dts/exynos5410.dtsi | 55 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
>> index 994d16a44fe4..f1effd3f03c4 100644
>> --- a/arch/arm/boot/dts/exynos5410.dtsi
>> +++ b/arch/arm/boot/dts/exynos5410.dtsi
>> @@ -81,6 +81,42 @@
>>                       #clock-cells = <1>;
>>               };
>>
>> +             tmu_cpu0: tmu at 10060000 {
>> +                     compatible = "samsung,exynos5420-tmu";
>> +                     reg = <0x10060000 0x100>;
>> +                     interrupts = <0 65 0>;
>
> Please use GIC_SPI instead of 0 on these.

ok

>
>> +                     clocks = <&clock CLK_TMU>;
>> +                     clock-names = "tmu_apbif";
>> +                     #include "exynos4412-tmu-sensor-conf.dtsi"
>> +             };
>> +
>> +             tmu_cpu1: tmu at 10064000 {
>> +                     compatible = "samsung,exynos5420-tmu";
>> +                     reg = <0x10064000 0x100>;
>> +                     interrupts = <0 183 0>;
>> +                     clocks = <&clock CLK_TMU>;
>> +                     clock-names = "tmu_apbif";
>> +                     #include "exynos4412-tmu-sensor-conf.dtsi"
>> +             };
>> +
>> +             tmu_cpu2: tmu at 10068000 {
>> +                     compatible = "samsung,exynos5420-tmu";
>> +                     reg = <0x10068000 0x100>;
>> +                     interrupts = <0 184 0>;
>> +                     clocks = <&clock CLK_TMU>;
>> +                     clock-names = "tmu_apbif";
>> +                     #include "exynos4412-tmu-sensor-conf.dtsi"
>> +             };
>> +
>> +             tmu_cpu3: tmu at 1006c000 {
>> +                     compatible = "samsung,exynos5420-tmu";
>> +                     reg = <0x1006c000 0x100>;
>> +                     interrupts = <0 185 0>;
>> +                     clocks = <&clock CLK_TMU>;
>> +                     clock-names = "tmu_apbif";
>> +                     #include "exynos4412-tmu-sensor-conf.dtsi"
>> +             };
>> +
>
> Exynos5420 has 5 TMU channels and you are adding only 4 so I guess this
> is another difference with Exynos5410 besides the TRIMINFO register not
> being misplaced? Probably is worth to mention it in the commit message.


Yes, indeed there is no GPU thermal zone. I'll mention it.

Best regards,
Krzysztof
