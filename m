From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Oct 2017 11:28:44 +0200
Subject: [PATCH v2] arm64: qcom: sbc: Name GPIO lines
Message-ID: <20171009092844.11451-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This names the GPIO lines on the APQ8016 "SBC" also known
as the DragonBoard 410c, according to the schematic. This
is necessary for a conforming userspace looking across
all GPIO chips for the GPIO lines named "GPIO-A" thru
"GPIO-L".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Put the GPIO line names into the .dtsi file for the
  SBC as requested.
- Put the GPIO line names into the hierarchical SoC
  DTS structure as requested.
- Adjusted legend text to only cover used terminology.
- Insert proper comments telling which line on the LSEC
  or HSEC a certain line is routed to.

I don't have this hardware available, you can test it
easily by compiling tools/gpio/* and issue "lsgpio" to
see the GPIO line names in the console.
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 169 ++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 1d63e6b879de..a67bb7f0e48e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -19,6 +19,30 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
 
+/*
+ * GPIO name legend: proper name = the GPIO line is used as GPIO
+ *         NC = not connected (pin out but not routed from the chip to
+ *              anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         LSEC = Low Speed External Connector
+ *         HSEC = High Speed External Connector
+ *
+ * Line names are taken from the schematic "DragonBoard410c"
+ * dated monday, august 31, 2015. Page 5 in particular.
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence, which means that the external UART on the
+ * LSEC is named UART0 while the schematic and SoC names this
+ * UART3. This is only for the informational lines i.e. "[FOO]",
+ * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+ * ones actually used for GPIO.
+ */
+
 / {
 	aliases {
 		serial0 = &blsp1_uart2;
@@ -47,6 +71,132 @@
 	};
 
 	soc {
+		pinctrl at 1000000 {
+			gpio-line-names =
+				"[UART0_TX]", /* GPIO_0, LSEC pin 5 */
+				"[UART0_RX]", /* GPIO_1, LSEC pin 7 */
+				"[UART0_CTS_N]", /* GPIO_2, LSEC pin 3 */
+				"[UART0_RTS_N]", /* GPIO_3, LSEC pin 9 */
+				"[UART1_TX]", /* GPIO_4, LSEC pin 11 */
+				"[UART1_RX]", /* GPIO_5, LSEC pin 13 */
+				"[I2C0_SDA]", /* GPIO_8, LSEC pin 17 */
+				"[I2C0_SCL]", /* GPIO_7, LSEC pin 15 */
+				"[SPI1_DOUT]", /* SPI1_MOSI, HSEC pin 1 */
+				"[SPI1_DIN]", /* SPI1_MISO, HSEC pin 11 */
+				"[SPI1_CS]", /* SPI1_CS_N, HSEC pin 7 */
+				"[SPI1_SCLK]", /* SPI1_CLK, HSEC pin 9 */
+				"GPIO-B", /* LS_EXP_GPIO_B, LSEC pin 24 */
+				"GPIO-C", /* LS_EXP_GPIO_C, LSEC pin 25 */
+				"[I2C3_SDA]", /* HSEC pin 38 */
+				"[I2C3_SCL]", /* HSEC pin 36 */
+				"[SPI0_MOSI]", /* LSEC pin 14 */
+				"[SPI0_MISO]", /* LSEC pin 10 */
+				"[SPI0_CS_N]", /* LSEC pin 12 */
+				"[SPI0_CLK]", /* LSEC pin 8 */
+				"HDMI_HPD_N", /* GPIO 20 */
+				"USR_LED_1_CTRL",
+				"[I2C1_SDA]", /* GPIO_22, LSEC pin 21 */
+				"[I2C1_SCL]", /* GPIO_23, LSEC pin 19 */
+				"GPIO-G", /* LS_EXP_GPIO_G, LSEC pin 29 */
+				"GPIO-H", /* LS_EXP_GPIO_H, LSEC pin 30 */
+				"[CSI0_MCLK]", /* HSEC pin 15 */
+				"[CSI1_MCLK]", /* HSEC pin 17 */
+				"GPIO-K", /* LS_EXP_GPIO_K, LSEC pin 33 */
+				"[I2C2_SDA]", /* HSEC pin 34 */
+				"[I2C2_SCL]", /* HSEC pin 32 */
+				"DSI2HDMI_INT_N",
+				"DSI_SW_SEL_APQ",
+				"GPIO-L", /* LS_EXP_GPIO_L, LSEC pin 34 */
+				"GPIO-J", /* LS_EXP_GPIO_J, LSEC pin 32 */
+				"GPIO-I", /* LS_EXP_GPIO_I, LSEC pin 31 */
+				"GPIO-A", /* LS_EXP_GPIO_A, LSEC pin 23 */
+				"FORCED_USB_BOOT",
+				"SD_CARD_DET_N",
+				"[WCSS_BT_SSBI]",
+				"[WCSS_WLAN_DATA_2]", /* GPIO 40 */
+				"[WCSS_WLAN_DATA_1]",
+				"[WCSS_WLAN_DATA_0]",
+				"[WCSS_WLAN_SET]",
+				"[WCSS_WLAN_CLK]",
+				"[WCSS_FM_SSBI]",
+				"[WCSS_FM_SDI]",
+				"[WCSS_BT_DAT_CTL]",
+				"[WCSS_BT_DAT_STB]",
+				"NC",
+				"NC", /* GPIO 50 */
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC", /* GPIO 60 */
+				"NC",
+				"NC",
+				"[CDC_PDM0_CLK]",
+				"[CDC_PDM0_SYNC]",
+				"[CDC_PDM0_TX0]",
+				"[CDC_PDM0_RX0]",
+				"[CDC_PDM0_RX1]",
+				"[CDC_PDM0_RX2]",
+				"GPIO-D", /* LS_EXP_GPIO_D, LSEC pin 26 */
+				"NC", /* GPIO 70 */
+				"NC",
+				"NC",
+				"NC",
+				"NC", /* GPIO 74 */
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"BOOT_CONFIG_0", /* GPIO 80 */
+				"BOOT_CONFIG_1",
+				"BOOT_CONFIG_2",
+				"BOOT_CONFIG_3",
+				"NC",
+				"NC",
+				"BOOT_CONFIG_5",
+				"NC",
+				"NC",
+				"NC",
+				"NC", /* GPIO 90 */
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC",
+				"NC", /* GPIO 100 */
+				"NC",
+				"NC",
+				"NC",
+				"SSBI_GPS",
+				"NC",
+				"NC",
+				"KEY_VOLP_N",
+				"NC",
+				"NC",
+				"[LS_EXP_MI2S_WS]", /* GPIO 110 */
+				"NC",
+				"NC",
+				"[LS_EXP_MI2S_SCK]",
+				"[LS_EXP_MI2S_DATA0]",
+				"GPIO-E", /* LS_EXP_GPIO_E, LSEC pin 27 */
+				"NC",
+				"[DSI2HDMI_MI2S_WS]",
+				"[DSI2HDMI_MI2S_SCK]",
+				"[DSI2HDMI_MI2S_DATA0]",
+				"USR_LED_2_CTRL", /* GPIO 120 */
+				"SB_HS_ID";
+		};
+
 		dma at 7884000 {
 			status = "okay";
 		};
@@ -329,6 +479,25 @@
                         };
                 };
 
+		spmi at 200f000 {
+			pm8916 at 0 {
+				gpios at c000 {
+					gpio-line-names =
+						"USR_LED_3_CTRL",
+						"USR_LED_4_CTRL",
+						"USB_HUB_RESET_N_PM",
+						"USB_SW_SEL_PM";
+				};
+				mpps at a000 {
+					gpio-line-names =
+						"VDD_PX_BIAS",
+						"WLAN_LED_CTRL",
+						"BT_LED_CTRL",
+						"GPIO-F"; /* LS_EXP_GPIO_F, LSEC pin 28 */
+				};
+			};
+		};
+
 		wcnss at a21b000 {
 			status = "okay";
 		};
-- 
2.13.5
