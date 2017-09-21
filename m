From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 21 Sep 2017 19:21:45 +0200
Subject: [PATCH 06/12] ARM: dts: sun8i: orangepi-lite: Fix node with unit name
 and no reg property
In-Reply-To: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
References: <20170921172151.29779-1-clabbe.montjoie@gmail.com>
Message-ID: <20170921172151.29779-7-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
index 9b47a0def740..a70a1daf4e2c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
@@ -141,19 +141,19 @@
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
 		pins = "PL3";
 		function = "gpio_in";
 	};
-- 
2.13.5
