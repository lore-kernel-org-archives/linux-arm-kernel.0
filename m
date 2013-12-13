From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:34 +0900
Subject: [PATCH 60/69] ARM: shmobile: emev2: Use interrupt macros in DT files
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <3dc76086fa0a8def96f331785cceb6e84e3c34de.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts |  3 ++-
 arch/arm/boot/dts/emev2.dtsi      | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index baaa66c..50ccd15 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -12,6 +12,7 @@
 #include "emev2.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "EMEV2 KZM9D Board";
@@ -49,7 +50,7 @@
 		reg = <0x20000000 0x10000>;
 		phy-mode = "mii";
 		interrupt-parent = <&gpio0>;
-		interrupts = <1 1>;	/* active high */
+		interrupts = <1 IRQ_TYPE_EDGE_RISING>;
 		reg-io-width = <4>;
 		smsc,irq-active-high;
 		smsc,irq-push-pull;
diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 256c2f8..8467e4c 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "renesas,emev2";
@@ -48,8 +49,8 @@
 
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
-		interrupts = <0 120 4>,
-			     <0 121 4>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
 	smu at e0110000 {
@@ -129,7 +130,7 @@
 	sti at e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
-		interrupts = <0 125 0>;
+		interrupts = <0 125 IRQ_TYPE_NONE>;
 		clocks = <&sti_sclk>;
 		clock-names = "sclk";
 	};
@@ -137,7 +138,7 @@
 	uart at e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
-		interrupts = <0 8 0>;
+		interrupts = <0 8 IRQ_TYPE_NONE>;
 		clocks = <&usia_u0_sclk>;
 		clock-names = "sclk";
 	};
@@ -145,7 +146,7 @@
 	uart at e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
-		interrupts = <0 9 0>;
+		interrupts = <0 9 IRQ_TYPE_NONE>;
 		clocks = <&usib_u1_sclk>;
 		clock-names = "sclk";
 	};
@@ -153,7 +154,7 @@
 	uart at e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
-		interrupts = <0 10 0>;
+		interrupts = <0 10 IRQ_TYPE_NONE>;
 		clocks = <&usib_u2_sclk>;
 		clock-names = "sclk";
 	};
@@ -161,7 +162,7 @@
 	uart at e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
-		interrupts = <0 11 0>;
+		interrupts = <0 11 IRQ_TYPE_NONE>;
 		clocks = <&usib_u3_sclk>;
 		clock-names = "sclk";
 	};
@@ -169,7 +170,8 @@
 	gpio0: gpio at e0050000 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
-		interrupts = <0 67 0>, <0 68 0>;
+		interrupts = <0 67 IRQ_TYPE_NONE>,
+			     <0 68 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpios = <32>;
@@ -179,7 +181,8 @@
 	gpio1: gpio at e0050080 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050080 0x2c>, <0xe00500c0 0x20>;
-		interrupts = <0 69 0>, <0 70 0>;
+		interrupts = <0 69 IRQ_TYPE_NONE>,
+			     <0 70 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpios = <32>;
@@ -189,7 +192,8 @@
 	gpio2: gpio at e0050100 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050100 0x2c>, <0xe0050140 0x20>;
-		interrupts = <0 71 0>, <0 72 0>;
+		interrupts = <0 71 IRQ_TYPE_NONE>,
+			     <0 72 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpios = <32>;
@@ -199,7 +203,8 @@
 	gpio3: gpio at e0050180 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050180 0x2c>, <0xe00501c0 0x20>;
-		interrupts = <0 73 0>, <0 74 0>;
+		interrupts = <0 73 IRQ_TYPE_NONE>,
+			     <0 74 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpios = <32>;
@@ -209,7 +214,8 @@
 	gpio4: gpio at e0050200 {
 		compatible = "renesas,em-gio";
 		reg = <0xe0050200 0x2c>, <0xe0050240 0x20>;
-		interrupts = <0 75 0>, <0 76 0>;
+		interrupts = <0 75 IRQ_TYPE_NONE>,
+			     <0 76 IRQ_TYPE_NONE>;
 		gpio-controller;
 		#gpio-cells = <2>;
 		ngpios = <31>;
-- 
1.8.4
