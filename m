From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  1 Dec 2015 13:47:21 +0800
Subject: [PATCH 3/7] ARM: dts: sun9i: optimus: Enable LED3
In-Reply-To: <1448948845-28347-1-git-send-email-wens@csie.org>
References: <1448948845-28347-1-git-send-email-wens@csie.org>
Message-ID: <1448948845-28347-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LED3 is connected to pin PM15 on R_PIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 6ce4b5e8b615..ae7db9fcb2a7 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -65,7 +65,7 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pins_optimus>;
+		pinctrl-0 = <&led_pins_optimus>, <&led_r_pins_optimus>;
 
 		/* The LED names match those found on the board */
 
@@ -74,7 +74,10 @@
 			gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>;
 		};
 
-		/* led3 is on PM15, in R_PIO */
+		led3 {
+			label = "optimus:led3:usr";
+			gpios = <&r_pio 1 15 GPIO_ACTIVE_HIGH>; /* PM15 */
+		};
 
 		led4 {
 			label = "optimus:led4:usr";
@@ -180,6 +183,15 @@
 	status = "okay";
 };
 
+&r_pio {
+	led_r_pins_optimus: led-pins at 1 {
+		allwinner,pins = "PM15";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.6.2
