From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Jan 2017 22:17:31 +0100
Subject: [PATCH 1/4] ARM: dts: push MMC/SD to board and add comments
Message-ID: <20170131211731.4558-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the enable-active-high setting from the SoC to the
board for the VMMCQ regulators. It should at least be in the
vicinity of the GPIO line it is defined for.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi        | 2 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi  | 1 +
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 1 +
 arch/arm/boot/dts/ste-snowball.dts     | 6 +++++-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 48dc38482633..1b59943ab6ec 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -111,6 +111,7 @@
 			pinctrl-1 = <&i2c3_sleep_mode>;
 		};
 
+		/* ST6G3244ME level translator for 1.8/2.9 V */
 		vmmci: regulator-gpio {
 			compatible = "regulator-gpio";
 
@@ -120,7 +121,6 @@
 			regulator-type = "voltage";
 
 			startup-delay-us = <100>;
-			enable-active-high;
 
 			states = <1800000 0x1
 				  2900000 0x0>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index ece222d51717..5882a2606ac3 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -74,6 +74,7 @@
 		vmmci: regulator-gpio {
 			gpios = <&tc3589x_gpio 18 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 7187676836be..bf259bbd1d0a 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -146,6 +146,7 @@
 		vmmci: regulator-gpio {
 			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 386eee6de232..7900e5d6aa05 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -216,11 +216,15 @@
 			};
 		};
 
+		/* ST6G3244ME level translator for 1.8/2.9 V */
 		vmmci: regulator-gpio {
 			compatible = "regulator-gpio";
 
+			/* GPIO228 SD_SEL */
 			gpios = <&gpio7 4 GPIO_ACTIVE_HIGH>;
+			/* GPIO217 MMC_EN */
 			enable-gpio = <&gpio6 25 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
 
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2900000>;
@@ -228,7 +232,6 @@
 			regulator-type = "voltage";
 
 			startup-delay-us = <100>;
-			enable-active-high;
 
 			states = <1800000 0x1
 				  2900000 0x0>;
@@ -546,6 +549,7 @@
 				sdi0_default_mode: sdi0_default {
 					snowball_mux {
 						function = "mc0";
+						/* Add the DAT31 pin even if it is not really used */
 						groups = "mc0dat31dir_a_1";
 					};
 					snowball_cfg1 {
-- 
2.9.3
