From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:25:07 +0200
Subject: [PATCH v2 1/2] pinctrl: meson-gxbb: add pins for PWM
In-Reply-To: <1471951508-29620-1-git-send-email-narmstrong@baylibre.com>
References: <1471951508-29620-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471951508-29620-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for PWM pins, for EE and AO domains.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 79 ++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 7eeb053..9ba9172 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -193,6 +193,14 @@ static const unsigned int eth_txd1_pins[]	= { PIN(GPIOZ_11, EE_OFF) };
 static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12, EE_OFF) };
 static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13, EE_OFF) };
 
+static const unsigned int pwm_a_x_pins[]	= { PIN(GPIOX_6, EE_OFF) };
+static const unsigned int pwm_a_y_pins[]	= { PIN(GPIOY_16, EE_OFF) };
+static const unsigned int pwm_b_pins[]		= { PIN(GPIODV_29, EE_OFF) };
+static const unsigned int pwm_d_pins[]		= { PIN(GPIODV_28, EE_OFF) };
+static const unsigned int pwm_e_pins[]		= { PIN(GPIOX_19, EE_OFF) };
+static const unsigned int pwm_f_x_pins[]	= { PIN(GPIOX_7, EE_OFF) };
+static const unsigned int pwm_f_y_pins[]	= { PIN(GPIOY_15, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -227,6 +235,11 @@ static const unsigned int i2c_slave_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
 
 static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
 
+static const unsigned int pwm_ao_a_3_pins[]	= { PIN(GPIOAO_3, 0) };
+static const unsigned int pwm_ao_a_6_pins[]	= { PIN(GPIOAO_6, 0) };
+static const unsigned int pwm_ao_a_12_pins[]	= { PIN(GPIOAO_12, 0) };
+static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_13, 0) };
+
 static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -361,12 +374,17 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(uart_rx_a,	4,	12),
 	GROUP(uart_cts_a,	4,	11),
 	GROUP(uart_rts_a,	4,	10),
+	GROUP(pwm_a_x,		3,	17),
+	GROUP(pwm_e,		2,	30),
+	GROUP(pwm_f_x,		3,	18),
 
 	/* Bank Y */
 	GROUP(uart_cts_c,	1,	19),
 	GROUP(uart_rts_c,	1,	18),
 	GROUP(uart_tx_c,	1,	17),
 	GROUP(uart_rx_c,	1,	16),
+	GROUP(pwm_a_y,		1,	21),
+	GROUP(pwm_f_y,		1,	20),
 
 	/* Bank Z */
 	GROUP(eth_mdio,		6,	1),
@@ -389,6 +407,8 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(uart_rx_b,	2,	28),
 	GROUP(uart_cts_b,	2,	27),
 	GROUP(uart_rts_b,	2,	26),
+	GROUP(pwm_b,		3,	21),
+	GROUP(pwm_d,		3,	20),
 
 	/* Bank BOOT */
 	GROUP(emmc_nand_d07,	4,	30),
@@ -435,6 +455,10 @@ static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
 	GROUP(i2c_slave_sck_ao, 0,	2),
 	GROUP(i2c_slave_sda_ao, 0,	1),
 	GROUP(remote_input_ao,	0,	0),
+	GROUP(pwm_ao_a_3,	0,	22),
+	GROUP(pwm_ao_a_6,	0,	18),
+	GROUP(pwm_ao_a_12,	0,	17),
+	GROUP(pwm_ao_b,		0,	3),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -502,6 +526,34 @@ static const char * const eth_groups[] = {
 	"eth_txd0", "eth_txd1", "eth_txd2", "eth_txd3",
 };
 
+static const char * const pwm_a_x_groups[] = {
+	"pwm_a_x",
+};
+
+static const char * const pwm_a_y_groups[] = {
+	"pwm_a_y",
+};
+
+static const char * const pwm_b_groups[] = {
+	"pwm_b",
+};
+
+static const char * const pwm_d_groups[] = {
+	"pwm_d",
+};
+
+static const char * const pwm_e_groups[] = {
+	"pwm_e",
+};
+
+static const char * const pwm_f_x_groups[] = {
+	"pwm_f_x",
+};
+
+static const char * const pwm_f_y_groups[] = {
+	"pwm_f_y",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -528,6 +580,22 @@ static const char * const remote_input_ao_groups[] = {
 	"remote_input_ao",
 };
 
+static const char * const pwm_ao_a_3_groups[] = {
+	"pwm_ao_a_3",
+};
+
+static const char * const pwm_ao_a_6_groups[] = {
+	"pwm_ao_a_6",
+};
+
+static const char * const pwm_ao_a_12_groups[] = {
+	"pwm_ao_a_12",
+};
+
+static const char * const pwm_ao_b_groups[] = {
+	"pwm_ao_b",
+};
+
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -536,6 +604,13 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
 	FUNCTION(eth),
+	FUNCTION(pwm_a_x),
+	FUNCTION(pwm_a_y),
+	FUNCTION(pwm_b),
+	FUNCTION(pwm_d),
+	FUNCTION(pwm_e),
+	FUNCTION(pwm_f_x),
+	FUNCTION(pwm_f_y),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
@@ -545,6 +620,10 @@ static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
 	FUNCTION(i2c_ao),
 	FUNCTION(i2c_slave_ao),
 	FUNCTION(remote_input_ao),
+	FUNCTION(pwm_ao_a_3),
+	FUNCTION(pwm_ao_a_6),
+	FUNCTION(pwm_ao_a_12),
+	FUNCTION(pwm_ao_b),
 };
 
 static struct meson_bank meson_gxbb_periphs_banks[] = {
-- 
1.9.1
