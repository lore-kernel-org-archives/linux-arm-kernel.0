From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 28 Nov 2017 23:15:44 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: use CPG core clock macros
Message-ID: <20171128202105.552196002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the commit ecadea00f588 ("dt-bindings: clock: Add R8A77970 CPG
core clock definitions") has hit Linus' tree, we  can replace the bare
numbers (we had to use to avoid a cross tree dependency) with these macro
definitions...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -9,7 +9,7 @@
  * kind, whether express or implied.
  */
 
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/clock/r8a77970-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/power/r8a77970-sysc.h>
@@ -32,7 +32,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
-			clocks = <&cpg CPG_CORE 0>;
+			clocks = <&cpg CPG_CORE R8A77970_CLK_Z2>;
 			power-domains = <&sysc 5>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
@@ -262,7 +262,7 @@
 			reg = <0 0xe6540000 0 96>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 520>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
@@ -280,7 +280,7 @@
 			reg = <0 0xe6550000 0 96>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 519>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
@@ -298,7 +298,7 @@
 			reg = <0 0xe6560000 0 96>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 518>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
@@ -315,7 +315,7 @@
 			reg = <0 0xe66a0000 0 96>;
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 517>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x37>, <&dmac1 0x36>,
@@ -333,7 +333,7 @@
 			reg = <0 0xe6e60000 0 64>;
 			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 207>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
@@ -351,7 +351,7 @@
 			reg = <0 0xe6e68000 0 64>;
 			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 206>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
@@ -369,7 +369,7 @@
 			reg = <0 0xe6c50000 0 64>;
 			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x57>, <&dmac1 0x56>,
@@ -386,7 +386,7 @@
 			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 203>,
-				 <&cpg CPG_CORE 9>,
+				 <&cpg CPG_CORE R8A77970_CLK_S2D1>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x59>, <&dmac1 0x58>,
