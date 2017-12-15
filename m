From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:58 +0100
Subject: [PATCH 24/25] arm: dm8: dts: Remove leading 0x and 0s from bindings
 notation
Message-ID: <20171215124658.31102-1-malat@debian.org>
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
 arch/arm/boot/dts/dm8148-evm.dts | 8 ++++----
 arch/arm/boot/dts/dm8168-evm.dts | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index d6657b3bae84..7747a5b9657f 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -74,19 +74,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition at 0x1c0000 {
+		partition at 1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition at 0x280000 {
+		partition at 280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition at 0x780000 {
+		partition at 780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index c72a2132aa82..85dd3c703dff 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -158,19 +158,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition at 0x80000 {
+		partition at 80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition at 0x1c0000 {
+		partition at 1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition at 0x280000 {
+		partition at 280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition at 0x780000 {
+		partition at 780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
-- 
2.11.0
