From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:28 +0100
Subject: [PATCH 38/68] ARM: dts: emev2: use GIC_* defines
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <b14ce2321b9c63f807719358c64bbe7aa973731c.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in emev2 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 57795da616cb..bcce6f50c93d 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -53,8 +54,8 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	clocks at e0110000 {
@@ -158,7 +159,7 @@
 	timer at e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
-		interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&sti_sclk>;
 		clock-names = "sclk";
 	};
@@ -166,7 +167,7 @@
 	uart0: serial at e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
-		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&usia_u0_sclk>;
 		clock-names = "sclk";
 	};
@@ -174,7 +175,7 @@
 	uart1: serial at e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
-		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&usib_u1_sclk>;
 		clock-names = "sclk";
 	};
@@ -182,7 +183,7 @@
 	uart2: serial at e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
-		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&usib_u2_sclk>;
 		clock-names = "sclk";
 	};
@@ -190,7 +191,7 @@
 	uart3: serial at e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
-		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&usib_u3_sclk>;
 		clock-names = "sclk";
 	};
@@ -203,8 +204,8 @@
 	gpio0: gpio at e0050000 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
-		interrupts = <0 67 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 68 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
 		#gpio-cells = <2>;
@@ -215,8 +216,8 @@
 	gpio1: gpio at e0050080 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050080 0x2c>, <0xe00500c0 0x20>;
-		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 32>;
 		#gpio-cells = <2>;
@@ -227,8 +228,8 @@
 	gpio2: gpio at e0050100 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050100 0x2c>, <0xe0050140 0x20>;
-		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
 		#gpio-cells = <2>;
@@ -239,8 +240,8 @@
 	gpio3: gpio at e0050180 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050180 0x2c>, <0xe00501c0 0x20>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
 		#gpio-cells = <2>;
@@ -251,8 +252,8 @@
 	gpio4: gpio at e0050200 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050200 0x2c>, <0xe0050240 0x20>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 31>;
 		#gpio-cells = <2>;
@@ -266,7 +267,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-emev2";
 		reg = <0xe0070000 0x28>;
-		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
 		clocks = <&iic0_sclk>;
 		clock-names = "sclk";
 		status = "disabled";
@@ -277,7 +278,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,iic-emev2";
 		reg = <0xe10a0000 0x28>;
-		interrupts = <0 33 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_EDGE_RISING>;
 		clocks = <&iic1_sclk>;
 		clock-names = "sclk";
 		status = "disabled";
-- 
2.7.0.rc3.207.g0ac5344
