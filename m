From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:04 +0100
Subject: [PATCH 14/68] ARM: dts: r8a7793: use GIC_* defines
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <214e8481fe1fef5e88f80f0da6c9bfbd1963099f.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7793 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 216 ++++++++++++++++++++---------------------
 1 file changed, 108 insertions(+), 108 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 0ce7cc420c9d..ea1196b99d52 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -63,13 +63,13 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
@@ -82,7 +82,7 @@
 	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6051000 0 0x50>;
-		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 26>;
@@ -95,7 +95,7 @@
 	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6052000 0 0x50>;
-		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
@@ -108,7 +108,7 @@
 	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6053000 0 0x50>;
-		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
@@ -121,7 +121,7 @@
 	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6054000 0 0x50>;
-		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 32>;
@@ -134,7 +134,7 @@
 	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6055000 0 0x50>;
-		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 160 32>;
@@ -147,7 +147,7 @@
 	gpio6: gpio at e6055400 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6055400 0 0x50>;
-		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 32>;
@@ -160,7 +160,7 @@
 	gpio7: gpio at e6055800 {
 		compatible = "renesas,gpio-r8a7793", "renesas,gpio-rcar";
 		reg = <0 0xe6055800 0 0x50>;
-		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 224 26>;
@@ -173,24 +173,24 @@
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a7793", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
-		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7793_CLK_THERMAL>;
 		power-domains = <&cpg_clocks>;
 	};
 
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
 
 	cmt0: timer at ffca0000 {
 		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
-		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7793_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -203,14 +203,14 @@
 	cmt1: timer at e6130000 {
 		compatible = "renesas,cmt-48-r8a7793", "renesas,cmt-48-gen2";
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
 		clocks = <&mstp3_clks R8A7793_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -225,16 +225,16 @@
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
 		clocks = <&mstp4_clks R8A7793_CLK_IRQC>;
 		power-domains = <&cpg_clocks>;
 	};
@@ -242,22 +242,22 @@
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
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
@@ -273,22 +273,22 @@
 	dmac1: dma-controller at e6720000 {
 		compatible = "renesas,dmac-r8a7793", "renesas,rcar-dmac";
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
@@ -307,7 +307,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6508000 0 0x40>;
-		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -319,7 +319,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6518000 0 0x40>;
-		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -331,7 +331,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6530000 0 0x40>;
-		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -343,7 +343,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6540000 0 0x40>;
-		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -355,7 +355,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6520000 0 0x40>;
-		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -368,7 +368,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7793";
 		reg = <0 0xe6528000 0 0x40>;
-		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <110>;
@@ -381,7 +381,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
-		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
@@ -394,7 +394,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
-		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7793_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
@@ -407,7 +407,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7793", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
-		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7793_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
@@ -423,7 +423,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
@@ -435,7 +435,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
@@ -447,7 +447,7 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
-		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
@@ -459,7 +459,7 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
-		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
@@ -471,7 +471,7 @@
 	scifa4: serial at e6c78000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
-		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
@@ -483,7 +483,7 @@
 	scifa5: serial at e6c80000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
-		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7793_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
@@ -495,7 +495,7 @@
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
-		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
@@ -507,7 +507,7 @@
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
@@ -519,7 +519,7 @@
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a7793", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
-		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7793_CLK_SCIFB2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
@@ -531,7 +531,7 @@
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
-		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
@@ -543,7 +543,7 @@
 	scif1: serial at e6e68000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
-		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
@@ -555,7 +555,7 @@
 	scif2: serial at e6e58000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
-		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
@@ -567,7 +567,7 @@
 	scif3: serial at e6ea8000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
-		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
@@ -579,7 +579,7 @@
 	scif4: serial at e6ee0000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
-		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
@@ -591,7 +591,7 @@
 	scif5: serial at e6ee8000 {
 		compatible = "renesas,scif-r8a7793", "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
-		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
@@ -603,7 +603,7 @@
 	hscif0: serial at e62c0000 {
 		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
-		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
@@ -615,7 +615,7 @@
 	hscif1: serial at e62c8000 {
 		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
-		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
@@ -627,7 +627,7 @@
 	hscif2: serial at e62d0000 {
 		compatible = "renesas,hscif-r8a7793", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
-		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_HSCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
@@ -639,7 +639,7 @@
 	ether: ethernet at ee700000 {
 		compatible = "renesas,ether-r8a7793";
 		reg = <0 0xee700000 0 0x400>;
-		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7793_CLK_ETHER>;
 		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
@@ -651,7 +651,7 @@
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7793", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7793_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
@@ -667,8 +667,8 @@
 		reg = <0 0xfeb00000 0 0x40000>,
 		      <0 0xfeb90000 0 0x1c>;
 		reg-names = "du", "lvds.0";
-		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7793_CLK_DU0>,
 			 <&mstp7_clks R8A7793_CLK_DU1>,
 			 <&mstp7_clks R8A7793_CLK_LVDS0>;
@@ -978,8 +978,8 @@
 	ipmmu_sy0: mmu at e6280000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -987,7 +987,7 @@
 	ipmmu_sy1: mmu at e6290000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
-		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -995,8 +995,8 @@
 	ipmmu_ds: mmu at e6740000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
-		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1004,7 +1004,7 @@
 	ipmmu_mp: mmu at ec680000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
-		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1012,8 +1012,8 @@
 	ipmmu_mx: mmu at fe951000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
-		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1021,7 +1021,7 @@
 	ipmmu_rt: mmu at ffc80000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xffc80000 0 0x1000>;
-		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1029,8 +1029,8 @@
 	ipmmu_gp: mmu at e62a0000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
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
