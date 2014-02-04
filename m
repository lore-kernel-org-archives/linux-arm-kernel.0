From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  4 Feb 2014 20:52:17 +0100
Subject: [PATCH 01/10] ARM: ux500: move AB8500 GPIOs to device tree
Message-ID: <1391543546-11158-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the AB8500 muxing and biasing settings over from the board
file to the device tree, include it in the reference designs using
the AB8500: HREF prior to v60, v60plus and Snowball. Set up these
GPIO lines using hogs, just like in the board file.

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href-ab8500.dtsi  | 253 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi   |   1 +
 arch/arm/boot/dts/ste-hrefv60plus.dtsi  |   1 +
 arch/arm/boot/dts/ste-snowball.dts      |   1 +
 arch/arm/mach-ux500/board-mop500-pins.c |  79 ----------
 5 files changed, 256 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/ste-href-ab8500.dtsi

diff --git a/arch/arm/boot/dts/ste-href-ab8500.dtsi b/arch/arm/boot/dts/ste-href-ab8500.dtsi
new file mode 100644
index 000000000000..58b00d0f023e
--- /dev/null
+++ b/arch/arm/boot/dts/ste-href-ab8500.dtsi
@@ -0,0 +1,253 @@
+/*
+ * Copyright 2014 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	soc {
+		prcmu at 80157000 {
+			ab8500 {
+				ab8500-gpio {
+					/* Hog a few default settings */
+					pinctrl-names = "default";
+					pinctrl-0 = <&gpio2_default_mode>,
+						    <&gpio4_default_mode>,
+						    <&gpio10_default_mode>,
+						    <&gpio11_default_mode>,
+						    <&gpio12_default_mode>,
+						    <&gpio13_default_mode>,
+						    <&gpio16_default_mode>,
+						    <&gpio24_default_mode>,
+						    <&gpio25_default_mode>,
+						    <&gpio36_default_mode>,
+						    <&gpio37_default_mode>,
+						    <&gpio38_default_mode>,
+						    <&gpio39_default_mode>,
+						    <&gpio42_default_mode>,
+						    <&gpio26_default_mode>,
+						    <&gpio35_default_mode>;
+
+					/*
+					 * Pins 2, 4, 10, 11, 12, 13, 16, 24, 25, 36, 37, 38, 39 and 42
+					 * are muxed in as GPIO, and configured as INPUT PULL DOWN
+					 */
+					gpio2 {
+						gpio2_default_mode: gpio2_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio2_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO2_T9";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio4 {
+						gpio4_default_mode: gpio4_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio4_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO4_W2";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio10 {
+						gpio10_default_mode: gpio10_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio10_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO10_U17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio11 {
+						gpio11_default_mode: gpio11_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio11_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO11_AA18";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio12 {
+						gpio12_default_mode: gpio12_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio12_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO12_U16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio13 {
+						gpio13_default_mode: gpio13_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio13_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO13_W17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio16 {
+						gpio16_default_mode: gpio16_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio16_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO16_F15";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio24 {
+						gpio24_default_mode: gpio24_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio24_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO24_T14";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio25 {
+						gpio25_default_mode: gpio25_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio25_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO25_R16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio36 {
+						gpio36_default_mode: gpio36_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio36_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO36_A17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio37 {
+						gpio37_default_mode: gpio37_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio37_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO37_E15";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio38 {
+						gpio38_default_mode: gpio38_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio38_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO38_C17";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio39 {
+						gpio39_default_mode: gpio39_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio39_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO39_E16";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					gpio42 {
+						gpio42_default_mode: gpio42_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio42_a_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO42_U2";
+								input-enable;
+								bias-pull-down;
+							};
+						};
+					};
+					/*
+					 * Pins 26 and 35 muxed in as GPIO, and configured as OUTPUT LOW
+					 */
+					gpio26 {
+						gpio26_default_mode: gpio26_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio26_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO26_M16";
+								output-low;
+							};
+						};
+					};
+					gpio35 {
+						gpio35_default_mode: gpio35_default {
+							default_mux {
+								ste,function = "gpio";
+								ste,pins = "gpio35_d_1";
+							};
+							default_cfg {
+								ste,pins = "GPIO35_W15";
+								output-low;
+							};
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 40f0ecdf9303..abc762e24fcb 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -12,6 +12,7 @@
  */
 
 #include "ste-dbx5x0.dtsi"
+#include "ste-href-ab8500.dtsi"
 #include "ste-href.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 3b6d1181939b..c2341061b943 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "ste-dbx5x0.dtsi"
+#include "ste-href-ab8500.dtsi"
 #include "ste-href.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 97d5d21b7db7..a2f632d0be2a 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "ste-dbx5x0.dtsi"
+#include "ste-href-ab8500.dtsi"
 #include "ste-href-family-pinctrl.dtsi"
 
 / {
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index f63619b69113..139298043685 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -18,7 +18,6 @@
 /* These simply sets bias for pins */
 #define BIAS(a,b) static unsigned long a[] = { b }
 
-BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
 BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 
@@ -50,10 +49,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_MUX_STATE("gpio1_a_1", "gpio", "regulator.35", PINCTRL_STATE_SLEEP),
 	AB8500_PIN_STATE("GPIO1_T10", in_pd, "regulator.35", PINCTRL_STATE_SLEEP),
 
-	/* pins 2 is muxed in GPIO, configured in INPUT PULL DOWN */
-	AB8500_MUX_HOG("gpio2_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO2_T9", in_pd),
-
 	/* Sysclkreq4 */
 	AB8500_MUX_STATE("sysclkreq4_d_1", "sysclkreq", "regulator.36", PINCTRL_STATE_DEFAULT),
 	AB8500_PIN_STATE("GPIO3_U9", in_nopull, "regulator.36", PINCTRL_STATE_DEFAULT),
@@ -61,10 +56,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_MUX_STATE("gpio3_a_1", "gpio", "regulator.36", PINCTRL_STATE_SLEEP),
 	AB8500_PIN_STATE("GPIO3_U9", in_pd, "regulator.36", PINCTRL_STATE_SLEEP),
 
-	/* pins 4 is muxed in GPIO, configured in INPUT PULL DOWN */
-	AB8500_MUX_HOG("gpio4_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO4_W2", in_pd),
-
 	/*
 	 * pins 6,7,8 and 9 are muxed in YCBCR0123
 	 * configured in INPUT PULL UP
@@ -76,22 +67,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_HOG("GPIO9_AA19", in_nopull),
 
 	/*
-	 * pins 10,11,12 and 13 are muxed in GPIO
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("gpio10_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO10_U17", in_pd),
-
-	AB8500_MUX_HOG("gpio11_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO11_AA18", in_pd),
-
-	AB8500_MUX_HOG("gpio12_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO12_U16", in_pd),
-
-	AB8500_MUX_HOG("gpio13_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO13_W17", in_pd),
-
-	/*
 	 * pins 14,15 are muxed in PWM1 and PWM2
 	 * configured in INPUT PULL DOWN
 	 */
@@ -102,13 +77,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_HOG("GPIO15_B17", in_pd),
 
 	/*
-	 * pins 16 is muxed in GPIO
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("gpio16_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO14_F14", in_pd),
-
-	/*
 	 * pins 17,18,19 and 20 are muxed in AUDIO interface 1
 	 * configured in INPUT PULL DOWN
 	 */
@@ -128,23 +96,6 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_HOG("GPIO23_G19", in_pd),
 
 	/*
-	 * pins 24,25 are muxed in GPIO
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("gpio24_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO24_T14", in_pd),
-
-	AB8500_MUX_HOG("gpio25_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO25_R16", in_pd),
-
-	/*
-	 * pins 26 is muxed in GPIO
-	 * configured in OUTPUT LOW
-	 */
-	AB8500_MUX_HOG("gpio26_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO26_M16", out_lo),
-
-	/*
 	 * pins 27,28 are muxed in DMIC12
 	 * configured in INPUT PULL DOWN
 	 */
@@ -176,42 +127,12 @@ static struct pinctrl_map __initdata ab8500_pinmap[] = {
 	AB8500_PIN_HOG("GPIO34_R17", in_pd),
 
 	/*
-	 * pins 35 is muxed in GPIO
-	 * configured in OUTPUT LOW
-	 */
-	AB8500_MUX_HOG("gpio35_d_1", "gpio"),
-	AB8500_PIN_HOG("GPIO35_W15", in_pd),
-
-	/*
-	 * pins 36,37,38 and 39 are muxed in GPIO
-	 * configured in INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("gpio36_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO36_A17", in_pd),
-
-	AB8500_MUX_HOG("gpio37_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO37_E15", in_pd),
-
-	AB8500_MUX_HOG("gpio38_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO38_C17", in_pd),
-
-	AB8500_MUX_HOG("gpio39_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO39_E16", in_pd),
-
-	/*
 	 * pins 40 and 41 are muxed in MODCSLSDA
 	 * configured INPUT PULL DOWN
 	 */
 	AB8500_MUX_HOG("modsclsda_d_1", "modsclsda"),
 	AB8500_PIN_HOG("GPIO40_T19", in_pd),
 	AB8500_PIN_HOG("GPIO41_U19", in_pd),
-
-	/*
-	 * pins 42 is muxed in GPIO
-	 * configured INPUT PULL DOWN
-	 */
-	AB8500_MUX_HOG("gpio42_a_1", "gpio"),
-	AB8500_PIN_HOG("GPIO42_U2", in_pd),
 };
 
 static struct pinctrl_map __initdata ab8505_pinmap[] = {
-- 
1.8.5.3
