From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 12:03:34 +0800
Subject: [PATCH] ARM: sun8i: a83t: cubietruck-plus: Add LED device nodes
Message-ID: <20170522040334.26353-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck Plus has 4 LEDs in different colors.
Add device nodes for them.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index d2614f101ecc..9e10cc6f39d4 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -45,6 +45,8 @@
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	model = "Cubietech Cubietruck Plus";
 	compatible = "cubietech,cubietruck-plus", "allwinner,sun8i-a83t";
@@ -56,6 +58,30 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "cubietruck-plus:blue:usr";
+			gpios = <&pio 3 25 GPIO_ACTIVE_HIGH>; /* PD25 */
+		};
+
+		orange {
+			label = "cubietruck-plus:orange:usr";
+			gpios = <&pio 3 26 GPIO_ACTIVE_HIGH>; /* PD26 */
+		};
+
+		white {
+			label = "cubietruck-plus:white:usr";
+			gpios = <&pio 3 27 GPIO_ACTIVE_HIGH>; /* PD27 */
+		};
+
+		green {
+			label = "cubietruck-plus:green:usr";
+			gpios = <&pio 4 4 GPIO_ACTIVE_HIGH>; /* PE4 */
+		};
+	};
 };
 
 &uart0 {
-- 
2.11.0
