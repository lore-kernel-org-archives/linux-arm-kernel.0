From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  5 Mar 2016 18:02:51 +0000
Subject: [PATCH 3/5] ARM: bcm2835: use defined INT names instead of magic
 numbers
In-Reply-To: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
References: <1457200973-11662-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1457200973-11662-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Change the device tree source so that instead of magic numbers
the corresponding BCM2835_INT_* names are used to ease readability.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm283x.dtsi | 59 +++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8aaf193..084eda7 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
 #include <dt-bindings/clock/bcm2835.h>
 #include <dt-bindings/clock/bcm2835-aux.h>
+#include <dt-bindings/interrupt-controller/bcm2835.h>
 #include "skeleton.dtsi"
 
 /* This include file covers the common peripherals and configuration between
@@ -25,7 +26,10 @@
 		timer at 7e003000 {
 			compatible = "brcm,bcm2835-system-timer";
 			reg = <0x7e003000 0x1000>;
-			interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
+			interrupts = <BCM2835_INT_TIMER0>,
+				     <BCM2835_INT_TIMER1>,
+				     <BCM2835_INT_TIMER2>,
+				     <BCM2835_INT_TIMER3>;
 			/* This could be a reference to BCM2835_CLOCK_TIMER,
 			 * but we don't have the driver using the common clock
 			 * support yet.
@@ -36,19 +40,19 @@
 		dma: dma at 7e007000 {
 			compatible = "brcm,bcm2835-dma";
 			reg = <0x7e007000 0xf00>;
-			interrupts = <1 16>,
-				     <1 17>,
-				     <1 18>,
-				     <1 19>,
-				     <1 20>,
-				     <1 21>,
-				     <1 22>,
-				     <1 23>,
-				     <1 24>,
-				     <1 25>,
-				     <1 26>,
-				     <1 27>,
-				     <1 28>;
+			interrupts = <BCM2835_INT_DMA0>,
+				     <BCM2835_INT_DMA1>,
+				     <BCM2835_INT_DMA2>,
+				     <BCM2835_INT_DMA3>,
+				     <BCM2835_INT_DMA4>,
+				     <BCM2835_INT_DMA5>,
+				     <BCM2835_INT_DMA6>,
+				     <BCM2835_INT_DMA7>,
+				     <BCM2835_INT_DMA8>,
+				     <BCM2835_INT_DMA9>,
+				     <BCM2835_INT_DMA10>,
+				     <BCM2835_INT_DMA11_12_13_14>,
+				     <BCM2835_INT_DMA_ALL>;
 
 			#dma-cells = <1>;
 			brcm,dma-channel-mask = <0x7f35>;
@@ -85,7 +89,7 @@
 		mailbox: mailbox at 7e00b800 {
 			compatible = "brcm,bcm2835-mbox";
 			reg = <0x7e00b880 0x40>;
-			interrupts = <0 1>;
+			interrupts = <BCM2835_INT_ARM_MAILBOX>;
 			#mbox-cells = <0>;
 		};
 
@@ -103,7 +107,10 @@
 			 * So, a bank0 interrupt shows up on 17, 20, and
 			 * a bank1 interrupt shows up on 18, 19, 20!
 			 */
-			interrupts = <2 17>, <2 18>, <2 19>, <2 20>;
+			interrupts = <BCM2835_INT_GPIO0>,
+				     <BCM2835_INT_GPIO1>,
+				     <BCM2835_INT_GPIO2>,
+				     <BCM2835_INT_GPIO3>;
 
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -115,7 +122,7 @@
 		uart0: serial at 7e201000 {
 			compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
 			reg = <0x7e201000 0x1000>;
-			interrupts = <2 25>;
+			interrupts = <BCM2835_INT_UART>;
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
@@ -136,7 +143,7 @@
 		spi: spi at 7e204000 {
 			compatible = "brcm,bcm2835-spi";
 			reg = <0x7e204000 0x1000>;
-			interrupts = <2 22>;
+			interrupts = <BCM2835_INT_SPI>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -146,7 +153,7 @@
 		i2c0: i2c at 7e205000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e205000 0x1000>;
-			interrupts = <2 21>;
+			interrupts = <BCM2835_INT_I2C>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -163,7 +170,7 @@
 		uart1: serial at 7e215040 {
 			compatible = "brcm,bcm2835-aux-uart";
 			reg = <0x7e215040 0x40>;
-			interrupts = <1 29>;
+			interrupts = <BCM2835_INT_AUX_UART>;
 			clocks = <&aux BCM2835_AUX_CLOCK_UART>;
 			status = "disabled";
 		};
@@ -171,7 +178,7 @@
 		spi1: spi at 7e215080 {
 			compatible = "brcm,bcm2835-aux-spi";
 			reg = <0x7e215080 0x40>;
-			interrupts = <1 29>;
+			interrupts = <BCM2835_INT_AUX_SPI1>;
 			clocks = <&aux BCM2835_AUX_CLOCK_SPI1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -181,7 +188,7 @@
 		spi2: spi at 7e2150c0 {
 			compatible = "brcm,bcm2835-aux-spi";
 			reg = <0x7e2150c0 0x40>;
-			interrupts = <1 29>;
+			interrupts = <BCM2835_INT_AUX_SPI2>;
 			clocks = <&aux BCM2835_AUX_CLOCK_SPI2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -201,7 +208,7 @@
 		sdhci: sdhci at 7e300000 {
 			compatible = "brcm,bcm2835-sdhci";
 			reg = <0x7e300000 0x100>;
-			interrupts = <2 30>;
+			interrupts = <BCM2835_INT_ARSANSDIO>;
 			clocks = <&clocks BCM2835_CLOCK_EMMC>;
 			status = "disabled";
 		};
@@ -209,7 +216,7 @@
 		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
-			interrupts = <2 21>;
+			interrupts = <BCM2835_INT_I2C>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -219,7 +226,7 @@
 		i2c2: i2c at 7e805000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e805000 0x1000>;
-			interrupts = <2 21>;
+			interrupts = <BCM2835_INT_I2C>;
 			clocks = <&clocks BCM2835_CLOCK_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -229,7 +236,7 @@
 		usb: usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
-			interrupts = <1 9>;
+			interrupts = <BCM2835_INT_USB>;
 		};
 	};
 
-- 
2.1.4
