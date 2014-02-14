From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 23:04:44 -0700
Subject: [PATCH V2] ARM: bcm2835: node name unit address cleanup
Message-ID: <1392357884-17682-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes that contain a reg property should include a unit address in
their name. Add the missing unit addresses.

The unit address in a node name must match the value in the reg property.
Fix the cases where they don't match.

Don't fix the /clocks/* node names yet; that causes problems the clock
driver to attempt to register multiple clocks with the same name, which
fails.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
v2:
* Fix existing mismatching unit addresses.
* Don't touch the /clocks/* nodes.
---
 arch/arm/boot/dts/bcm2835.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 5ceba45..a2d4889 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -15,7 +15,7 @@
 		#size-cells = <1>;
 		ranges = <0x7e000000 0x20000000 0x02000000>;
 
-		timer {
+		timer at 7e003000 {
 			compatible = "brcm,bcm2835-system-timer";
 			reg = <0x7e003000 0x1000>;
 			interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
@@ -43,24 +43,24 @@
 			brcm,dma-channel-mask = <0x7f35>;
 		};
 
-		intc: interrupt-controller {
+		intc: interrupt-controller at 7e00b200 {
 			compatible = "brcm,bcm2835-armctrl-ic";
 			reg = <0x7e00b200 0x200>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
 
-		watchdog {
+		watchdog at 7e100000 {
 			compatible = "brcm,bcm2835-pm-wdt";
 			reg = <0x7e100000 0x28>;
 		};
 
-		rng {
+		rng at 7e104000 {
 			compatible = "brcm,bcm2835-rng";
 			reg = <0x7e104000 0x10>;
 		};
 
-		gpio: gpio {
+		gpio: gpio at 7e200000 {
 			compatible = "brcm,bcm2835-gpio";
 			reg = <0x7e200000 0xb4>;
 			/*
@@ -83,7 +83,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		uart at 20201000 {
+		uart at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
 			interrupts = <2 25>;
@@ -101,7 +101,7 @@
 			dma-names = "tx", "rx";
 		};
 
-		spi: spi at 20204000 {
+		spi: spi at 7e204000 {
 			compatible = "brcm,bcm2835-spi";
 			reg = <0x7e204000 0x1000>;
 			interrupts = <2 22>;
@@ -121,7 +121,7 @@
 			status = "disabled";
 		};
 
-		sdhci: sdhci {
+		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
 			interrupts = <2 30>;
@@ -129,7 +129,7 @@
 			status = "disabled";
 		};
 
-		i2c1: i2c at 20804000 {
+		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
 			interrupts = <2 21>;
@@ -139,7 +139,7 @@
 			status = "disabled";
 		};
 
-		usb {
+		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
-- 
1.8.3.2
