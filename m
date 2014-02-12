From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Feb 2014 22:03:12 -0700
Subject: [PATCH 2/2] ARM: bcm2835: add unit address to all nodes w/ reg prop
In-Reply-To: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
References: <1392181392-29694-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1392181392-29694-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes that contain a reg property should include a unit address in
their name. Add the missing unit addresses.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/boot/dts/bcm2835.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 5ceba45..9eadfb7 100644
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
@@ -121,7 +121,7 @@
 			status = "disabled";
 		};
 
-		sdhci: sdhci {
+		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
 			interrupts = <2 30>;
@@ -139,7 +139,7 @@
 			status = "disabled";
 		};
 
-		usb {
+		usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
@@ -155,21 +155,21 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		clk_mmc: mmc {
+		clk_mmc: clock at 0 {
 			compatible = "fixed-clock";
 			reg = <0>;
 			#clock-cells = <0>;
 			clock-frequency = <100000000>;
 		};
 
-		clk_i2c: i2c {
+		clk_i2c: clock at 1 {
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
 			clock-frequency = <250000000>;
 		};
 
-		clk_spi: spi {
+		clk_spi: clock at 2 {
 			compatible = "fixed-clock";
 			reg = <2>;
 			#clock-cells = <0>;
-- 
1.8.3.2
