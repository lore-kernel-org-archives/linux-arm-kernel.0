From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Mar 2016 15:51:19 +0100
Subject: [PATCH 1/2] ARM: dts: ux500: use the GPIO DT header
Message-ID: <1458831079-10457-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the <dt-bindings/gpio/gpio.h> header instead of using
hardcoded values for the GPIO flags. Eradicate the totally
bogus "0x4" flag used and set that to GPIO_ACTIVE_HIGH as is
proper, switch the inverted card detect on the Snowball to
flag using GPIO_ACTIVE_LOW instead of using the MMC-specific
inversion flag.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-ccu9540.dts          |  2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi          |  1 +
 arch/arm/boot/dts/ste-href-stuib.dtsi      |  4 ++--
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi |  4 ++--
 arch/arm/boot/dts/ste-hrefprev60.dtsi      |  8 ++++----
 arch/arm/boot/dts/ste-hrefv60plus.dtsi     |  6 +++---
 arch/arm/boot/dts/ste-snowball.dts         | 19 +++++++++----------
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ccu9540.dts b/arch/arm/boot/dts/ste-ccu9540.dts
index c8b815819cfe..b3b9bb8e1aa8 100644
--- a/arch/arm/boot/dts/ste-ccu9540.dts
+++ b/arch/arm/boot/dts/ste-ccu9540.dts
@@ -49,7 +49,7 @@
 			cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
-			cd-gpios  = <&gpio7 6 0x4>; // 230
+			cd-gpios  = <&gpio7 6 GPIO_ACTIVE_HIGH>; // 230
 			cd-inverted;
 
 			status = "okay";
diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 341f5b7ed242..d85830d80252 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/dbx500-prcmu.h>
 #include <dt-bindings/arm/ux500_pm_domains.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index c3987ad06d79..6f720756057d 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -22,13 +22,13 @@
 
 		button at 139 {
 			/* Proximity sensor */
-			gpios = <&gpio6 25 0x4>;
+			gpios = <&gpio6 25 GPIO_ACTIVE_HIGH>;
 			linux,code = <11>; /* SW_FRONT_PROXIMITY */
 			label = "SFH7741 Proximity Sensor";
 		};
 		button at 145 {
 			/* Hall sensor */
-			gpios = <&gpio4 17 0x4>;
+			gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
 			linux,code = <0>; /* SW_LID */
 			label = "HED54XXU11 Hall Effect Sensor";
 		};
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 55f9d0cc90f3..54d80da2a5df 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -24,13 +24,13 @@
 
 		button at 139 {
 			/* Proximity sensor */
-			gpios = <&gpio6 25 0x4>;
+			gpios = <&gpio6 25 GPIO_ACTIVE_HIGH>;
 			linux,code = <11>; /* SW_FRONT_PROXIMITY */
 			label = "SFH7741 Proximity Sensor";
 		};
 		button at 145 {
 			/* Hall sensor */
-			gpios = <&gpio4 17 0x4>;
+			gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
 			linux,code = <0>; /* SW_LID */
 			label = "HED54XXU11 Hall Effect Sensor";
 		};
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index b0278f4c486c..ece222d51717 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -18,7 +18,7 @@
 / {
 	gpio_keys {
 		button at 1 {
-			gpios = <&tc3589x_gpio 7 0x4>;
+			gpios = <&tc3589x_gpio 7 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -68,12 +68,12 @@
 
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
-			cd-gpios  = <&tc3589x_gpio 3 0x4>;
+			cd-gpios  = <&tc3589x_gpio 3 GPIO_ACTIVE_HIGH>;
 		};
 
 		vmmci: regulator-gpio {
-			gpios = <&tc3589x_gpio 18 0x4>;
-			enable-gpio = <&tc3589x_gpio 17 0x4>;
+			gpios = <&tc3589x_gpio 18 GPIO_ACTIVE_HIGH>;
+			enable-gpio = <&tc3589x_gpio 17 GPIO_ACTIVE_HIGH>;
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 149a72e7e37a..45d7af326718 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -20,12 +20,12 @@
 	soc {
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
-			cd-gpios  = <&gpio2 31 0x4>; // 95
+			cd-gpios  = <&gpio2 31 GPIO_ACTIVE_HIGH>; // 95
 		};
 
 		vmmci: regulator-gpio {
-			gpios = <&gpio0 5 0x4>;
-			enable-gpio = <&gpio5 9 0x4>;
+			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+			enable-gpio = <&gpio5 9 GPIO_ACTIVE_HIGH>;
 		};
 
 		pinctrl {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 08f82077b64d..36e84efc401c 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -50,35 +50,35 @@
 			wakeup-source;
 			linux,code = <2>;
 			label = "userpb";
-			gpios = <&gpio1 0 0x4>;
+			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
 		};
 		button at 2 {
 			debounce_interval = <50>;
 			wakeup-source;
 			linux,code = <3>;
 			label = "extkb1";
-			gpios = <&gpio4 23 0x4>;
+			gpios = <&gpio4 23 GPIO_ACTIVE_HIGH>;
 		};
 		button at 3 {
 			debounce_interval = <50>;
 			wakeup-source;
 			linux,code = <4>;
 			label = "extkb2";
-			gpios = <&gpio4 24 0x4>;
+			gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
 		};
 		button at 4 {
 			debounce_interval = <50>;
 			wakeup-source;
 			linux,code = <5>;
 			label = "extkb3";
-			gpios = <&gpio5 1 0x4>;
+			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 		};
 		button at 5 {
 			debounce_interval = <50>;
 			wakeup-source;
 			linux,code = <6>;
 			label = "extkb4";
-			gpios = <&gpio5 2 0x4>;
+			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -88,7 +88,7 @@
 		pinctrl-0 = <&gpioled_snowball_mode>;
 		used-led {
 			label = "user_led";
-			gpios = <&gpio4 14 0x4>;
+			gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
@@ -155,8 +155,8 @@
 		vmmci: regulator-gpio {
 			compatible = "regulator-gpio";
 
-			gpios = <&gpio7 4 0x4>;
-			enable-gpio = <&gpio6 25 0x4>;
+			gpios = <&gpio7 4 GPIO_ACTIVE_HIGH>;
+			enable-gpio = <&gpio6 25 GPIO_ACTIVE_HIGH>;
 
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2900000>;
@@ -182,8 +182,7 @@
 			pinctrl-0 = <&sdi0_default_mode>;
 			pinctrl-1 = <&sdi0_sleep_mode>;
 
-			cd-gpios  = <&gpio6 26 0x4>; // 218
-			cd-inverted;
+			cd-gpios  = <&gpio6 26 GPIO_ACTIVE_LOW>; // 218
 
 			status = "okay";
 		};
-- 
2.4.3
