From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:07 +0100
Subject: [PATCH 17/68] ARM: dts: r8a7778: use GIC_* defines
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <0c34bd1e00b0c60407ede0ca0d49862ef6116fa5.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7778 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 87 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 791aafd310a5..fc5e7243467a 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -17,6 +17,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/clock/r8a7778-clock.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -51,7 +52,7 @@
 	ether: ethernet at fde00000 {
 		compatible = "renesas,ether-r8a7778";
 		reg = <0xfde00000 0x400>;
-		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
 		power-domains = <&cpg_clocks>;
 		phy-mode = "rmii";
@@ -79,17 +80,17 @@
 			<0xfe780024 4>,
 			<0xfe780044 4>,
 			<0xfe780064 4>;
-		interrupts =   <0 27 IRQ_TYPE_LEVEL_HIGH
-				0 28 IRQ_TYPE_LEVEL_HIGH
-				0 29 IRQ_TYPE_LEVEL_HIGH
-				0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts =   <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH
+				GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		sense-bitfield-width = <2>;
 	};
 
 	gpio0: gpio at ffc40000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
@@ -100,7 +101,7 @@
 	gpio1: gpio at ffc41000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc41000 0x2c>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 32>;
@@ -111,7 +112,7 @@
 	gpio2: gpio at ffc42000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc42000 0x2c>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
@@ -122,7 +123,7 @@
 	gpio3: gpio at ffc43000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc43000 0x2c>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
@@ -133,7 +134,7 @@
 	gpio4: gpio at ffc44000 {
 		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
 		reg = <0xffc44000 0x2c>;
-		interrupts = <0 103 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 27>;
@@ -151,7 +152,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc70000 0x1000>;
-		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -162,7 +163,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc71000 0x1000>;
-		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -173,7 +174,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc72000 0x1000>;
-		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -184,7 +185,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7778";
 		reg = <0xffc73000 0x1000>;
-		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -193,9 +194,9 @@
 	tmu0: timer at ffd80000 {
 		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd80000 0x30>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -208,9 +209,9 @@
 	tmu1: timer at ffd81000 {
 		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd81000 0x30>;
-		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -223,9 +224,9 @@
 	tmu2: timer at ffd82000 {
 		compatible = "renesas,tmu-r8a7778", "renesas,tmu";
 		reg = <0xffd82000 0x30>;
-		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_TMU2>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -285,20 +286,20 @@
 		};
 
 		rcar_sound,ssi {
-			ssi3: ssi at 3 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi4: ssi at 4 { interrupts = <0 0x85 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi5: ssi at 5 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi6: ssi at 6 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi7: ssi at 7 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi8: ssi at 8 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi9: ssi at 9 { interrupts = <0 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi3: ssi at 3 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi4: ssi at 4 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi5: ssi at 5 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi6: ssi at 6 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi7: ssi at 7 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi8: ssi at 8 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi9: ssi at 9 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
 		};
 	};
 
 	scif0: serial at ffe40000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -308,7 +309,7 @@
 	scif1: serial at ffe41000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe41000 0x100>;
-		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -318,7 +319,7 @@
 	scif2: serial at ffe42000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe42000 0x100>;
-		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -328,7 +329,7 @@
 	scif3: serial at ffe43000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe43000 0x100>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -338,7 +339,7 @@
 	scif4: serial at ffe44000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe44000 0x100>;
-		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -348,7 +349,7 @@
 	scif5: serial at ffe45000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe45000 0x100>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -358,7 +359,7 @@
 	mmcif: mmc at ffe4e000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
-		interrupts = <0 61 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_MMC>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -367,7 +368,7 @@
 	sdhi0: sd at ffe4c000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
-		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -376,7 +377,7 @@
 	sdhi1: sd at ffe4d000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4d000 0x100>;
-		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -385,7 +386,7 @@
 	sdhi2: sd at ffe4f000 {
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
-		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7778_CLK_SDHI2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -394,7 +395,7 @@
 	hspi0: spi at fffc7000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -405,7 +406,7 @@
 	hspi1: spi at fffc8000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
@@ -416,7 +417,7 @@
 	hspi2: spi at fffc6000 {
 		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_HSPI>;
 		power-domains = <&cpg_clocks>;
 		#address-cells = <1>;
-- 
2.7.0.rc3.207.g0ac5344
