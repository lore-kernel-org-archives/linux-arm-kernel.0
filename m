From: tony@atomide.com (Tony Lindgren)
Date: Fri,  9 Sep 2016 14:07:29 -0700
Subject: [PATCH] ARM: dts: Add power button support for igepv5
Message-ID: <20160909210729.20184-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power button support for igepv5.

Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Pau Pajuel <ppajuel@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-igep0050.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -7,6 +7,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/input/input.h>
 #include "omap5-board-common.dtsi"
 
 / {
@@ -17,6 +18,18 @@
 		device_type = "memory";
 		reg = <0x80000000 0x7f000000>; /* 2032 MB */
 	};
+
+	gpio_keys {
+                compatible = "gpio-keys";
+		pinctrl-0 = <&power_button_pin>;
+		pinctrl-names = "default";
+
+		power-button {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &hdmi {
@@ -58,6 +71,12 @@
 			OMAP5_IOPAD(0x0fa, PIN_INPUT | MUX_MODE0)	/* i2c4_sda */
 		>;
 	};
+
+	power_button_pin: pinctrl_power_button_pin {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x086, PIN_INPUT | MUX_MODE6)	/* gpio4_118 */
+		>;
+	};
 };
 
 &tpd12s015 {
-- 
2.9.3
