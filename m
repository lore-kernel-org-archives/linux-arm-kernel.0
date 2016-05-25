From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2016 13:55:39 +0200
Subject: [PATCH 2/3] ARM: dts: Ux500: name the GPIO lines on Snowball
Message-ID: <1464177339-27463-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the new line naming mechanism from the GPIO subsystem, name
the GPIO lines on the Snowball board that are connected as
GPIO on this design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 37ae6166b0e6..b3df1c60d465 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -95,6 +95,70 @@
 	};
 
 	soc {
+		/* Name the GPIO muxed rails on the Snowball board */
+		gpio at 8012e000 {
+			/* GPIOs 0 - 31 */
+			gpio-line-names = "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "",
+				     "AP_GPIO31";
+		};
+
+		gpio at 8012e080 {
+			/* GPIOs 32 - 63 */
+			gpio-line-names = "USR PB", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e000 {
+			/* GPIOs 64 - 95 */
+			gpio-line-names = "", "", "", "", "AP_GPIO68", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e100 {
+			/* GPIOs 128 - 159 */
+			gpio-line-names = "", "", "", "", "", "", "", "",
+				     "", "", "", "", "IRQ_LAN", "RSTn_LAN",
+				     "USR_LED", "", "", "", "", "", "",
+				     "", "", "AP_GPIO151", "AP_GPIO152",
+				     "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e180 {
+			/* GPIOs 160 - 191 */
+			gpio-line-names = "", "AP_GPIO161", "AP_GPIO162",
+				     "ACCELEROMETER_INT1_RDY",
+				     "ACCELEROMETER_INT2", "MAG_DRDY",
+				     "GYRO_DRDY", "RSTn_MLC", "RSTn_SLC",
+				     "GYRO_INT", "UART_WAKE", "GBF_RESET",
+				     "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8011e000 {
+			/* GPIOs 192 - 223 */
+			gpio-line-names = "HDTV_INTn", "", "", "", "HDTV_RST",
+				     "", "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "", "",
+				     "WLAN_RESETN", "WLAN_IRQ", "MMC_EN",
+				     "MMC_CD", "", "", "", "", "";
+		};
+
+		gpio at 8011e080 {
+			/* GPIOs 224 - 255 */
+			gpio-line-names = "", "", "", "", "SD_SEL", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
 		usb_per5 at a03e0000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&musb_default_mode>;
@@ -352,6 +416,25 @@
 
 			ab8500 {
 				ab8500-gpio {
+					/*
+					 * AB8500 GPIOs are numbered starting from 1, so the first
+					 * index 0 is what in the datasheet is called "GPIO1", and
+					 * the second is "GPIO2" and so forth. Confusingly, the
+					 * Snowball schematic then names the "GPIO2" line "PM_GPIO1".
+					 * while later naming "GPIO4" as "PM_GPIO4".
+					 */
+					gpio-line-names = "", /* AB8500 GPIO1 */
+						     "PM_GPIO1", /* AB8500 GPIO2 */
+						     "WLAN_CLK_REQ", /* AB8500 GPIO3 */
+						     "PM_GPIO4", /* AB8500 GPIO4 */
+						     "", "", "", "", "", "", "", "", "", "", "",
+						     "EN_3V6", /* AB8500 GPIO16 */
+						     "", "", "", "" ,"", "", "", "", "",
+						     "EN_3V3", /* AB8500 GPIO26 */
+						     "", "", "", "", "", "", "", "", "", "", "", "", "",
+						     "PM_GPIO40", /* AB8500 GPIO40 */
+						     "PM_GPIO41", /* AB8500 GPIO41 */
+						     "PM_GPIO42"; /* AB8500 GPIO42 */
 				};
 
 				ext_regulators: ab8500-ext-regulators {
-- 
2.4.11
