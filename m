From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 23 Mar 2017 17:50:56 +0100
Subject: [PATCH 3/8] pinctrl: meson: gxl: add i2s output pins
In-Reply-To: <20170323165101.29262-1-jbrunet@baylibre.com>
References: <20170323165101.29262-1-jbrunet@baylibre.com>
Message-ID: <20170323165101.29262-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index a0a7936f8f0d..a022a9e49113 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -212,6 +212,14 @@ static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0, EE_OFF) };
 static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1, EE_OFF) };
 static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2, EE_OFF) };
 
+static const unsigned int i2s_am_clk_pins[]	= { PIN(GPIOH_6, EE_OFF) };
+static const unsigned int i2s_out_ao_clk_pins[]	= { PIN(GPIOH_7, EE_OFF) };
+static const unsigned int i2s_out_lr_clk_pins[]	= { PIN(GPIOH_8, EE_OFF) };
+static const unsigned int i2s_out_ch01_pins[]	= { PIN(GPIOH_9, EE_OFF) };
+static const unsigned int i2s_out_ch23_z_pins[]	= { PIN(GPIOZ_5, EE_OFF) };
+static const unsigned int i2s_out_ch45_z_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
+static const unsigned int i2s_out_ch67_z_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxl_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -241,6 +249,9 @@ static const unsigned int pwm_ao_a_8_pins[]	= { PIN(GPIOAO_8, 0) };
 
 static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
 
+static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, EE_OFF) };
+static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, EE_OFF) };
+
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -384,11 +395,18 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GROUP(eth_txd2,		4,	11),
 	GROUP(eth_txd3,		4,	10),
 	GROUP(pwm_c,		3,	20),
+	GROUP(i2s_out_ch23_z,	3,	26),
+	GROUP(i2s_out_ch45_z,	3,	25),
+	GROUP(i2s_out_ch67_z,	3,	24),
 
 	/* Bank H */
 	GROUP(hdmi_hpd,		6,	31),
 	GROUP(hdmi_sda,		6,	30),
 	GROUP(hdmi_scl,		6,	29),
+	GROUP(i2s_am_clk,	6,	26),
+	GROUP(i2s_out_ao_clk,	6,	25),
+	GROUP(i2s_out_lr_clk,	6,	24),
+	GROUP(i2s_out_ch01,	6,	23),
 
 	/* Bank DV */
 	GROUP(uart_tx_b,	2,	16),
@@ -453,6 +471,8 @@ static struct meson_pmx_group meson_gxl_aobus_groups[] = {
 	GROUP(pwm_ao_a_3,	0,	22),
 	GROUP(pwm_ao_a_8,	0,	17),
 	GROUP(pwm_ao_b,		0,	3),
+	GROUP(i2s_out_ch23_ao,	1,	0),
+	GROUP(i2s_out_ch45_ao,	1,	1),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -569,6 +589,11 @@ static const char * const hdmi_i2c_groups[] = {
 	"hdmi_sda", "hdmi_scl",
 };
 
+static const char * const i2s_out_groups[] = {
+	"i2s_am_clk", "i2s_out_ao_clk", "i2s_out_lr_clk",
+	"i2s_out_ch01", "i2s_out_ch23_z", "i2s_out_ch45_z", "i2s_out_ch67_z",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -594,6 +619,10 @@ static const char * const pwm_ao_b_groups[] = {
 	"pwm_ao_b",
 };
 
+static const char * const i2s_out_ao_groups[] = {
+	"i2s_out_ch23_ao", "i2s_out_ch45_ao",
+};
+
 static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -615,6 +644,7 @@ static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(pwm_f),
 	FUNCTION(hdmi_hpd),
 	FUNCTION(hdmi_i2c),
+	FUNCTION(i2s_out),
 };
 
 static struct meson_pmx_func meson_gxl_aobus_functions[] = {
@@ -624,6 +654,7 @@ static struct meson_pmx_func meson_gxl_aobus_functions[] = {
 	FUNCTION(remote_input_ao),
 	FUNCTION(pwm_ao_a),
 	FUNCTION(pwm_ao_b),
+	FUNCTION(i2s_out_ao),
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-- 
2.9.3
