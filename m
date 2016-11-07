From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  7 Nov 2016 18:07:01 +0800
Subject: [PATCH v3 4/6] ARM: dts: sun6i: Add audio codec device node
In-Reply-To: <20161107100703.5586-1-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Message-ID: <20161107100703.5586-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 SoC includes the Allwinner audio codec, capable of 24-bit
playback up to 192 kHz and 24-bit capture up to 48 kHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 2e8bf93dcfb2..f68e6102b01b 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -784,6 +784,19 @@
 			reset-names = "ahb";
 		};
 
+		codec: codec at 01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun6i-a31-codec";
+			reg = <0x01c22c00 0x98>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_APB1_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		timer at 01c60000 {
 			compatible = "allwinner,sun6i-a31-hstimer",
 				     "allwinner,sun7i-a20-hstimer";
-- 
2.10.2
