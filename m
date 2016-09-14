From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 11:45:28 +0200
Subject: [PATCH] pintctrl: amlogic: gxbb: add i2c pins
Message-ID: <1473846328-17339-1-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domains pins for the i2c devices A,B,C

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index b06cc12f2500..c3928aa3fefa 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -200,6 +200,15 @@ static const unsigned int uart_rx_c_pins[]	= { PIN(GPIOY_14, EE_OFF) };
 static const unsigned int uart_cts_c_pins[]	= { PIN(GPIOX_11, EE_OFF) };
 static const unsigned int uart_rts_c_pins[]	= { PIN(GPIOX_12, EE_OFF) };
 
+static const unsigned int i2c_sck_a_pins[]	= { PIN(GPIODV_25, EE_OFF) };
+static const unsigned int i2c_sda_a_pins[]	= { PIN(GPIODV_24, EE_OFF) };
+
+static const unsigned int i2c_sck_b_pins[]	= { PIN(GPIODV_27, EE_OFF) };
+static const unsigned int i2c_sda_b_pins[]	= { PIN(GPIODV_26, EE_OFF) };
+
+static const unsigned int i2c_sck_c_pins[]	= { PIN(GPIODV_29, EE_OFF) };
+static const unsigned int i2c_sda_c_pins[]	= { PIN(GPIODV_28, EE_OFF) };
+
 static const unsigned int eth_mdio_pins[]	= { PIN(GPIOZ_0, EE_OFF) };
 static const unsigned int eth_mdc_pins[]	= { PIN(GPIOZ_1, EE_OFF) };
 static const unsigned int eth_clk_rx_clk_pins[]	= { PIN(GPIOZ_2, EE_OFF) };
@@ -438,6 +447,12 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(uart_rts_b,	2,	26),
 	GROUP(pwm_b,		3,	21),
 	GROUP(pwm_d,		3,	20),
+	GROUP(i2c_sck_a,	7,	27),
+	GROUP(i2c_sda_a,	7,	26),
+	GROUP(i2c_sck_b,	7,	25),
+	GROUP(i2c_sda_b,	7,	24),
+	GROUP(i2c_sck_c,	7,	23),
+	GROUP(i2c_sda_c,	7,	22),
 
 	/* Bank BOOT */
 	GROUP(emmc_nand_d07,	4,	30),
@@ -574,6 +589,18 @@ static const char * const uart_c_groups[] = {
 	"uart_tx_c", "uart_rx_c", "uart_cts_c", "uart_rts_c",
 };
 
+static const char * const i2c_a_groups[] = {
+	"i2c_sck_a", "i2c_sda_a",
+};
+
+static const char * const i2c_b_groups[] = {
+	"i2c_sck_b", "i2c_sda_b",
+};
+
+static const char * const i2c_c_groups[] = {
+	"i2c_sck_c", "i2c_sda_c",
+};
+
 static const char * const eth_groups[] = {
 	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
 	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
@@ -661,6 +688,9 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(uart_a),
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
+	FUNCTION(i2c_a),
+	FUNCTION(i2c_b),
+	FUNCTION(i2c_c),
 	FUNCTION(eth),
 	FUNCTION(pwm_a_x),
 	FUNCTION(pwm_a_y),
-- 
2.7.4
