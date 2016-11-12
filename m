From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 12 Nov 2016 14:46:47 +0800
Subject: [PATCH 09/10] ARM: dts: sun8i-h3: Add device nodes for audio codec
 and its analog controls
In-Reply-To: <20161112064648.26779-1-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
Message-ID: <20161112064648.26779-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we support the audio codec found on the Allwinner H3 SoC, add
device nodes for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index c38b028cac83..ceec979f57e4 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -485,6 +485,20 @@
 			status = "disabled";
 		};
 
+		codec: codec at 01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-h3-codec";
+			reg = <0x01c22c00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -600,6 +614,11 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog at 01f015c0 {
+			compatible = "allwinner,sun8i-h3-codec-analog";
+			reg = <0x01f015c0 0x4>;
+		};
+
 		ir: ir at 01f02000 {
 			compatible = "allwinner,sun5i-a13-ir";
 			clocks = <&apb0_gates 1>, <&ir_clk>;
-- 
2.10.2
