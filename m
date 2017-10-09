From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:29 +0300
Subject: [PATCH 07/15] ARM: dts: at91: sama5d27_som1_ek: remove not connected
 CAN0
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-8-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CAN0 is not connected on the sama5d27_som1_ek board, so remove
it from DT.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[claudiu.beznea at microchip.com: change subject to match the desired prefix]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 339f4e71cf40..651ed5d4defc 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -175,12 +175,6 @@
 				status = "okay";
 			};
 
-			can0: can at f8054000 {
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_can0_default>;
-				status = "disabled"; /* Conflict with isc. */
-			};
-
 			uart3: serial at fc008000 {
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -279,12 +273,6 @@
 
 			pinctrl at fc038000 {
 
-				pinctrl_can0_default: can0_default {
-					pinmux = <PIN_PC10__CANTX0>,
-						 <PIN_PC11__CANRX0>;
-					bias-disable;
-				};
-
 				pinctrl_can1_default: can1_default {
 					pinmux = <PIN_PC26__CANTX1>,
 						 <PIN_PC27__CANRX1>;
-- 
2.7.4
