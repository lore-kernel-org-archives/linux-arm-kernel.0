From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:24 +0200
Subject: [PATCH v3 04/14] ARM: dts: nanopi: Fix node with unit name and no reg
 property
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
index c6decee41a27..7646e331bd29 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
@@ -81,7 +81,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&sw_r_npi>;
 
-		k1 at 0 {
+		k1 {
 			label = "k1";
 			linux,code = <KEY_POWER>;
 			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
@@ -108,19 +108,19 @@
 };
 
 &pio {
-	leds_npi: led_pins at 0 {
+	leds_npi: led_pins {
 		pins = "PA10";
 		function = "gpio_out";
 	};
 };
 
 &r_pio {
-	leds_r_npi: led_pins at 0 {
+	leds_r_npi: led_pins {
 		pins = "PL10";
 		function = "gpio_out";
 	};
 
-	sw_r_npi: key_pins at 0 {
+	sw_r_npi: key_pins {
 		pins = "PL3";
 		function = "gpio_in";
 	};
-- 
2.13.5
