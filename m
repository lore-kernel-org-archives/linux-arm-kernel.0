From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 10 Dec 2015 21:36:29 +0800
Subject: [PATCH 1/3] ARM: dts: sun9i: cubieboard4: Enable LEDs
In-Reply-To: <1449754591-3999-1-git-send-email-wens@csie.org>
References: <1449754591-3999-1-git-send-email-wens@csie.org>
Message-ID: <1449754591-3999-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubieboard4 has 2 controllable LEDs, 1 red and 1 green.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is a resend of an old patch.

---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 6484dcf69873..8791d49bed2d 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -62,9 +62,31 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_cubieboard4>;
+
+		green {
+			label = "cubieboard4:green:usr";
+			gpios = <&pio 7 17 GPIO_ACTIVE_HIGH>; /* PH17 */
+		};
+
+		red {
+			label = "cubieboard4:red:usr";
+			gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
+		};
+	};
 };
 
 &pio {
+	led_pins_cubieboard4: led-pins at 0 {
+		allwinner,pins = "PH6", "PH17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
 		allwinner,pins = "PH18";
 		allwinner,function = "gpio_in";
-- 
2.6.2
