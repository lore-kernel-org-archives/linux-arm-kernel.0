From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 18:32:47 +0100
Subject: [PATCH] ARM: at91/dt: gpio-keys: address-cells and size-cells
 properties are not needed
Message-ID: <1425490367-27640-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gpio-keys nodes are not using the "reg" property in their sub nodes.
So, there is no need to define #address-cells and #size-cells properties
in gpio-keys nodes: we remove them in these new boards.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 2 --
 arch/arm/boot/dts/sama5d35ek.dts     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 843c39f7a3f2..89ef4a540db5 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -259,8 +259,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio>;
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index 9089c7c6cea8..d9a9aca1ccfd 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -44,8 +44,6 @@
 
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		pb_user1 {
 			label = "pb_user1";
-- 
2.1.3
