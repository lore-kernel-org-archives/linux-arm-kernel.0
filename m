From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:13 +0900
Subject: [PATCH 07/19] ARM: shmobile: emev2 dtsi: Use generic names for device
 nodes
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
Message-ID: <87982b2d9a75e10b357e6015f27b94011fc697be.1414556943.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

smu -> clocks
sti -> timer
uart -> serial

All but "clocks" are defined in ePAPR v1.1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 00eeed3..5fe9212 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -55,7 +55,7 @@
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	smu at e0110000 {
+	clocks at e0110000 {
 		compatible = "renesas,emev2-smu";
 		reg = <0xe0110000 0x10000>;
 		#address-cells = <2>;
@@ -129,7 +129,7 @@
 		};
 	};
 
-	sti at e0180000 {
+	timer at e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
 		interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
@@ -137,7 +137,7 @@
 		clock-names = "sclk";
 	};
 
-	uart at e1020000 {
+	serial at e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -145,7 +145,7 @@
 		clock-names = "sclk";
 	};
 
-	uart at e1030000 {
+	serial at e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -153,7 +153,7 @@
 		clock-names = "sclk";
 	};
 
-	uart at e1040000 {
+	serial at e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -161,7 +161,7 @@
 		clock-names = "sclk";
 	};
 
-	uart at e1050000 {
+	serial at e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.1
