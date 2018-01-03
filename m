From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 Jan 2018 14:28:44 +0800
Subject: [PATCH] ARM: dts: sun8i: a83t: bananapi-m3: Add LED device nodes
Message-ID: <20180103062844.30315-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M3 has two controllable LEDs, blue and green, that are tied
to the PMIC's two GPIO pins.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 6550bf0e594b..78fe61d97790 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -60,6 +60,20 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		blue {
+			label = "bananapi-m3:blue:usr";
+			gpios = <&axp_gpio 1 GPIO_ACTIVE_HIGH>;
+		};
+
+		green {
+			label = "bananapi-m3:green:usr";
+			gpios = <&axp_gpio 0 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	reg_usb1_vbus: reg-usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
-- 
2.15.1
