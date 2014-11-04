From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:31 +0900
Subject: [PATCH 01/34] ARM: shmobile: r8a7740 dtsi: Add missing INTCA clock
 for irqpin module
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <3ab84ee95ba4e28b30fd8ec7c38f5e9f72c4b4b7.1415059587.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

This clock drives the INTCA irqpin controller modules.
Before, it was assumed enabled by the bootloader or reset state.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi            | 14 ++++++++++----
 include/dt-bindings/clock/r8a7740-clock.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index d46c213..502483f 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -71,6 +71,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 	};
 
 	/* irqpin1: IRQ8 - IRQ15 */
@@ -91,6 +92,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 	};
 
 	/* irqpin2: IRQ16 - IRQ23 */
@@ -111,6 +113,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 	};
 
 	/* irqpin3: IRQ24 - IRQ31 */
@@ -131,6 +134,7 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks R8A7740_CLK_INTCA>;
 	};
 
 	ether: ethernet at e9a00000 {
@@ -448,8 +452,8 @@
 		mstp2_clks: mstp2_clks at e6150138 {
 			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xe6150138 4>, <0xe6150040 4>;
-			clocks = <&sub_clk>, <&sub_clk>,
-				 <&cpg_clocks R8A7740_CLK_HP>,
+			clocks = <&sub_clk>, <&cpg_clocks R8A7740_CLK_HP>,
+				 <&sub_clk>, <&cpg_clocks R8A7740_CLK_HP>,
 				 <&cpg_clocks R8A7740_CLK_HP>,
 				 <&cpg_clocks R8A7740_CLK_HP>,
 				 <&cpg_clocks R8A7740_CLK_HP>,
@@ -458,7 +462,8 @@
 				 <&sub_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7740_CLK_SCIFA6 R8A7740_CLK_SCIFA7
+				R8A7740_CLK_SCIFA6 R8A7740_CLK_INTCA
+				R8A7740_CLK_SCIFA7
 				R8A7740_CLK_DMAC1 R8A7740_CLK_DMAC2
 				R8A7740_CLK_DMAC3 R8A7740_CLK_USBDMAC
 				R8A7740_CLK_SCIFA5 R8A7740_CLK_SCIFB
@@ -467,7 +472,8 @@
 				R8A7740_CLK_SCIFA4
 			>;
 			clock-output-names =
-				"scifa6", "scifa7", "dmac1", "dmac2", "dmac3",
+				"scifa6", "intca",
+				"scifa7", "dmac1", "dmac2", "dmac3",
 				"usbdmac", "scifa5", "scifb", "scifa0", "scifa1",
 				"scifa2", "scifa3", "scifa4";
 		};
diff --git a/include/dt-bindings/clock/r8a7740-clock.h b/include/dt-bindings/clock/r8a7740-clock.h
index f6b4b0f..476135d 100644
--- a/include/dt-bindings/clock/r8a7740-clock.h
+++ b/include/dt-bindings/clock/r8a7740-clock.h
@@ -40,6 +40,7 @@
 
 /* MSTP2 */
 #define R8A7740_CLK_SCIFA6	30
+#define R8A7740_CLK_INTCA	29
 #define R8A7740_CLK_SCIFA7	22
 #define R8A7740_CLK_DMAC1	18
 #define R8A7740_CLK_DMAC2	17
-- 
2.1.1
