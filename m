From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:48 +0800
Subject: [PATCH 7/9] ARM: dts: sun7i: bananapi-m1-plus: red LED is power LED
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The red led on the Bananapi M1+ is wired to light up as soon as the
board is powered, and continues to be lit while the GPIO is floating.

Rename the LED to "pwr", remove the default trigger, and mark it as
default on.

Also fix the pinmux node that was specifying a different pin for this
LED.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 14fb463758e4..ba5bca0fe997 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -70,12 +70,11 @@
 			gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
 		};
 
-		red {
-			label = "bananapi-m1-plus:red:usr";
+		pwr {
+			label = "bananapi-m1-plus:pwr:usr";
 			gpios = <&pio 7 25 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
+			default-state = "on";
 		};
-
 	};
 
 	mmc3_pwrseq: mmc3_pwrseq {
@@ -202,7 +201,7 @@
 	};
 
 	led_pins_bpi_m1p: led_pins at 0 {
-		allwinner,pins = "PH24", "PG2";
+		allwinner,pins = "PH24", "PH25";
 		allwinner,function = "gpio_out";
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.8.1
