From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:23 +0300
Subject: [PATCH 01/15] ARM: dts: at91: sama5d27_som1_ek: add disabled status
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-2-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add disabled statuses for all devices and for those those which pins
are in conflict with other devices add a comment in the DT file to specify
this.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 60cb084a8d92..43bca17b9e4e 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -168,6 +168,7 @@
 			can0: can at f8054000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_can0_default>;
+				status = "disabled"; /* Conflict with isc. */
 			};
 
 			uart3: serial at fc008000 {
@@ -175,7 +176,7 @@
 				atmel,use-dma-tx;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart3_default>;
-				status = "disabled";
+				status = "disabled"; /* Conflict with isc. */
 			};
 
 			uart4: serial at fc00c000 {
@@ -199,7 +200,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx3_default>;
 					atmel,fifo-size = <32>;
-					status = "disabled";
+					status = "disabled"; /* Conflict with isc. */
 				};
 
 				spi2: spi at 400 {
@@ -211,7 +212,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx3_default>;
 					atmel,fifo-size = <16>;
-					status = "disabled";
+					status = "disabled"; /* Conflict with isc. */
 				};
 			};
 
@@ -228,7 +229,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx4_default>;
 					atmel,fifo-size = <32>;
-					status = "disabled";
+					status = "disabled"; /* Conflict with spi3 and i2c3. */
 				};
 
 				spi3: spi at 400 {
@@ -240,7 +241,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_mikrobus_spi &pinctrl_mikrobus1_spi_cs &pinctrl_mikrobus2_spi_cs>;
 					atmel,fifo-size = <16>;
-					status = "okay";
+					status = "okay"; /* Conflict with uart6 and i2c3. */
 				};
 
 				i2c3: i2c at 600 {
@@ -255,7 +256,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_flx4_default>;
 					atmel,fifo-size = <16>;
-					status = "disabled";
+					status = "disabled"; /* Conflict with uart6 and spi3. */
 				};
 			};
 
-- 
2.7.4
