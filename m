From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 May 2016 13:55:46 +0200
Subject: [PATCH 3/3] ARM: dts: UX500: name the GPIO lines on HREFv60plus
Message-ID: <1464177346-27510-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the new line naming mechanism from the GPIO subsystem, name
the GPIO lines on the HREFv60plus board that are connected as
GPIO on this design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 120 +++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index 45d7af326718..7187676836be 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -18,6 +18,126 @@
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
 
 	soc {
+		/* Name the GPIO muxed rails on the HREF boards */
+		gpio at 8012e000 {
+			/* GPIOs 0 - 31 */
+			gpio-line-names =
+				     /* GPIO0,1 used for UART0 BT RX/TX */
+				     "", "",
+				     "UART_WAKE",
+				     "BT_WAKE",
+				     "",
+				     "SDMMC_1V8_3V_SEL",
+				     "FLASH_LED_SYNC (FLASH_CTRL_0)",
+				     "XENON_READY (FLASH_CTRL_1)",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "",
+				     "",
+				     "FLASH_LED_EN (FLASH_CTRL_3)",
+				     "", "",
+				     "", "", "", "", "",
+				     /* Used by UART2 (console) */
+				     "", "",
+				     "MAGNETOMETER_INT";
+		};
+
+		gpio at 8012e080 {
+			/* GPIOs 32 - 63 */
+			gpio-line-names =
+				     "MAGNETOMETER_DRDY",
+				     "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e000 {
+			/* GPIOs 64 - 95 */
+			gpio-line-names = "XENON_EN2 (FLASH_CTRL_4)",
+				     "DISP1_RST",
+				     "DISP2_RST",
+				     "TOUCH_INT2",
+				     "LCD_VSI0_A",
+				     "LCD_VSI1_A",
+				     /* GPIO 70-77 used for ETM */
+				     "", "", "", "", "", "", "", "",
+				     /* GPIO 78-81 used for YCBCR */
+				     "", "", "", "",
+				     "ACCELEROMETER_INT1_RDY",
+				     "ACCELEROMETER_INT2",
+				     "TOUCH_INT",
+				     "WLAN_ENA",
+				     "", "", "", "", "",
+				     "FORCE_SENSING_INT",
+				     "FORCE_SENSING_RESET",
+				     "", "",
+				     "SDMMC_CD";
+		};
+
+		gpio at 8000e080 {
+			/* GPIOs 96 - 127 */
+			gpio-line-names = "",
+				     "FORCE_SENSING_WU",
+				     "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e100 {
+			/* GPIOs 128 - 159 */
+			gpio-line-names = "", "", "", "", "", "", "", "",
+				     "", "", "",
+				     "DIPRO_INT", /* GPIO139 */
+				     "XSHUTDOWN_SECONDARY_SENSOR",
+				     "XSHUTDOWN_PRIMARY_SENSOR",
+				     "NFC_RST (NFC_CTRL_",
+				     "TOUCH_RST",
+				     "NFC_IRQ (NFC_CTRL_1)",
+				     "HAL_SW",
+				     "TOUCH_RST2",
+				     "", "",
+				     "VAUDIO_HF_EN", /* GPIO149 */
+				     "", "", "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8000e180 {
+			/* GPIOs 160 - 191 */
+			gpio-line-names = "", "", "", "", "", "", "", "",
+				     "",
+				     "SDMMC_EN",
+				     "XENON_CHARGE (FLASH_CONTROL_5)",
+				     "GBF_ENA_RESET",
+				     "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
+		gpio at 8011e000 {
+			/* GPIOs 192 - 223 */
+			gpio-line-names = "HDTV_INTN",
+				     "", "", "",
+				     "HDTV_RSTN",
+				     "", "", "",
+				     "", /* GPIO200 */
+				     "", "", "", "", "", "", "",
+				     /* GPIO208-216 used for WGBF_MC1 */
+				     "", "", "", "", "", "", "", "", "",
+				     "SW_FRONT_PROXIMITY", /* GPIO217 */
+				     "KPD_CTRL_INT", /* Keypad controller */
+				     "", "", "", "", "";
+		};
+
+		gpio at 8011e080 {
+			/* GPIOs 224 - 255 */
+			gpio-line-names = "", "",
+				     "HSIT_ACWAKE0",
+				     "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "",
+				     "", "", "", "", "", "", "", "";
+		};
+
 		// External Micro SD slot
 		sdi0_per1 at 80126000 {
 			cd-gpios  = <&gpio2 31 GPIO_ACTIVE_HIGH>; // 95
-- 
2.4.11
