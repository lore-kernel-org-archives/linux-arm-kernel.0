From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:09 +0100
Subject: [PATCH 15/70] ARM: dts: r8a7794: use GIC_* defines
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <8d47e6af6f824e6f68f0af3f09816cc424e6fbac.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7794 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 234 ++++++++++++++++++++---------------------
 1 file changed, 117 insertions(+), 117 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f8cd3a0beebf..21be4bdc4001 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -59,13 +59,13 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
@@ -78,7 +78,7 @@
 	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6051000 0 0x50>;
-		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 26>;
@@ -91,7 +91,7 @@
 	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6052000 0 0x50>;
-		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
@@ -104,7 +104,7 @@
 	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6053000 0 0x50>;
-		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
@@ -117,7 +117,7 @@
 	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6054000 0 0x50>;
-		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 32>;
@@ -130,7 +130,7 @@
 	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6055000 0 0x50>;
-		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 160 28>;
@@ -143,7 +143,7 @@
 	gpio6: gpio at e6055400 {
 		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
 		reg = <0 0xe6055400 0 0x50>;
-		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 26>;
@@ -156,8 +156,8 @@
 	cmt0: timer at ffca0000 {
 		compatible = "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
-		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7794_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -170,14 +170,14 @@
 	cmt1: timer at e6130000 {
 		compatible = "renesas,cmt-48-gen2";
 		reg = <0 0xe6130000 0 0x1004>;
-		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -189,10 +189,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	irqc0: interrupt-controller at e61c0000 {
@@ -200,16 +200,16 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
-		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 12 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 13 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 14 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 15 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 16 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R8A7794_CLK_IRQC>;
 		power-domains = <&cpg_clocks>;
 	};
@@ -222,22 +222,22 @@
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
-		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
-			      0 200 IRQ_TYPE_LEVEL_HIGH
-			      0 201 IRQ_TYPE_LEVEL_HIGH
-			      0 202 IRQ_TYPE_LEVEL_HIGH
-			      0 203 IRQ_TYPE_LEVEL_HIGH
-			      0 204 IRQ_TYPE_LEVEL_HIGH
-			      0 205 IRQ_TYPE_LEVEL_HIGH
-			      0 206 IRQ_TYPE_LEVEL_HIGH
-			      0 207 IRQ_TYPE_LEVEL_HIGH
-			      0 208 IRQ_TYPE_LEVEL_HIGH
-			      0 209 IRQ_TYPE_LEVEL_HIGH
-			      0 210 IRQ_TYPE_LEVEL_HIGH
-			      0 211 IRQ_TYPE_LEVEL_HIGH
-			      0 212 IRQ_TYPE_LEVEL_HIGH
-			      0 213 IRQ_TYPE_LEVEL_HIGH
-			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -253,22 +253,22 @@
 	dmac1: dma-controller at e6720000 {
 		compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
 		reg = <0 0xe6720000 0 0x20000>;
-		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-			      0 216 IRQ_TYPE_LEVEL_HIGH
-			      0 217 IRQ_TYPE_LEVEL_HIGH
-			      0 218 IRQ_TYPE_LEVEL_HIGH
-			      0 219 IRQ_TYPE_LEVEL_HIGH
-			      0 308 IRQ_TYPE_LEVEL_HIGH
-			      0 309 IRQ_TYPE_LEVEL_HIGH
-			      0 310 IRQ_TYPE_LEVEL_HIGH
-			      0 311 IRQ_TYPE_LEVEL_HIGH
-			      0 312 IRQ_TYPE_LEVEL_HIGH
-			      0 313 IRQ_TYPE_LEVEL_HIGH
-			      0 314 IRQ_TYPE_LEVEL_HIGH
-			      0 315 IRQ_TYPE_LEVEL_HIGH
-			      0 316 IRQ_TYPE_LEVEL_HIGH
-			      0 317 IRQ_TYPE_LEVEL_HIGH
-			      0 318 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -284,7 +284,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
@@ -296,7 +296,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
@@ -308,7 +308,7 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
-		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
@@ -320,7 +320,7 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
-		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
@@ -332,7 +332,7 @@
 	scifa4: serial at e6c78000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
-		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
@@ -344,7 +344,7 @@
 	scifa5: serial at e6c80000 {
 		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
-		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
@@ -356,7 +356,7 @@
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
-		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
@@ -368,7 +368,7 @@
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
@@ -380,7 +380,7 @@
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
-		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
@@ -392,7 +392,7 @@
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
-		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
@@ -404,7 +404,7 @@
 	scif1: serial at e6e68000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
-		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
@@ -416,7 +416,7 @@
 	scif2: serial at e6e58000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
-		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
@@ -428,7 +428,7 @@
 	scif3: serial at e6ea8000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
-		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
@@ -440,7 +440,7 @@
 	scif4: serial at e6ee0000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
-		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
@@ -452,7 +452,7 @@
 	scif5: serial at e6ee8000 {
 		compatible = "renesas,scif-r8a7794", "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
-		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
@@ -464,7 +464,7 @@
 	hscif0: serial at e62c0000 {
 		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
-		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
@@ -476,7 +476,7 @@
 	hscif1: serial at e62c8000 {
 		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
-		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
@@ -488,7 +488,7 @@
 	hscif2: serial at e62d0000 {
 		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
-		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
@@ -500,7 +500,7 @@
 	ether: ethernet at ee700000 {
 		compatible = "renesas,ether-r8a7794";
 		reg = <0 0xee700000 0 0x400>;
-		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
 		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
@@ -513,7 +513,7 @@
 	i2c0: i2c at e6508000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6508000 0 0x40>;
-		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -525,7 +525,7 @@
 	i2c1: i2c at e6518000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6518000 0 0x40>;
-		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -537,7 +537,7 @@
 	i2c2: i2c at e6530000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6530000 0 0x40>;
-		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -549,7 +549,7 @@
 	i2c3: i2c at e6540000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6540000 0 0x40>;
-		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -561,7 +561,7 @@
 	i2c4: i2c at e6520000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6520000 0 0x40>;
-		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -573,7 +573,7 @@
 	i2c5: i2c at e6528000 {
 		compatible = "renesas,i2c-r8a7794";
 		reg = <0 0xe6528000 0 0x40>;
-		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -585,7 +585,7 @@
 	mmcif0: mmc at ee200000 {
 		compatible = "renesas,mmcif-r8a7794", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
@@ -597,7 +597,7 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee100000 0 0x200>;
-		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -606,7 +606,7 @@
 	sdhi1: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee140000 0 0x100>;
-		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -615,7 +615,7 @@
 	sdhi2: sd at ee160000 {
 		compatible = "renesas,sdhi-r8a7794";
 		reg = <0 0xee160000 0 0x100>;
-		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -624,7 +624,7 @@
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7794", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
@@ -638,7 +638,7 @@
 	vin0: video at e6ef0000 {
 		compatible = "renesas,vin-r8a7794";
 		reg = <0 0xe6ef0000 0 0x1000>;
-		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -647,7 +647,7 @@
 	vin1: video at e6ef1000 {
 		compatible = "renesas,vin-r8a7794";
 		reg = <0 0xe6ef1000 0 0x1000>;
-		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7794_CLK_VIN1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -658,7 +658,7 @@
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
-		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -669,9 +669,9 @@
 		#interrupt-cells = <1>;
 		ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
 		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+				 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+				 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 
 		usb at 0,1 {
 			reg = <0x800 0 0 0 0>;
@@ -693,7 +693,7 @@
 		device_type = "pci";
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
-		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -704,9 +704,9 @@
 		#interrupt-cells = <1>;
 		ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
 		interrupt-map-mask = <0xff00 0 0 0x7>;
-		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
-				 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
-				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+				 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+				 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 
 		usb at 0,1 {
 			reg = <0x800 0 0 0 0>;
@@ -726,7 +726,7 @@
 	hsusb: usb at e6590000 {
 		compatible = "renesas,usbhs-r8a7794", "renesas,rcar-gen2-usbhs";
 		reg = <0 0xe6590000 0 0x100>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
 		power-domains = <&cpg_clocks>;
 		renesas,buswait = <4>;
@@ -759,8 +759,8 @@
 		compatible = "renesas,du-r8a7794";
 		reg = <0 0xfeb00000 0 0x40000>;
 		reg-names = "du";
-		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
 			 <&mstp7_clks R8A7794_CLK_DU0>;
 		clock-names = "du.0", "du.1";
@@ -1111,8 +1111,8 @@
 	ipmmu_sy0: mmu at e6280000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1120,7 +1120,7 @@
 	ipmmu_sy1: mmu at e6290000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
-		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1128,8 +1128,8 @@
 	ipmmu_ds: mmu at e6740000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
-		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1137,7 +1137,7 @@
 	ipmmu_mp: mmu at ec680000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
-		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1145,8 +1145,8 @@
 	ipmmu_mx: mmu at fe951000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
-		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1154,8 +1154,8 @@
 	ipmmu_gp: mmu at e62a0000 {
 		compatible = "renesas,ipmmu-r8a7794", "renesas,ipmmu-vmsa";
 		reg = <0 0xe62a0000 0 0x1000>;
-		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 261 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
