From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 5 Apr 2014 03:49:55 +0400
Subject: [PATCH] ARM: shmobile: r8a7791: add EHCI clock DT support
Message-ID: <201404050349.56764.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the USB EHCI clock to the R8A7791 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'renesas-devel-3.14-20140403' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791.dtsi            |   25 +++++++++++++++----------
 include/dt-bindings/clock/r8a7791-clock.h |    1 +
 2 files changed, 16 insertions(+), 10 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -774,20 +774,25 @@
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-			clocks = <&mp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
-				 <&zx_clk>, <&zx_clk>, <&zx_clk>;
+			clocks = <&mp_clk>, <&mp_clk>, <&zs_clk>, <&p_clk>,
+			         <&p_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
+				 <&p_clk>, <&p_clk>, <&p_clk>, <&zx_clk>,
+				 <&zx_clk>, <&zx_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
-				R8A7791_CLK_HSUSB R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
-				R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1 R8A7791_CLK_HSCIF0
-				R8A7791_CLK_SCIF3 R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
-				R8A7791_CLK_SCIF0 R8A7791_CLK_DU1 R8A7791_CLK_DU0
-				R8A7791_CLK_LVDS0
+				R8A7791_CLK_EHCI R8A7791_CLK_HSUSB
+				R8A7791_CLK_HSCIF2 R8A7791_CLK_SCIF5
+				R8A7791_CLK_SCIF4 R8A7791_CLK_HSCIF1
+				R8A7791_CLK_HSCIF0 R8A7791_CLK_SCIF3
+				R8A7791_CLK_SCIF2 R8A7791_CLK_SCIF1
+				R8A7791_CLK_SCIF0 R8A7791_CLK_DU1
+				R8A7791_CLK_DU0 R8A7791_CLK_LVDS0
 			>;
 			clock-output-names =
-				"hsusb", "hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0", "du1", "du0", "lvds0";
+				"ehci", "hsusb", "hscif2", "scif5",
+				"scif4", "hscif1", "hscif0", "scif3",
+				"scif2", "scif1", "scif0", "du1",
+				"du0", "lvds0";
 		};
 		mstp8_clks: mstp8_clks at e6150990 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7791-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
+++ renesas/include/dt-bindings/clock/r8a7791-clock.h
@@ -63,6 +63,7 @@
 #define R8A7791_CLK_PWM			23
 
 /* MSTP7 */
+#define R8A7791_CLK_EHCI		3
 #define R8A7791_CLK_HSUSB		4
 #define R8A7791_CLK_HSCIF2		13
 #define R8A7791_CLK_SCIF5		14
