From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 16 Jan 2014 13:52:30 +0100
Subject: [PATCH 4/4] ARM: dts: imx6: edmqmx6: Add LED support
In-Reply-To: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1389876750-29880-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The edmqmx6 has some GPIO controlled LEDs. Add support for them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index bafc392..b8a1ff4 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include "imx6q.dtsi"
 
 / {
@@ -58,6 +59,31 @@
 			enable-active-high;
 		};
 	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-blue {
+			label = "blue";
+			gpios = <&stmpe_gpio 8 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-green {
+			label = "green";
+			gpios = <&stmpe_gpio 9 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-pink {
+			label = "pink";
+			gpios = <&stmpe_gpio 10 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-red {
+			label = "red";
+			gpios = <&stmpe_gpio 11 GPIO_ACTIVE_HIGH>;
+		};
+	};
 };
 
 &fec {
@@ -186,6 +212,7 @@
 		interrupt-parent = <&gpio3>;
 
 		stmpe_gpio: stmpe_gpio {
+			#gpio-cells = <2>;
 			compatible = "st,stmpe-gpio";
 		};
 	};
-- 
1.8.5.2
