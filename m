From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 21 Mar 2016 21:01:04 +0100
Subject: [linux-sunxi][PATCH v3 6/8] ARM: dts: sun7i: Add the SPDIF block to
 the A20
In-Reply-To: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
References: <1458590466-12572-1-git-send-email-codekipper@gmail.com>
Message-ID: <1458590466-12572-7-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block to the A20 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 108cad4..9944496 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1244,6 +1244,19 @@
 			status = "disabled";
 		};
 
+		spdif: spdif at 01c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun4i-a10-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma SUN4I_DMA_NORMAL 2>,
+			       <&dma SUN4I_DMA_NORMAL 2>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
 			clocks = <&apb0_gates 6>, <&ir0_clk>;
-- 
2.7.4
