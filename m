From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 14 Oct 2015 15:45:00 +0200
Subject: [PATCH] arm64: dts: mt8173: add MT8173 display PWM driver support
 node
In-Reply-To: <561BDA26.5010203@gmail.com>
References: <1444117243-28391-1-git-send-email-yh.huang@mediatek.com>
 <561BDA26.5010203@gmail.com>
Message-ID: <561E5C5C.2080807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/10/15 18:04, Matthias Brugger wrote:
>
>
> On 06/10/15 09:40, YH Huang wrote:
>> Add display PWM node in mt8173-evb.dts and mt8173.dtsi.
>>
>> Signed-off-by: YH Huang <yh.huang@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   13 +++++++++++++
>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi    |   22
>> ++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>
> Applied, thanks.

I reapplied this on v4.4-next/arm64

>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> index 811cb76..1b3fabd 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> @@ -92,6 +92,13 @@
>>   };
>>
>>   &pio {
>> +    disp_pwm0_pins: disp_pwm0_pins {
>> +        pins1 {
>> +            pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
>> +            output-low;
>> +        };
>> +    };
>> +
>>       mmc0_pins_default: mmc0default {
>>           pins_cmd_dat {
>>               pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
>> @@ -190,6 +197,12 @@
>>       };
>>   };
>>
>> +&pwm0 {
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&disp_pwm0_pins>;
>> +    status = "okay";
>> +};
>> +
>>   &pwrap {
>>       pmic: mt6397 {
>>           compatible = "mediatek,mt6397";
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> index 4bce167..fd01134 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>> @@ -500,6 +500,28 @@
>>               clock-names = "source", "hclk";
>>               status = "disabled";
>>           };
>> +
>> +        pwm0: pwm at 1401e000 {
>> +            compatible = "mediatek,mt8173-disp-pwm",
>> +                     "mediatek,mt6595-disp-pwm";
>> +            reg = <0 0x1401e000 0 0x1000>;
>> +            #pwm-cells = <2>;
>> +            clocks = <&mmsys CLK_MM_DISP_PWM026M>,
>> +                 <&mmsys CLK_MM_DISP_PWM0MM>;
>> +            clock-names = "main", "mm";
>> +            status = "disabled";
>> +        };
>> +
>> +        pwm1: pwm at 1401f000 {
>> +            compatible = "mediatek,mt8173-disp-pwm",
>> +                     "mediatek,mt6595-disp-pwm";
>> +            reg = <0 0x1401f000 0 0x1000>;
>> +            #pwm-cells = <2>;
>> +            clocks = <&mmsys CLK_MM_DISP_PWM126M>,
>> +                 <&mmsys CLK_MM_DISP_PWM1MM>;
>> +            clock-names = "main", "mm";
>> +            status = "disabled";
>> +        };
>>       };
>>   };
>>
>>
