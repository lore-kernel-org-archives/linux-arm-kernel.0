From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:58 -0700
Subject: [PATCH V2 08/13] ARM: dts: imx6qdl-sabrelite: add gpio-keys
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-9-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power, menu, home, back, volume up, and volume down
buttons.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: add #include <dt-bindings/input/input.h>
to substitute KEY_POWER for 116
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 29f0b40..36ffbb2 100644
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
@@ -49,6 +51,46 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
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
@@ -116,6 +158,18 @@
 			fsl,pins = <
 				/* SGTL5000 sys_mclk */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x030b0
+				/* Power Button */
+				MX6QDL_PAD_NANDF_D3__GPIO2_IO03	0x1b0b0
+				/* Menu Button */
+				MX6QDL_PAD_NANDF_D1__GPIO2_IO01	0x1b0b0
+				/* Home Button */
+				MX6QDL_PAD_NANDF_D4__GPIO2_IO04	0x1b0b0
+				/* Back Button */
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02	0x1b0b0
+				/* Volume Up Button */
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13	0x1b0b0
+				/* Volume Down Button */
+				MX6QDL_PAD_GPIO_19__GPIO4_IO05	0x1b0b0
 			>;
 		};
 
-- 
1.8.1.2
