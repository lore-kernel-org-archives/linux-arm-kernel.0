From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:45 +0100
Subject: [PATCH 13/25] arm: spear: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124645.30535-1-malat@debian.org>
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
 arch/arm/boot/dts/spear1310-evb.dts | 4 ++--
 arch/arm/boot/dts/spear300.dtsi     | 2 +-
 arch/arm/boot/dts/spear310.dtsi     | 2 +-
 arch/arm/boot/dts/spear320-hmi.dts  | 4 ++--
 arch/arm/boot/dts/spear320.dtsi     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 84101e4eebbf..438e3e16aeda 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -133,7 +133,7 @@
 				label = "u-boot";
 				reg = <0x80000 0x140000>;
 			};
-			partition at 1C0000 {
+			partition at 1c0000 {
 				label = "environment";
 				reg = <0x1C0000 0x40000>;
 			};
@@ -145,7 +145,7 @@
 				label = "linux";
 				reg = <0x240000 0xC00000>;
 			};
-			partition at E40000 {
+			partition at e40000 {
 				label = "rootfs";
 				reg = <0xE40000 0x0>;
 			};
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index f4e92e599729..266fefa67223 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -52,7 +52,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller at 0x50000000 {
+		shirq: interrupt-controller at 50000000 {
 			compatible = "st,spear300-shirq";
 			reg = <0x50000000 0x1000>;
 			interrupts = <28>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index da210b454753..f995ecf09acf 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -40,7 +40,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller at 0xb4000000 {
+		shirq: interrupt-controller at b4000000 {
 			compatible = "st,spear310-shirq";
 			reg = <0xb4000000 0x1000>;
 			interrupts = <28 29 30 1>;
diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
index 0d0da1f65f0e..6591cd616d0e 100644
--- a/arch/arm/boot/dts/spear320-hmi.dts
+++ b/arch/arm/boot/dts/spear320-hmi.dts
@@ -113,7 +113,7 @@
 				label = "u-boot";
 				reg = <0x80000 0x140000>;
 			};
-			partition at 1C0000 {
+			partition at 1c0000 {
 				label = "environment";
 				reg = <0x1C0000 0x40000>;
 			};
@@ -125,7 +125,7 @@
 				label = "linux";
 				reg = <0x240000 0xC00000>;
 			};
-			partition at E40000 {
+			partition at e40000 {
 				label = "rootfs";
 				reg = <0xE40000 0x0>;
 			};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 22be6e5edaac..2a062a3ee139 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -55,7 +55,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller at 0xb3000000 {
+		shirq: interrupt-controller at b3000000 {
 			compatible = "st,spear320-shirq";
 			reg = <0xb3000000 0x1000>;
 			interrupts = <30 28 29 1>;
-- 
2.11.0
