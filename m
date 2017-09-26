From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:28 +0200
Subject: [PATCH v3 08/14] ARM: dts: sun8i: orangepipc: Fix node with unit name
 and no reg property
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index f5f0f15a2088..6d98bcfbe877 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -158,19 +158,19 @@
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
