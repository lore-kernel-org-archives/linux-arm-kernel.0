From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun,  3 Sep 2017 17:08:52 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sun6i: a31: Add DAI nodes
Message-ID: <20170903150852.3548-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the new DAI blocks to the device tree.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index b147cb0dc14b..f3d74dc5b292 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -662,6 +662,32 @@
 			status = "disabled";
 		};
 
+		i2s0: i2s at 01c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun6i-a31-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1_DAUDIO0>, <&ccu CLK_DAUDIO0>;
+			resets = <&ccu RST_APB1_DAUDIO0>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		i2s1: i2s at 01c22400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun6i-a31-i2s";
+			reg = <0x01c22400 0x400>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1_DAUDIO1>, <&ccu CLK_DAUDIO1>;
+			resets = <&ccu RST_APB1_DAUDIO1>;
+			clock-names = "apb", "mod";
+			dmas = <&dma 4>, <&dma 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		lradc: lradc at 01c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
-- 
2.14.1
