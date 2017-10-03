From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Oct 2017 11:11:54 +0200
Subject: [PATCH 1/2] arm64: qcom: sbc: Name GPIO lines
Message-ID: <20171003091155.7138-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This names the GPIO lines on the APQ8016 "SBC" also known
as the DragonBoard 410c, according to the schematic. This
is necessary for a conforming userspace looking across
all GPIO chips for the GPIO lines named "GPIO-A" thru
"GPIO-L".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I don't have this hardware available, you can test it
easily by compiling tools/gpio/* and issue "lsgpio" to
see the GPIO line names in the console.

Please apply this even if you're not applying the second
patch renaming the DTS files.
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 167 +++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 825f489a2af7..40b0d62861bb 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -19,3 +19,170 @@
 	model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
 	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
 };
+
+/*
+ * Legend: proper name = the GPIO line is used as GPIO
+ *         NC = not connected (pin out but not routed from the chip to
+ *              anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         "" = no idea, schematic doesn't say, could be
+ *              unrouted (not connected to any external pin)
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
+&msmgpio {
+	gpio-line-names =
+		"[UART0_TX]", /* GPIO 0, LSEC pin 1 */
+		"[UART0_RX]",
+		"[UART0_CTS_N]",
+		"[UART0_RTS_N]",
+		"[UART1_TX]",
+		"[UART1_RX]",
+		"[I2C0_SDA]",
+		"[I2C0_SCL]",
+		"[SPI1_MOSI]",
+		"[SPI1_MISO]",
+		"[SPI1_CS_N]", /* GPIO 10 */
+		"[SPI1_CLK]",
+		"GPIO-B",
+		"GPIO-C",
+		"[I2C3_SDA]",
+		"[I2C3_SCL]",
+		"[SPI0_MOSI]",
+		"[SPI0_MISO]",
+		"[SPI0_CS_N]",
+		"[SPI0_CLK]",
+		"HDMI_HPD_N", /* GPIO 20 */
+		"USR_LED_1_CTRL",
+		"[I2C1_SDA]",
+		"[I2C1_SCL]",
+		"GPIO-G",
+		"GPIO-H",
+		"[CSI0_MCLK]",
+		"[CSI1_MCLK]",
+		"GPIO-K",
+		"[I2C2_SDA]",
+		"[I2C2_SCL]", /* GPIO 30 */
+		"DSI2HDMI_INT_N",
+		"DSI_SW_SEL_APQ",
+		"GPIO-L",
+		"GPIO-J",
+		"GPIO-I",
+		"GPIO-A", /* GPIO_36 */
+		"FORCED_USB_BOOT",
+		"SD_CARD_DET_N",
+		"[WCSS_BT_SSBI]",
+		"[WCSS_WLAN_DATA_2]", /* GPIO 40 */
+		"[WCSS_WLAN_DATA_1]",
+		"[WCSS_WLAN_DATA_0]",
+		"[WCSS_WLAN_SET]",
+		"[WCSS_WLAN_CLK]",
+		"[WCSS_FM_SSBI]",
+		"[WCSS_FM_SDI]",
+		"[WCSS_BT_DAT_CTL]",
+		"[WCSS_BT_DAT_STB]",
+		"NC",
+		"NC", /* GPIO 50 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 60 */
+		"NC",
+		"NC",
+		"[CDC_PDM0_CLK]",
+		"[CDC_PDM0_SYNC]",
+		"[CDC_PDM0_TX0]",
+		"[CDC_PDM0_RX0]",
+		"[CDC_PDM0_RX1]",
+		"[CDC_PDM0_RX2]",
+		"GPIO-D",
+		"NC", /* GPIO 70 */
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 74 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"BOOT_CONFIG_0", /* GPIO 80 */
+		"BOOT_CONFIG_1",
+		"BOOT_CONFIG_2",
+		"BOOT_CONFIG_3",
+		"NC",
+		"NC",
+		"BOOT_CONFIG_5",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 90 */
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC", /* GPIO 100 */
+		"NC",
+		"NC",
+		"NC",
+		"SSBI_GPS",
+		"NC",
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"NC",
+		"[LS_EXP_MI2S_WS]", /* GPIO 110 */
+		"NC",
+		"NC",
+		"[LS_EXP_MI2S_SCK]",
+		"[LS_EXP_MI2S_DATA0]",
+		"GPIO-E",
+		"NC",
+		"[DSI2HDMI_MI2S_WS]",
+		"[DSI2HDMI_MI2S_SCK]",
+		"[DSI2HDMI_MI2S_DATA0]",
+		"USR_LED_2_CTRL", /* GPIO 120 */
+		"USB_HS_ID";
+};
+
+&pm8916_gpios {
+	gpio-line-names =
+		"USR_LED_3_CTRL",
+		"USR_LED_4_CTRL",
+		"USB_HUB_RESET_N_PM",
+		"USB_SW_SEL_PM";
+};
+
+&pm8916_mpps {
+	gpio-line-names =
+		"VDD_PX_BIAS",
+		"WLAN_LED_CTRL",
+		"BT_LED_CTRL",
+		"GPIO-F";
+};
-- 
2.13.5
