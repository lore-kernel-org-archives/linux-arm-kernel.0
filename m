From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 21 Sep 2017 19:21:44 +0200
Subject: [PATCH 05/12] ARM: dts: orangepi2: Fix node with unit name and no reg
 property
In-Reply-To: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
References: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
Message-ID: <20170921172151.29779-6-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 17cdeae19c6f..b20be95b49d5 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -160,24 +160,24 @@
 };
 
 &pio {
-	leds_opc: led_pins at 0 {
+	leds_opc: led_pins {
 		pins = "PA15";
 		function = "gpio_out";
 	};
 };
 
 &r_pio {
-	leds_r_opc: led_pins at 0 {
+	leds_r_opc: led_pins {
 		pins = "PL10";
 		function = "gpio_out";
 	};
 
-	sw_r_opc: key_pins at 0 {
+	sw_r_opc: key_pins {
 		pins = "PL3", "PL4";
 		function = "gpio_in";
 	};
 
-	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin at 0 {
+	wifi_pwrseq_pin_orangepi: wifi_pwrseq_pin {
 		pins = "PL7";
 		function = "gpio_out";
 	};
-- 
2.13.5
