From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 07 Jul 2016 08:04:41 +0800
Subject: [PATCH -next] ARM: dts: sun8i: Add NFC node to Allwinner A23/A33
 SoC
In-Reply-To: <20160706202932.GD4247@lukather>
References: <20160706003352.28194-1-icenowy@aosc.xyz>
 <20160706202932.GD4247@lukather>
Message-ID: <34841467849881@web8m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



07.07.2016, 04:29, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Wed, Jul 06, 2016 at 08:33:52AM +0800, Icenowy Zheng wrote:
>> ?Add NAND Flash controller node definition to the A23/A33 SoC.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> Has this ever been tested? On what board, with what NAND chip?
>
>> ?---
>> ??arch/arm/boot/dts/sun8i-a23-a33.dtsi | 23 +++++++++++++++++++++++
>> ??1 file changed, 23 insertions(+)
>>
>> ?diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> ?index 7e05e09..270c38a 100644
>> ?--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> ?+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
>> ?@@ -209,6 +209,14 @@
>> ??????????????????????????????????????????"apb2_uart3", "apb2_uart4";
>> ??????????????????};
>>
>> ?+ nand_clk: clk at 01c20080 {
>> ?+ #clock-cells = <0>;
>> ?+ compatible = "allwinner,sun4i-a10-mod0-clk";
>> ?+ reg = <0x01c20080 0x4>;
>> ?+ clocks = <&osc24M>, <&pll6 1>;
>> ?+ clock-output-names = "nand";
>> ?+ };
>> ?+
>
> This should be in a separate patch.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

with a http://linux-sunxi.org/Aoson_M751s tablet, (SKhynix H27UCG8T2ETR-BC NAND chip).

I used the patchset at http://lists.infradead.org/pipermail/linux-mtd/2016-June/067848.html to ensure the NAND chip to work properly (otherwise the chip id cannot be correctly identified)
