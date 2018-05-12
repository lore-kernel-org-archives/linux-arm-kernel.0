From: david@lechnology.com (David Lechner)
Date: Sat, 12 May 2018 16:41:59 -0500
Subject: [PATCH] ARM: dts: da850-lego-ev3: remove unnecessary gpio-keys
 properties
Message-ID: <20180512214159.22041-1-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the #address-cells and #size-cells properties from the
gpio-keys node in the da850-lego-ev3 device tree. These properties are
not needed since the child nodes don't have a reg property.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850-lego-ev3.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lego-ev3.dts b/arch/arm/boot/dts/da850-lego-ev3.dts
index d4a131b6a46e..3fe8db69f50c 100644
--- a/arch/arm/boot/dts/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/da850-lego-ev3.dts
@@ -33,8 +33,6 @@
 	 */
 	gpio_keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		label = "EV3 Brick Buttons";
 		pinctrl-names = "default";
 		pinctrl-0 = <&button_bias>;
-- 
2.17.0
