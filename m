From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Jan 2015 13:19:31 +0800
Subject: [PATCH v4 6/9] ARM: dts: sun9i: Convert a80 optimus board dts to
 label referencing
In-Reply-To: <1421471974-32719-1-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
Message-ID: <1421471974-32719-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The preferred method of referencing nodes from the dtsi is to use
labels, instead of copying the complete tree.

This patch converts sun9i-a80-optimus.dts to use label references.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 76 ++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 58f5cb346519..d4f3866a8d0b 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -61,45 +61,6 @@
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
 
-	soc {
-		pio: pinctrl at 06000800 {
-			i2c3_pins_a: i2c3 at 0 {
-				/* Enable internal pull-up */
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-
-			led_pins_optimus: led-pins at 0 {
-				allwinner,pins = "PH0", "PH1";
-				allwinner,function = "gpio_out";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			uart4_pins_a: uart4 at 0 {
-				/* Enable internal pull-up */
-				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
-			};
-		};
-
-		uart0: serial at 07000000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart0_pins_a>;
-			status = "okay";
-		};
-
-		uart4: serial at 07001000 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&uart4_pins_a>;
-			status = "okay";
-		};
-
-		i2c3: i2c at 07003400 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&i2c3_pins_a>;
-			status = "okay";
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -120,3 +81,40 @@
 		};
 	};
 };
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins_a>;
+	status = "okay";
+};
+
+&i2c3_pins_a {
+	/* Enable internal pull-up */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
+
+&pio {
+	led_pins_optimus: led-pins at 0 {
+		allwinner,pins = "PH0", "PH1";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+	status = "okay";
+};
+
+&uart4_pins_a {
+	/* Enable internal pull-up */
+	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+};
-- 
2.1.4
