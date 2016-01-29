From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 11:04:37 +0100
Subject: [PATCH v4 1/7] ARM: dts: r8a7778: Add BRG support for SCIF
In-Reply-To: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
References: <1454061883-4043-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454061883-4043-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (S1 and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF device nodes.

This increases the range and accuracy of supported baud rates on SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7778.dtsi | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 50784e2b632d2d41..f83a348fc07a49e3 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -301,8 +301,9 @@
 			     "renesas,scif";
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -312,8 +313,9 @@
 			     "renesas,scif";
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -323,8 +325,9 @@
 			     "renesas,scif";
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -334,8 +337,9 @@
 			     "renesas,scif";
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -345,8 +349,9 @@
 			     "renesas,scif";
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -356,8 +361,9 @@
 			     "renesas,scif";
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>,
+			 <&cpg_clocks R8A7778_CLK_S1>, <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -444,6 +450,15 @@
 			clock-output-names = "extal";
 		};
 
+		/* External SCIF clock */
+		scif_clk: scif {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at ffc80000 {
 			compatible = "renesas,r8a7778-cpg-clocks";
-- 
1.9.1
