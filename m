From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 14 Sep 2017 17:28:12 +0300
Subject: [PATCH 1/3] ARM: dts: at91: sama5d27_som1_ek: update pinmux/pinconf
 for LEDs and USB
In-Reply-To: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
References: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1505399294-20041-2-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

There are some changes from the prototype board concerning LEDs and USB
pins:
- USBB power enable and red LED pins are inverted.
- The polarity of LEDs is inverted too.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 9c9088c99cc4..f13ef4fbab60 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -67,7 +67,7 @@
 
 		usb1: ohci at 00400000 {
 			num-ports = <3>;
-			atmel,vbus-gpio = <&pioA PIN_PA10 GPIO_ACTIVE_HIGH>;
+			atmel,vbus-gpio = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
@@ -330,7 +330,7 @@
 				};
 
 				pinctrl_led_gpio_default: led_gpio_default {
-					pinmux = <PIN_PA27__GPIO>,
+					pinmux = <PIN_PA10__GPIO>,
 						 <PIN_PB1__GPIO>,
 						 <PIN_PA31__GPIO>;
 					bias-pull-up;
@@ -396,7 +396,7 @@
 				};
 
 				pinctrl_usb_default: usb_default {
-					pinmux = <PIN_PA10__GPIO>,
+					pinmux = <PIN_PA27__GPIO>,
 						 <PIN_PD19__GPIO>;
 					bias-disable;
 				};
@@ -520,17 +520,17 @@
 
 		red {
 			label = "red";
-			gpios = <&pioA PIN_PA27 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PA10 GPIO_ACTIVE_HIGH>;
 		};
 
 		green {
 			label = "green";
-			gpios = <&pioA PIN_PB1 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PB1 GPIO_ACTIVE_HIGH>;
 		};
 
 		blue {
 			label = "blue";
-			gpios = <&pioA PIN_PA31 GPIO_ACTIVE_LOW>;
+			gpios = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
-- 
2.7.4
