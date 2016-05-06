From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:22 -0700
Subject: [PATCH 3/7] pinctrl: amlogic: gxbb: add more UART pins
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-4-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domain pins for UART A, B & C.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 5dc98ee35265..67b5af70e9e9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -163,6 +163,21 @@ static const unsigned int sdcard_d3_pins[] = { PIN(CARD_4, EE_OFF) };
 static const unsigned int sdcard_cmd_pins[] = { PIN(CARD_3, EE_OFF) };
 static const unsigned int sdcard_clk_pins[] = { PIN(CARD_2, EE_OFF) };
 
+static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_12, EE_OFF) };
+static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_13, EE_OFF) };
+static const unsigned int uart_cts_a_pins[]	= { PIN(GPIOX_14, EE_OFF) };
+static const unsigned int uart_rts_a_pins[]	= { PIN(GPIOX_15, EE_OFF) };
+
+static const unsigned int uart_tx_b_pins[]	= { PIN(GPIODV_24, EE_OFF) };
+static const unsigned int uart_rx_b_pins[]	= { PIN(GPIODV_25, EE_OFF) };
+static const unsigned int uart_cts_b_pins[]	= { PIN(GPIODV_26, EE_OFF) };
+static const unsigned int uart_rts_b_pins[]	= { PIN(GPIODV_27, EE_OFF) };
+
+static const unsigned int uart_tx_c_pins[]	= { PIN(GPIOY_13, EE_OFF) };
+static const unsigned int uart_rx_c_pins[]	= { PIN(GPIOY_14, EE_OFF) };
+static const unsigned int uart_cts_c_pins[]	= { PIN(GPIOX_11, EE_OFF) };
+static const unsigned int uart_rts_c_pins[]	= { PIN(GPIOX_12, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -324,6 +339,24 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 
 	GPIO_GROUP(GPIO_TEST_N, EE_OFF),
 
+	/* Bank X */
+	GROUP(uart_tx_a,	4,	13),
+	GROUP(uart_rx_a,	4,	12),
+	GROUP(uart_cts_a,	4,	11),
+	GROUP(uart_rts_a,	4,	10),
+
+	/* Bank Y */
+	GROUP(uart_cts_c,	1,	19),
+	GROUP(uart_rts_c,	1,	18),
+	GROUP(uart_tx_c,	1,	17),
+	GROUP(uart_rx_c,	1,	16),
+
+	/* Bank DV */
+	GROUP(uart_tx_b,	2,	29),
+	GROUP(uart_rx_b,	2,	28),
+	GROUP(uart_cts_b,	2,	27),
+	GROUP(uart_rts_b,	2,	26),
+
 	/* Bank BOOT */
 	GROUP(emmc_nand_d07,	4,	30),
 	GROUP(emmc_clk,		4,	18),
@@ -416,6 +449,18 @@ static const char * const sdcard_groups[] = {
 	"sdcard_cmd", "sdcard_clk",
 };
 
+static const char * const uart_a_groups[] = {
+	"uart_tx_a", "uart_rx_a", "uart_cts_a", "uart_rts_a",
+};
+
+static const char * const uart_b_groups[] = {
+	"uart_tx_b", "uart_rx_b", "uart_cts_b", "uart_rts_b",
+};
+
+static const char * const uart_c_groups[] = {
+	"uart_tx_c", "uart_rx_c", "uart_cts_c", "uart_rts_c",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -442,6 +487,9 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
 	FUNCTION(sdcard),
+	FUNCTION(uart_a),
+	FUNCTION(uart_b),
+	FUNCTION(uart_c),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
-- 
2.7.4
