From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Thu, 23 Nov 2017 11:28:52 -0500
Subject: [PATCH v2 2/2] ARM: dts: TS-7970: add basic device tree
In-Reply-To: <CAOMZO5CzXo63fbFZWE-KR1FC7VQ4DzKvR-SdDmp+5L5+=Rd10Q@mail.gmail.com>
References: <20171122203233.2649-1-sebastien.bourdelin@savoirfairelinux.com>
 <20171122203233.2649-2-sebastien.bourdelin@savoirfairelinux.com>
 <CAOMZO5CzXo63fbFZWE-KR1FC7VQ4DzKvR-SdDmp+5L5+=Rd10Q@mail.gmail.com>
Message-ID: <20977491-3a0a-1136-e35f-7b5c47dcfe18@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 11/22/2017 03:48 PM, Fabio Estevam wrote:
> On Wed, Nov 22, 2017 at 6:32 PM, Sebastien Bourdelin
> <sebastien.bourdelin@savoirfairelinux.com> wrote:
> 
>> +/dts-v1/;
>> +#include "imx6q.dtsi"
>> +#include "imx6qdl-ts7970.dtsi"
>> +
>> +/ {
>> +       model = "Technologic Systems i.MX6 Quad TS-7970 (Default Devuice Tree)";
> 
> Typo: Devuice--> Device
Thanks!
> 
>> +       reg_can1_3v3: reg_can1_3v3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "reg_can1_3v3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> 
> Are you sure this is GPIO_ACTIVE_HIGH?
> 
> If so, then it would need the 'enable-active-high' property.
Ok
> 
> 
>> +       };
>> +
>> +       reg_can2_3v3: en-reg_can2_3v3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "reg_can2_3v3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               gpio = <&gpio6 31 GPIO_ACTIVE_HIGH>;
> 
> Same here.
Ok
> 
>> +
>> +&fec {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_enet>;
>> +       interrupts-extended = <&gpio1 6 0x04>, <&gpc 0 119 0x04>;
> 
> I think you meant to say:
> 
> interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
>       <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> fsl,err006687-workaround-present;
Nice for the workaround, thanks!

> 
>> +&pcie {
>> +       reset-gpio = <&gpio2 21 GPIO_ACTIVE_HIGH>;
> 
> Are you sure it is GPIO_ACTIVE_HIGH? if so, it would need a
> reset-gpio-active-high property.
> 
> Most likely this should be:
> 
> reset-gpio = <&gpio2 21 GPIO_ACTIVE_LOW>;
> 
I have difficulties to verify this information, i will remove it unless
Mark Featherston can confirm it.

Thanks for your review Fabio!
