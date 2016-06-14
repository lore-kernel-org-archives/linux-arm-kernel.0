From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jun 2016 10:17:56 +0800
Subject: [PATCH 08/10] ARM: dts: sun9i: cubieboard4: Order nodes by
 alphabetical order
In-Reply-To: <1465870678-30128-1-git-send-email-wens@csie.org>
References: <1465870678-30128-1-git-send-email-wens@csie.org>
Message-ID: <1465870678-30128-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the &pio node below the mmc nodes for proper ordering by name.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index a92eeea1b222..65f4f32f89ad 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -78,22 +78,6 @@
 	};
 };
 
-&pio {
-	led_pins_cubieboard4: led-pins at 0 {
-		allwinner,pins = "PH6", "PH17";
-		allwinner,function = "gpio_out";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-	};
-
-	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
-		allwinner,pins = "PH18";
-		allwinner,function = "gpio_in";
-		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-	};
-};
-
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_cubieboard4>;
@@ -119,6 +103,22 @@
 	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 };
 
+&pio {
+	led_pins_cubieboard4: led-pins at 0 {
+		allwinner,pins = "PH6", "PH17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc0_cd_pin_cubieboard4: mmc0_cd_pin at 0 {
+		allwinner,pins = "PH18";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+};
+
 &r_ir {
 	status = "okay";
 };
-- 
2.8.1
