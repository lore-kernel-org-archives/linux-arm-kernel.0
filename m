From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 25 Jun 2016 19:59:23 -0700
Subject: [PATCH] ARM: dts: sun7i: Add BCM53125 Device Tree nodes
In-Reply-To: <CAGb2v64u74cXG0R-MSMtDBxBpg2tFoifQwqbvWL-+3pG=GLVTQ@mail.gmail.com>
References: <1465690459-30751-1-git-send-email-f.fainelli@gmail.com>
 <1465690459-30751-2-git-send-email-f.fainelli@gmail.com>
 <CAGb2v64u74cXG0R-MSMtDBxBpg2tFoifQwqbvWL-+3pG=GLVTQ@mail.gmail.com>
Message-ID: <576F450B.3080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/06/2016 22:48, Chen-Yu Tsai a ?crit :
>> diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> index 5ee43d8bf174..697582397dcf 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
>> @@ -110,13 +110,67 @@
>>  &gmac {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&gmac_pins_rgmii_a>;
>> -       phy = <&phy1>;
>>         phy-mode = "rgmii";
>>         phy-supply = <&reg_gmac_3v3>;
>>         status = "okay";
>>
>> -       phy1: ethernet-phy at 1 {
>> -               reg = <1>;
>> +       fixed-link {
>> +               speed = <1000>;
>> +               full-duplex;
>> +       };
>> +
>> +       mdio1 {
> 
> mdio will suffice.

There is another label in sun7i-a20.dtsi named mdio which is for the
MDIO controller node matching allwinner,sun4i-a10-mdio, which is not the
one we want here, we want the MDIO controller associated with the
Synopsys GMAC.

> 
>> +               compatible = "snps,dwmac-mdio";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               switch: ethernet-switch at 30 {
> 
> 30 decimal or 0x30 hex? We typically use hex values here.

30 decimal, will fix that.
-- 
Florian
