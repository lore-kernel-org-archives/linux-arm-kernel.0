From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 07 Apr 2014 15:04:21 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Add EHCI MSTP clock
Message-ID: <20140407060421.25826.64819.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for EHCI clock gating via the MSTP703 bit on r8a7791.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.14-20140403

 arch/arm/boot/dts/r8a7791.dtsi            |    6 +++---
 include/dt-bindings/clock/r8a7791-clock.h |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2014-04-07 14:49:43.000000000 +0900
@@ -774,19 +774,19 @@
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
+			clocks = <&mp_clk>,  <&mp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
 				 <&zx_clk>, <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
+				R8A7791_CLK_EHCI R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
 				R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1 R8A7791_CLK_HSCIF0
 				R8A7791_CLK_SCIF3 R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
 				R8A7791_CLK_SCIF0 R8A7791_CLK_DU1 R8A7791_CLK_DU0
 				R8A7791_CLK_LVDS0
 			>;
 			clock-output-names =
-				"hsusb", "hscif2", "scif5", "scif4", "hscif1", "hscif0",
+				"ehci", "hsusb", "hscif2", "scif5", "scif4", "hscif1", "hscif0",
 				"scif3", "scif2", "scif1", "scif0", "du1", "du0", "lvds0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
--- 0001/include/dt-bindings/clock/r8a7791-clock.h
+++ work/include/dt-bindings/clock/r8a7791-clock.h	2014-04-07 14:49:43.000000000 +0900
@@ -63,6 +63,7 @@
 #define R8A7791_CLK_PWM			23
 
 /* MSTP7 */
+#define R8A7791_CLK_EHCI		3
 #define R8A7791_CLK_HSUSB		4
 #define R8A7791_CLK_HSCIF2		13
 #define R8A7791_CLK_SCIF5		14
