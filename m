From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Mar 2013 11:37:02 +0100
Subject: [PATCH] ARM: at91/dt: gpio-keys: remove address-cells and size-cells
 properties
In-Reply-To: <CAGhQ9Vx9D_4LnXOgveQ_vnTa-QfgwTkuLrU=_Et1Z2fD_hDCNg@mail.gmail.com>
References: <CAGhQ9Vx9D_4LnXOgveQ_vnTa-QfgwTkuLrU=_Et1Z2fD_hDCNg@mail.gmail.com>
Message-ID: <1363343822-25938-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gpio-keys nodes are not using the "reg" property in their sub nodes.
So, there is no need to define #address-cells and #size-cells properties
in gpio-keys nodes: we remove them.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         | 2 --
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 --
 arch/arm/boot/dts/at91sam9m10g45ek.dts      | 2 --
 arch/arm/boot/dts/at91sam9n12ek.dts         | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 1eb0872..aa0e184 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -155,8 +155,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		left_click {
 			label = "left_click";
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index da15e83..e041b72 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -167,8 +167,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		btn3 {
 			label = "Button 3";
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 20c3191..c795bfb 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -162,8 +162,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		left_click {
 			label = "left_click";
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d400f8d..7117c05 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -104,8 +104,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		enter {
 			label = "Enter";
-- 
1.8.0
