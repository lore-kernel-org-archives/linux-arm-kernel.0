From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:55 +0100
Subject: [PATCH 61/70] ARM: dts: r8a7793: Add BRG support for SCIF
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <612c0afe452fff4602ecf20e778fe14e0b5d2a85.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add the device node for the external SCIF_CLK.
The presence of the SCIF_CLK crystal and its clock frequency depends on
the actual board.

Add the two optional clock sources (ZS_CLK and SCIF_CLK for the internal
resp. external clock) for the Baud Rate Generator for External Clock
(BRG) to all SCIF and HSCIF device nodes.

This increases the range and accuracy of supported baud rates on
(H)SCIF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 07af584915c6..45dba1c79a43 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -600,8 +600,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -613,8 +614,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -626,8 +628,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -639,8 +642,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -652,8 +656,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -665,8 +670,9 @@
 			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -678,8 +684,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -691,8 +698,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -704,8 +712,9 @@
 			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>;
-		clock-names = "fck";
+		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>, <&zs_clk>,
+			 <&scif_clk>;
+		clock-names = "fck", "brg_int", "scif_clk";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -805,6 +814,15 @@
 			clock-output-names = "audio_clk_c";
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
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7793-cpg-clocks",
-- 
2.7.0.rc3.207.g0ac5344
