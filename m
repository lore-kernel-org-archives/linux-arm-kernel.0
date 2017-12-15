From: malat@debian.org (Mathieu Malaterre)
Date: Fri, 15 Dec 2017 13:46:26 +0100
Subject: [PATCH 02/25] arm: at91/sama: dts: Remove leading 0x and 0s from
 bindings notation
Message-ID: <20171215124627.29979-1-malat@debian.org>
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
 arch/arm/boot/dts/at91sam9261.dtsi     | 2 +-
 arch/arm/boot/dts/at91sam9261ek.dts    | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi     | 2 +-
 arch/arm/boot/dts/at91sam9263ek.dts    | 2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts    | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi     | 2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts | 2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi      | 2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 66876019101d..eb186245fb4c 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -80,7 +80,7 @@
 			status = "disabled";
 		};
 
-		fb0: fb at 0x00600000 {
+		fb0: fb at 600000 {
 			compatible = "atmel,at91sam9261-lcdc";
 			reg = <0x00600000 0x1000>;
 			interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 960d6940ebf6..9733db3f739b 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -36,7 +36,7 @@
 			status = "okay";
 		};
 
-		fb0: fb at 0x00600000 {
+		fb0: fb at 600000 {
 			display = <&display0>;
 			atmel,power-control-gpio = <&pioA 12 GPIO_ACTIVE_LOW>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index e54f14d36b6f..a26f7ada429d 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -999,7 +999,7 @@
 			};
 		};
 
-		fb0: fb at 0x00700000 {
+		fb0: fb at 700000 {
 			compatible = "atmel,at91sam9263-lcdc";
 			reg = <0x00700000 0x1000>;
 			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 5a2e1af793f5..f095b5d4d410 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -95,7 +95,7 @@
 			};
 		};
 
-		fb0: fb at 0x00700000 {
+		fb0: fb at 700000 {
 			display = <&display0>;
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 91a71774472e..31fecc2cdaf9 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -25,7 +25,7 @@
 			};
 
 			i2c0: i2c at f8010000 {
-				ov2640: camera at 0x30 {
+				ov2640: camera at 30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2b127ca7aaa0..98348ebd6488 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1302,7 +1302,7 @@
 			};
 		};
 
-		fb0: fb at 0x00500000 {
+		fb0: fb at 500000 {
 			compatible = "atmel,at91sam9g45-lcdc";
 			reg = <0x00500000 0x1000>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index e922552a04cb..d793451ee04c 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -220,7 +220,7 @@
 			};
 		};
 
-		fb0: fb at 0x00500000 {
+		fb0: fb at 500000 {
 			display = <&display0>;
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 7f55050dd405..ef0f2d049e15 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -53,7 +53,7 @@
 			};
 
 			i2c1: i2c at f0018000 {
-				ov2640: camera at 0x30 {
+				ov2640: camera at 30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
index 83e3d3e08fd4..97e171db5970 100644
--- a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
@@ -88,7 +88,7 @@
 			};
 
 			i2c1: i2c at f0018000 {
-				ov2640: camera at 0x30 {
+				ov2640: camera at 30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
-- 
2.11.0
