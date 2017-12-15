From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:40 +0100
Subject: [PATCH 09/25] arm: nspire: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124641.30333-1-malat@debian.org>
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
 arch/arm/boot/dts/nspire-classic.dtsi |  2 +-
 arch/arm/boot/dts/nspire-cx.dts       |  2 +-
 arch/arm/boot/dts/nspire.dtsi         | 28 ++++++++++++++--------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/nspire-classic.dtsi b/arch/arm/boot/dts/nspire-classic.dtsi
index 4907c5085d4b..84db1986001c 100644
--- a/arch/arm/boot/dts/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire-classic.dtsi
@@ -66,7 +66,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		intc: interrupt-controller at DC000000 {
+		intc: interrupt-controller at dc000000 {
 			compatible = "lsi,zevio-intc";
 			interrupt-controller;
 			reg = <0xDC000000 0x1000>;
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 08e0b81b3385..bf58fe095f19 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -92,7 +92,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		intc: interrupt-controller at DC000000 {
+		intc: interrupt-controller at dc000000 {
 			compatible = "arm,pl190-vic";
 			interrupt-controller;
 			reg = <0xDC000000 0x1000>;
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 1a5ae4cd107f..88b9126fad9f 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -24,7 +24,7 @@
 		reg = <0x00000000 0x80000>;
 	};
 
-	sram: sram at A4000000 {
+	sram: sram at a4000000 {
 		device = "memory";
 		reg = <0xA4000000 0x20000>;
 	};
@@ -75,11 +75,11 @@
 		#size-cells = <1>;
 		ranges;
 
-		spi: spi at A9000000 {
+		spi: spi at a9000000 {
 			reg = <0xA9000000 0x1000>;
 		};
 
-		usb0: usb at B0000000 {
+		usb0: usb at b0000000 {
 			compatible = "lsi,zevio-usb";
 			reg = <0xB0000000 0x1000>;
 			interrupts = <8>;
@@ -88,13 +88,13 @@
 			vbus-supply = <&vbus_reg>;
 		};
 
-		usb1: usb at B4000000 {
+		usb1: usb at b4000000 {
 			reg = <0xB4000000 0x1000>;
 			interrupts = <9>;
 			status = "disabled";
 		};
 
-		lcd: lcd at C0000000 {
+		lcd: lcd at c0000000 {
 			compatible = "arm,pl111", "arm,primecell";
 			reg = <0xC0000000 0x1000>;
 			interrupts = <21>;
@@ -103,16 +103,16 @@
 			clock-names = "apb_pclk";
 		};
 
-		adc: adc at C4000000 {
+		adc: adc at c4000000 {
 			reg = <0xC4000000 0x1000>;
 			interrupts = <11>;
 		};
 
-		tdes: crypto at C8010000 {
+		tdes: crypto at c8010000 {
 			reg = <0xC8010000 0x1000>;
 		};
 
-		sha256: crypto at CC000000 {
+		sha256: crypto at cc000000 {
 			reg = <0xCC000000 0x1000>;
 		};
 
@@ -141,13 +141,13 @@
 				interrupts = <1>;
 			};
 
-			timer0: timer at 900C0000 {
+			timer0: timer at 900c0000 {
 				reg = <0x900C0000 0x1000>;
 
 				clocks = <&timer_clk>;
 			};
 
-			timer1: timer at 900D0000 {
+			timer1: timer at 900d0000 {
 				reg = <0x900D0000 0x1000>;
 				interrupts = <19>;
 
@@ -165,16 +165,16 @@
 				interrupts = <4>;
 			};
 
-			misc: misc at 900A0000 {
+			misc: misc at 900a0000 {
 				reg = <0x900A0000 0x1000>;
 			};
 
-			pwr: pwr at 900B0000 {
+			pwr: pwr at 900b0000 {
 				reg = <0x900B0000 0x1000>;
 				interrupts = <15>;
 			};
 
-			keypad: input at 900E0000 {
+			keypad: input at 900e0000 {
 				compatible = "ti,nspire-keypad";
 				reg = <0x900E0000 0x1000>;
 				interrupts = <16>;
@@ -185,7 +185,7 @@
 				clocks = <&apb_pclk>;
 			};
 
-			contrast: contrast at 900F0000 {
+			contrast: contrast at 900f0000 {
 				reg = <0x900F0000 0x1000>;
 			};
 
-- 
2.11.0
