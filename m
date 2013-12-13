From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 12 Dec 2013 18:49:10 -0700
Subject: [PATCH V1 06/11] ARM: dts: imx6qdl-sabrelite: add gpio-keys
In-Reply-To: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1386899355-17379-7-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power, menu, home, back, volume up, and volume down
buttons.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index b548647..fa10ded 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -9,6 +9,7 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	memory {
@@ -49,6 +50,46 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		power {
+			label = "Power Button";
+			gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+			linux,code = <116>; /* KEY_POWER, or search */
+			gpio-key,wakeup;
+		};
+
+		menu {
+			label = "Menu";
+			gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			linux,code = <139>; /* KEY_MENU */
+		};
+
+		home {
+			label = "Home";
+			gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+			linux,code = <102>; /* KEY_HOME */
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+			linux,code = <158>; /* KEY_BACK */
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio7 13 GPIO_ACTIVE_LOW>;
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
+
 	sound {
 		compatible = "fsl,imx6q-sabrelite-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -121,6 +162,12 @@
 /* USDHC3 CD  */		MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
 /* USDHC3 WP  */		MX6QDL_PAD_SD3_DAT4__GPIO7_IO01		0x1f0b0
 /* SGTL5000 sys_mclk  */	MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x000b0
+/* Power Button */		MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
+/* Menu Button */		MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
+/* Home Button */		MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x1b0b0
+/* Back Button */		MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+/* Volume Up Button */		MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
+/* Volume Down Button */	MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
 			>;
 		};
 
-- 
1.8.1.2
