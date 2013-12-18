From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 18 Dec 2013 14:51:44 -0700
Subject: [PATCH V3 1/1] ARM: dts: imx6qdl-sabrelite: add gpio-keys
Message-ID: <1387403504-26097-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power, menu, home, back, volume up, and volume down
buttons.

Also, apply same changes to imx6qdl-nitrogen6x.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v3: add pinctrl_gpio_keys, make same changes to
imx6qdl-nitrogen6x.dtsi

v2: add #include <dt-bindings/input/input.h>
to substitute KEY_POWER for 116
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 61 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 61 +++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index eab77df..78fe8b0 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -10,6 +10,8 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	memory {
@@ -50,6 +52,48 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+		power {
+			label = "Power Button";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			gpio-key,wakeup;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+		};
+
+		home {
+			label = "Home";
+			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx6q-nitrogen6x-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -183,6 +227,23 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				/* Power Button */
+				MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
+				/* Menu Button */
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
+				/* Home Button */
+				MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x1b0b0
+				/* Back Button */
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+				/* Volume Up Button */
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+				/* Volume Down Button */
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <MX6QDL_I2C1_PINGRP1>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index dbfc040..d28f501 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -9,6 +9,8 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	memory {
@@ -49,6 +51,48 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+		power {
+			label = "Power Button";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			gpio-key,wakeup;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_MENU>;
+		};
+
+		home {
+			label = "Home";
+			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOME>;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx6q-sabrelite-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -182,6 +226,23 @@
 			>;
 		};
 
+		pinctrl_gpio_keys: gpio_keysgrp {
+			fsl,pins = <
+				/* Power Button */
+				MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
+				/* Menu Button */
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
+				/* Home Button */
+				MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x1b0b0
+				/* Back Button */
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+				/* Volume Up Button */
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+				/* Volume Down Button */
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
+			>;
+		};
+
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <MX6QDL_I2C1_PINGRP1>;
 		};
-- 
1.8.1.2
