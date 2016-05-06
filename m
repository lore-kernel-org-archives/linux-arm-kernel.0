From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:23 -0700
Subject: [PATCH 4/7] pinctrl amlogic: gxbb: add ethernet pins
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-5-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domain pins for ethernet interface.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 67b5af70e9e9..360535a30625 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -178,6 +178,21 @@ static const unsigned int uart_rx_c_pins[]	= { PIN(GPIOY_14, EE_OFF) };
 static const unsigned int uart_cts_c_pins[]	= { PIN(GPIOX_11, EE_OFF) };
 static const unsigned int uart_rts_c_pins[]	= { PIN(GPIOX_12, EE_OFF) };
 
+static const unsigned int eth_mdio_pins[]	= { PIN(GPIOZ_0, EE_OFF) };
+static const unsigned int eth_mdc_pins[]	= { PIN(GPIOZ_1, EE_OFF) };
+static const unsigned int eth_clk_rx_clk_pins[]	= { PIN(GPIOZ_2, EE_OFF) };
+static const unsigned int eth_rx_dv_pins[]	= { PIN(GPIOZ_3, EE_OFF) };
+static const unsigned int eth_rxd0_pins[]	= { PIN(GPIOZ_4, EE_OFF) };
+static const unsigned int eth_rxd1_pins[]	= { PIN(GPIOZ_5, EE_OFF) };
+static const unsigned int eth_rxd2_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
+static const unsigned int eth_rxd3_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
+static const unsigned int eth_rgmii_tx_clk_pins[] = { PIN(GPIOZ_8, EE_OFF) };
+static const unsigned int eth_tx_en_pins[]	= { PIN(GPIOZ_9, EE_OFF) };
+static const unsigned int eth_txd0_pins[]	= { PIN(GPIOZ_10, EE_OFF) };
+static const unsigned int eth_txd1_pins[]	= { PIN(GPIOZ_11, EE_OFF) };
+static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
+static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -351,6 +366,22 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(uart_tx_c,	1,	17),
 	GROUP(uart_rx_c,	1,	16),
 
+	/* Bank Z */
+	GROUP(eth_mdio,		6,	1),
+	GROUP(eth_mdc,		6,	0),
+	GROUP(eth_clk_rx_clk,	6,	13),
+	GROUP(eth_rx_dv,	6,	12),
+	GROUP(eth_rxd0,		6,	11),
+	GROUP(eth_rxd1,		6,	10),
+	GROUP(eth_rxd2,		6,	9),
+	GROUP(eth_rxd3,		6,	8),
+	GROUP(eth_rgmii_tx_clk,	6,	7),
+	GROUP(eth_tx_en,	6,	6),
+	GROUP(eth_txd0,		6,	5),
+	GROUP(eth_txd1,		6,	4),
+	GROUP(eth_txd2,		6,	3),
+	GROUP(eth_txd3,		6,	2),
+
 	/* Bank DV */
 	GROUP(uart_tx_b,	2,	29),
 	GROUP(uart_rx_b,	2,	28),
@@ -461,6 +492,13 @@ static const char * const uart_c_groups[] = {
 	"uart_tx_c", "uart_rx_c", "uart_cts_c", "uart_rts_c",
 };
 
+static const char * const eth_groups[] = {
+	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
+	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
+	"eth_rgmii_tx_clk", "eth_tx_en",
+	"eth_txd0", "eth_txd1", "eth_txd2", "eth_txd3",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -490,6 +528,7 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(uart_a),
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
+	FUNCTION(eth),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
-- 
2.7.4
