From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Thu, 14 Sep 2017 17:28:14 +0300
Subject: [PATCH 3/3] ARM: dts: at91: sama5d27_som1_ek: fix USB host vbus
In-Reply-To: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
References: <1505399294-20041-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1505399294-20041-4-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

The USB host has 3 ports so we must specify the entries for each
in the atmel,vbus-gpio property.
The specified pin (PA27) is the vbus for USBB and not USBA.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index be5cd913f274..60cb084a8d92 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -67,7 +67,10 @@
 
 		usb1: ohci at 00400000 {
 			num-ports = <3>;
-			atmel,vbus-gpio = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
+			atmel,vbus-gpio = <0 /* &pioA PIN_PD20 GPIO_ACTIVE_HIGH */
+					   &pioA PIN_PA27 GPIO_ACTIVE_HIGH
+					   0
+					  >;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
-- 
2.7.4
