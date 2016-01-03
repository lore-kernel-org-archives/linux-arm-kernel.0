From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Jan 2016 08:33:27 +1100
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: use GIC_* defines
In-Reply-To: <1451856807-8081-1-git-send-email-horms+renesas@verge.net.au>
References: <1451856807-8081-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1451856807-8081-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 370 ++++++++++++++++++++---------------------
 1 file changed, 185 insertions(+), 185 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2a369ddcb6fd..c24276375c53 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -78,13 +78,13 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
@@ -97,7 +97,7 @@
 	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6051000 0 0x50>;
-		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 26>;
@@ -110,7 +110,7 @@
 	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6052000 0 0x50>;
-		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
@@ -123,7 +123,7 @@
 	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6053000 0 0x50>;
-		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
@@ -136,7 +136,7 @@
 	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6054000 0 0x50>;
-		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 32>;
@@ -149,7 +149,7 @@
 	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6055000 0 0x50>;
-		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 160 32>;
@@ -162,7 +162,7 @@
 	gpio6: gpio at e6055400 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6055400 0 0x50>;
-		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 32>;
@@ -175,7 +175,7 @@
 	gpio7: gpio at e6055800 {
 		compatible = "renesas,gpio-r8a7791", "renesas,gpio-rcar";
 		reg = <0 0xe6055800 0 0x50>;
-		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 224 26>;
@@ -188,24 +188,24 @@
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a7791", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
-		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
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
 		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
-		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -218,14 +218,14 @@
 	cmt1: timer at e6130000 {
 		compatible = "renesas,cmt-48-r8a7791", "renesas,cmt-48-gen2";
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
 		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -240,16 +240,16 @@
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
 		clocks = <&mstp4_clks R8A7791_CLK_IRQC>;
 		power-domains = <&cpg_clocks>;
 	};
@@ -257,22 +257,22 @@
 	dmac0: dma-controller at e6700000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
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
@@ -288,22 +288,22 @@
 	dmac1: dma-controller at e6720000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
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
@@ -319,20 +319,20 @@
 	audma0: dma-controller at ec700000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
 		reg = <0 0xec700000 0 0x10000>;
-		interrupts =	<0 346 IRQ_TYPE_LEVEL_HIGH
-				 0 320 IRQ_TYPE_LEVEL_HIGH
-				 0 321 IRQ_TYPE_LEVEL_HIGH
-				 0 322 IRQ_TYPE_LEVEL_HIGH
-				 0 323 IRQ_TYPE_LEVEL_HIGH
-				 0 324 IRQ_TYPE_LEVEL_HIGH
-				 0 325 IRQ_TYPE_LEVEL_HIGH
-				 0 326 IRQ_TYPE_LEVEL_HIGH
-				 0 327 IRQ_TYPE_LEVEL_HIGH
-				 0 328 IRQ_TYPE_LEVEL_HIGH
-				 0 329 IRQ_TYPE_LEVEL_HIGH
-				 0 330 IRQ_TYPE_LEVEL_HIGH
-				 0 331 IRQ_TYPE_LEVEL_HIGH
-				 0 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts =	<GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -348,20 +348,20 @@
 	audma1: dma-controller at ec720000 {
 		compatible = "renesas,dmac-r8a7791", "renesas,rcar-dmac";
 		reg = <0 0xec720000 0 0x10000>;
-		interrupts =	<0 347 IRQ_TYPE_LEVEL_HIGH
-				 0 333 IRQ_TYPE_LEVEL_HIGH
-				 0 334 IRQ_TYPE_LEVEL_HIGH
-				 0 335 IRQ_TYPE_LEVEL_HIGH
-				 0 336 IRQ_TYPE_LEVEL_HIGH
-				 0 337 IRQ_TYPE_LEVEL_HIGH
-				 0 338 IRQ_TYPE_LEVEL_HIGH
-				 0 339 IRQ_TYPE_LEVEL_HIGH
-				 0 340 IRQ_TYPE_LEVEL_HIGH
-				 0 341 IRQ_TYPE_LEVEL_HIGH
-				 0 342 IRQ_TYPE_LEVEL_HIGH
-				 0 343 IRQ_TYPE_LEVEL_HIGH
-				 0 344 IRQ_TYPE_LEVEL_HIGH
-				 0 345 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts =	<GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				 GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
 				"ch0", "ch1", "ch2", "ch3",
 				"ch4", "ch5", "ch6", "ch7",
@@ -377,8 +377,8 @@
 	usb_dmac0: dma-controller at e65a0000 {
 		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
-		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
-			      0 109 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC0>;
 		power-domains = <&cpg_clocks>;
@@ -389,8 +389,8 @@
 	usb_dmac1: dma-controller at e65b0000 {
 		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65b0000 0 0x100>;
-		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
-			      0 110 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "ch0", "ch1";
 		clocks = <&mstp3_clks R8A7791_CLK_USBDMAC1>;
 		power-domains = <&cpg_clocks>;
@@ -404,7 +404,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6508000 0 0x40>;
-		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -416,7 +416,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6518000 0 0x40>;
-		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -428,7 +428,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6530000 0 0x40>;
-		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -440,7 +440,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6540000 0 0x40>;
-		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -452,7 +452,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6520000 0 0x40>;
-		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -465,7 +465,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
 		reg = <0 0xe6528000 0 0x40>;
-		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
 		power-domains = <&cpg_clocks>;
 		i2c-scl-internal-delay-ns = <110>;
@@ -478,7 +478,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe60b0000 0 0x425>;
-		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
 		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
 		dma-names = "tx", "rx";
@@ -491,7 +491,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe6500000 0 0x425>;
-		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
 		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
 		dma-names = "tx", "rx";
@@ -504,7 +504,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
 		reg = <0 0xe6510000 0 0x425>;
-		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
 		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
 		dma-names = "tx", "rx";
@@ -520,7 +520,7 @@
 	mmcif0: mmc at ee200000 {
 		compatible = "renesas,mmcif-r8a7791", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_MMCIF0>;
 		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
 		dma-names = "tx", "rx";
@@ -533,7 +533,7 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee100000 0 0x328>;
-		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI0>;
 		dmas = <&dmac1 0xcd>, <&dmac1 0xce>;
 		dma-names = "tx", "rx";
@@ -544,7 +544,7 @@
 	sdhi1: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee140000 0 0x100>;
-		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI1>;
 		dmas = <&dmac1 0xc1>, <&dmac1 0xc2>;
 		dma-names = "tx", "rx";
@@ -555,7 +555,7 @@
 	sdhi2: sd at ee160000 {
 		compatible = "renesas,sdhi-r8a7791";
 		reg = <0 0xee160000 0 0x100>;
-		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SDHI2>;
 		dmas = <&dmac1 0xd3>, <&dmac1 0xd4>;
 		dma-names = "tx", "rx";
@@ -566,7 +566,7 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
@@ -578,7 +578,7 @@
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
@@ -590,7 +590,7 @@
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
-		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
@@ -602,7 +602,7 @@
 	scifa3: serial at e6c70000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
-		interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
@@ -614,7 +614,7 @@
 	scifa4: serial at e6c78000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
-		interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
@@ -626,7 +626,7 @@
 	scifa5: serial at e6c80000 {
 		compatible = "renesas,scifa-r8a7791", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
-		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
@@ -638,7 +638,7 @@
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
-		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
@@ -650,7 +650,7 @@
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
-		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
@@ -662,7 +662,7 @@
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a7791", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
-		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
@@ -674,7 +674,7 @@
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
-		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
@@ -686,7 +686,7 @@
 	scif1: serial at e6e68000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
-		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
@@ -698,7 +698,7 @@
 	scif2: serial at e6e58000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
-		interrupts = <0 22 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
@@ -710,7 +710,7 @@
 	scif3: serial at e6ea8000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
-		interrupts = <0 23 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
@@ -722,7 +722,7 @@
 	scif4: serial at e6ee0000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
-		interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
@@ -734,7 +734,7 @@
 	scif5: serial at e6ee8000 {
 		compatible = "renesas,scif-r8a7791", "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
-		interrupts = <0 25 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
@@ -746,7 +746,7 @@
 	hscif0: serial at e62c0000 {
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
-		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
@@ -758,7 +758,7 @@
 	hscif1: serial at e62c8000 {
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
-		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
@@ -770,7 +770,7 @@
 	hscif2: serial at e62d0000 {
 		compatible = "renesas,hscif-r8a7791", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
-		interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
 		clock-names = "sci_ick";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
@@ -782,7 +782,7 @@
 	ether: ethernet at ee700000 {
 		compatible = "renesas,ether-r8a7791";
 		reg = <0 0xee700000 0 0x400>;
-		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
 		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
@@ -806,7 +806,7 @@
 	sata0: sata at ee300000 {
 		compatible = "renesas,sata-r8a7791";
 		reg = <0 0xee300000 0 0x2000>;
-		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -815,7 +815,7 @@
 	sata1: sata at ee500000 {
 		compatible = "renesas,sata-r8a7791";
 		reg = <0 0xee500000 0 0x2000>;
-		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_SATA1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -824,7 +824,7 @@
 	hsusb: usb at e6590000 {
 		compatible = "renesas,usbhs-r8a7791";
 		reg = <0 0xe6590000 0 0x100>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
 		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
@@ -859,7 +859,7 @@
 	vin0: video at e6ef0000 {
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef0000 0 0x1000>;
-		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -868,7 +868,7 @@
 	vin1: video at e6ef1000 {
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef1000 0 0x1000>;
-		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -877,7 +877,7 @@
 	vin2: video at e6ef2000 {
 		compatible = "renesas,vin-r8a7791";
 		reg = <0 0xe6ef2000 0 0x1000>;
-		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7791_CLK_VIN2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -886,7 +886,7 @@
 	vsp1 at fe928000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe928000 0 0x8000>;
-		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
 		power-domains = <&cpg_clocks>;
 
@@ -900,7 +900,7 @@
 	vsp1 at fe930000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe930000 0 0x8000>;
-		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
 		power-domains = <&cpg_clocks>;
 
@@ -914,7 +914,7 @@
 	vsp1 at fe938000 {
 		compatible = "renesas,vsp1";
 		reg = <0 0xfe938000 0 0x8000>;
-		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
 		power-domains = <&cpg_clocks>;
 
@@ -930,8 +930,8 @@
 		reg = <0 0xfeb00000 0 0x40000>,
 		      <0 0xfeb90000 0 0x1c>;
 		reg-names = "du", "lvds.0";
-		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_DU0>,
 			 <&mstp7_clks R8A7791_CLK_DU1>,
 			 <&mstp7_clks R8A7791_CLK_LVDS0>;
@@ -958,7 +958,7 @@
 	can0: can at e6e80000 {
 		compatible = "renesas,can-r8a7791";
 		reg = <0 0xe6e80000 0 0x1000>;
-		interrupts = <0 186 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
@@ -969,7 +969,7 @@
 	can1: can at e6e88000 {
 		compatible = "renesas,can-r8a7791";
 		reg = <0 0xe6e88000 0 0x1000>;
-		interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
 			 <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
@@ -980,7 +980,7 @@
 	jpu: jpeg-codec at fe980000 {
 		compatible = "renesas,jpu-r8a7791";
 		reg = <0 0xfe980000 0 0x10300>;
-		interrupts = <0 272 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_JPU>;
 		power-domains = <&cpg_clocks>;
 	};
@@ -1432,7 +1432,7 @@
 	qspi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7791", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
 		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
 		dma-names = "tx", "rx";
@@ -1446,7 +1446,7 @@
 	msiof0: spi at e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e20000 0 0x0064>;
-		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
 		dma-names = "tx", "rx";
@@ -1459,7 +1459,7 @@
 	msiof1: spi at e6e10000 {
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e10000 0 0x0064>;
-		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
 		dma-names = "tx", "rx";
@@ -1472,7 +1472,7 @@
 	msiof2: spi at e6e00000 {
 		compatible = "renesas,msiof-r8a7791";
 		reg = <0 0xe6e00000 0 0x0064>;
-		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
 		dma-names = "tx", "rx";
@@ -1485,7 +1485,7 @@
 	xhci: usb at ee000000 {
 		compatible = "renesas,xhci-r8a7791";
 		reg = <0 0xee000000 0 0xc00>;
-		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7791_CLK_SSUSB>;
 		power-domains = <&cpg_clocks>;
 		phys = <&usb2 1>;
@@ -1498,7 +1498,7 @@
 		device_type = "pci";
 		reg = <0 0xee090000 0 0xc00>,
 		      <0 0xee080000 0 0x1100>;
-		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -1533,7 +1533,7 @@
 		device_type = "pci";
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
-		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_EHCI>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -1577,9 +1577,9 @@
 		/* Map all possible DDR as inbound ranges */
 		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
 			      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
-		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 117 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 118 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
@@ -1592,8 +1592,8 @@
 	ipmmu_sy0: mmu at e6280000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1601,7 +1601,7 @@
 	ipmmu_sy1: mmu at e6290000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
-		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1609,8 +1609,8 @@
 	ipmmu_ds: mmu at e6740000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
-		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1618,7 +1618,7 @@
 	ipmmu_mp: mmu at ec680000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
-		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1626,8 +1626,8 @@
 	ipmmu_mx: mmu at fe951000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
-		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1635,7 +1635,7 @@
 	ipmmu_rt: mmu at ffc80000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xffc80000 0 0x1000>;
-		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1643,8 +1643,8 @@
 	ipmmu_gp: mmu at e62a0000 {
 		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe62a0000 0 0x1000>;
-		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 261 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
 		status = "disabled";
 	};
@@ -1721,52 +1721,52 @@
 
 		rcar_sound,src {
 			src0: src at 0 {
-				interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x85>, <&audma1 0x9a>;
 				dma-names = "rx", "tx";
 			};
 			src1: src at 1 {
-				interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x87>, <&audma1 0x9c>;
 				dma-names = "rx", "tx";
 			};
 			src2: src at 2 {
-				interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x89>, <&audma1 0x9e>;
 				dma-names = "rx", "tx";
 			};
 			src3: src at 3 {
-				interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8b>, <&audma1 0xa0>;
 				dma-names = "rx", "tx";
 			};
 			src4: src at 4 {
-				interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8d>, <&audma1 0xb0>;
 				dma-names = "rx", "tx";
 			};
 			src5: src at 5 {
-				interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x8f>, <&audma1 0xb2>;
 				dma-names = "rx", "tx";
 			};
 			src6: src at 6 {
-				interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x91>, <&audma1 0xb4>;
 				dma-names = "rx", "tx";
 			};
 			src7: src at 7 {
-				interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x93>, <&audma1 0xb6>;
 				dma-names = "rx", "tx";
 			};
 			src8: src at 8 {
-				interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x95>, <&audma1 0xb8>;
 				dma-names = "rx", "tx";
 			};
 			src9: src at 9 {
-				interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x97>, <&audma1 0xba>;
 				dma-names = "rx", "tx";
 			};
@@ -1774,52 +1774,52 @@
 
 		rcar_sound,ssi {
 			ssi0: ssi at 0 {
-				interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi1: ssi at 1 {
-				 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+				 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi2: ssi at 2 {
-				interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi3: ssi at 3 {
-				interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi4: ssi at 4 {
-				interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi5: ssi at 5 {
-				interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi6: ssi at 6 {
-				interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi7: ssi at 7 {
-				interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi8: ssi at 8 {
-				interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
 			ssi9: ssi at 9 {
-				interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
 				dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
 				dma-names = "rx", "tx", "rxu", "txu";
 			};
-- 
2.1.4
