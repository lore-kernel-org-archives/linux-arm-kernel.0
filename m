From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:33 +0100
Subject: [PATCH 06/25] arm: integrator: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124633.30182-1-malat@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This will solve as a side effect warning:

Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney@caviumnetworks.com>
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/arm/boot/dts/integratorap.dts | 14 +++++++-------
 arch/arm/boot/dts/integratorcp.dts | 20 ++++++++++----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 94d2ff9836d0..9efc753acb6d 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -56,7 +56,7 @@
 	};
 
 	/* 24 MHz chrystal on the Integrator/AP development board */
-	xtal24mhz: xtal24mhz at 24M {
+	xtal24mhz: xtal24mhz at 24m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
@@ -71,7 +71,7 @@
 	};
 
 	/* The UART clock is 14.74 MHz divided by an ICS525 */
-	uartclk: uartclk at 14.74M {
+	uartclk: uartclk at 14.74m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <14745600>;
@@ -80,14 +80,14 @@
 
 	core-module at 10000000 {
 		/* 24 MHz chrystal on the core module */
-		cm24mhz: cm24mhz at 24M {
+		cm24mhz: cm24mhz at 24m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 		};
 
 		/* Oscillator on the core module, clocks the CPU core */
-		cmosc: cmosc at 24M {
+		cmosc: cmosc at 24m {
 			compatible = "arm,syscon-icst525-integratorap-cm";
 			#clock-cells = <0>;
 			lock-offset = <0x14>;
@@ -96,7 +96,7 @@
 		};
 
 		/* Auxilary oscillator on the core module, 32.369MHz at boot */
-		auxosc: auxosc at 24M {
+		auxosc: auxosc at 24m {
 			compatible = "arm,syscon-icst525";
 			#clock-cells = <0>;
 			lock-offset = <0x14>;
@@ -116,7 +116,7 @@
 		 * SYSCLK clocks PCIv3 bridge, system controller and the
 		 * logic modules.
 		 */
-		sysclk: apsys at 24M {
+		sysclk: apsys at 24m {
 			compatible = "arm,syscon-icst525-integratorap-sys";
 			#clock-cells = <0>;
 			lock-offset = <0x1c>;
@@ -125,7 +125,7 @@
 		};
 
 		/* One-bit control for the PCI bus clock (33 or 25 MHz) */
-		pciclk: pciclk at 24M {
+		pciclk: pciclk at 24m {
 			compatible = "arm,syscon-icst525-integratorap-pci";
 			#clock-cells = <0>;
 			lock-offset = <0x1c>;
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index a185ab8759fa..76c41a04e8a0 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -47,14 +47,14 @@
 	 */
 
 	/* The codec chrystal operates at 24.576 MHz */
-	xtal_codec: xtal24.576 at 24.576M {
+	xtal_codec: xtal24.576 at 24.576m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <24576000>;
 	};
 
 	/* The chrystal is divided by 2 by the codec for the AACI bit clock */
-	aaci_bitclk: aaci_bitclk at 12.288M {
+	aaci_bitclk: aaci_bitclk at 12.288m {
 		#clock-cells = <0>;
 		compatible = "fixed-factor-clock";
 		clock-div = <2>;
@@ -63,14 +63,14 @@
 	};
 
 	/* This is a 25MHz chrystal on the base board */
-	xtal25mhz: xtal25mhz at 25M {
+	xtal25mhz: xtal25mhz at 25m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <25000000>;
 	};
 
 	/* The UART clock is 14.74 MHz divided from 25MHz by an ICS525 */
-	uartclk: uartclk at 14.74M {
+	uartclk: uartclk at 14.74m {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <14745600>;
@@ -85,14 +85,14 @@
 
 	core-module at 10000000 {
 		/* 24 MHz chrystal on the core module */
-		cm24mhz: cm24mhz at 24M {
+		cm24mhz: cm24mhz at 24m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 		};
 
 		/* Oscillator on the core module, clocks the CPU core */
-		cmcore: cmosc at 24M {
+		cmcore: cmosc at 24m {
 			compatible = "arm,syscon-icst525-integratorcp-cm-core";
 			#clock-cells = <0>;
 			lock-offset = <0x14>;
@@ -101,7 +101,7 @@
 		};
 
 		/* Oscillator on the core module, clocks the memory bus */
-		cmmem: cmosc at 24M {
+		cmmem: cmosc at 24m {
 			compatible = "arm,syscon-icst525-integratorcp-cm-mem";
 			#clock-cells = <0>;
 			lock-offset = <0x14>;
@@ -110,7 +110,7 @@
 		};
 
 		/* Auxilary oscillator on the core module, clocks the CLCD */
-		auxosc: auxosc at 24M {
+		auxosc: auxosc at 24m {
 			compatible = "arm,syscon-icst525";
 			#clock-cells = <0>;
 			lock-offset = <0x14>;
@@ -119,7 +119,7 @@
 		};
 
 		/* The KMI clock is the 24 MHz oscillator divided to 8MHz */
-		kmiclk: kmiclk at 1M {
+		kmiclk: kmiclk at 1m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <3>;
@@ -128,7 +128,7 @@
 		};
 
 		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
-		timclk: timclk at 1M {
+		timclk: timclk at 1m {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clock-div = <24>;
-- 
2.11.0
