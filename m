From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Tue, 24 May 2016 01:13:11 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q: add support for the Utilite Pro
In-Reply-To: <20abc2f6769b4369ba87ec27274a090e@rwthex-s2-a.rwth-ad.de>
References: <1463957258-4893-1-git-send-email-christopher.spinrath@rwth-aachen.de>
 <c4ab0387041f42ada68296141befe332@rwthex-s1-b.rwth-ad.de>
 <20abc2f6769b4369ba87ec27274a090e@rwthex-s2-a.rwth-ad.de>
Message-ID: <098a5b4b7b8a4ad9a5711842959c4a53@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

sorry I forgot in my last reply to mention:

On 05/23/2016 07:49 PM, Fabio Estevam wrote:

-- snip --

> 
>> +       gpio-keys {
>> +               compatible = "gpio-keys";
>> +               power {
>> +                       label = "Power Button";
>> +                       gpios = <&gpio1 29 1>;
> 
> Better to use a label like:
> gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;

Will do. Thanks!

Cheers,
Christopher

> 
>> +&iomuxc {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_hog>;
>> +
>> +       hog {
>> +               pinctrl_hog: hoggrp {
>> +                       fsl,pins = <
>> +                               /* power button */
>> +                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
> 
> Better to avoid 0x80000000. Replace it with the real iomux value
> instead so that you don't need to rely on the bootloader
> configuration.
> 
>> +
>> +       imx6q-utilite-pro {
>> +               pinctrl_i2c1: i2c1grp {
>> +                       fsl,pins = <
>> +                               MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
>> +                               MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
>> +                       >;
>> +               };
> 
> You should better remove one level of indentation. Check this commit
> for reference:
> https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6q-tbs2910.dts?h=for-next&id=aa7871b53bc3c36b4adefe67f728143e2deeec93
> 
>> +&uart2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_uart2>;
>> +       fsl,uart-has-rtscts;
>> +       dma-names = "rx", "tx";
>> +       dmas = <&sdma 27 4 0>, <&sdma 28 4 0>;
> 
> No need to add the dma nodes as they are already present in imx6qdl.dtsi.
> 
