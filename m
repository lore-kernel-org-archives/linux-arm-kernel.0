From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 6 Feb 2014 13:08:08 -0200
Subject: [PATCH] ARM: dts: imx6sl-evk: Add debug LED support
Message-ID: <1391699288-7101-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO3_20 is connected to a debug LED. 

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 0001804..4d23e28 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include "imx6sl.dtsi"
 
@@ -19,6 +20,18 @@
 		reg = <0x80000000 0x40000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_led>;
+
+		user {
+			label = "debug";
+			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -108,6 +121,12 @@
 			>;
 		};
 
+		pinctrl_led: ledgrp {
+			fsl,pins = <
+				MX6SL_PAD_HSIC_STROBE__GPIO3_IO20 0x17059
+			>;
+		};
+
 		pinctrl_kpp: kppgrp {
 			fsl,pins = <
 				MX6SL_PAD_KEY_ROW0__KEY_ROW0    0x1b010
-- 
1.8.1.2
