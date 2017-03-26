From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:19 +0200
Subject: [PATCH v2 4/8] pinctrl: meson: gxl: add spdif output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the spdif output.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index e472213fd673..998210eacf37 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -232,6 +232,8 @@ static const unsigned int i2s_out_ch23_z_pins[]	= { PIN(GPIOZ_5, EE_OFF) };
 static const unsigned int i2s_out_ch45_z_pins[]	= { PIN(GPIOZ_6, EE_OFF) };
 static const unsigned int i2s_out_ch67_z_pins[]	= { PIN(GPIOZ_7, EE_OFF) };
 
+static const unsigned int spdif_out_h_pins[]	= { PIN(GPIOH_4, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxl_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -272,6 +274,9 @@ static const unsigned int pwm_ao_b_6_pins[]	= { PIN(GPIOAO_6, 0) };
 static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, EE_OFF) };
 static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, EE_OFF) };
 
+static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, EE_OFF) };
+static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, EE_OFF) };
+
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -429,6 +434,7 @@ static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GROUP(i2s_out_ao_clk,	6,	25),
 	GROUP(i2s_out_lr_clk,	6,	24),
 	GROUP(i2s_out_ch01,	6,	23),
+	GROUP(spdif_out_h,	6,	28),
 
 	/* Bank DV */
 	GROUP(uart_tx_b,	2,	16),
@@ -510,6 +516,8 @@ static struct meson_pmx_group meson_gxl_aobus_groups[] = {
 	GROUP(pwm_ao_b,		0,	3),
 	GROUP(i2s_out_ch23_ao,	1,	0),
 	GROUP(i2s_out_ch45_ao,	1,	1),
+	GROUP(spdif_out_ao_6,	0,	16),
+	GROUP(spdif_out_ao_9,	0,	4),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -635,6 +643,10 @@ static const char * const i2s_out_groups[] = {
 	"i2s_out_ch01", "i2s_out_ch23_z", "i2s_out_ch45_z", "i2s_out_ch67_z",
 };
 
+static const char * const spdif_out_groups[] = {
+	"spdif_out_h",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -673,6 +685,10 @@ static const char * const i2s_out_ao_groups[] = {
 	"i2s_out_ch23_ao", "i2s_out_ch45_ao",
 };
 
+static const char * const spdif_out_ao_groups[] = {
+	"spdif_out_ao_6", "spdif_out_ao_9",
+};
+
 static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -696,6 +712,7 @@ static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(hdmi_hpd),
 	FUNCTION(hdmi_i2c),
 	FUNCTION(i2s_out),
+	FUNCTION(spdif_out),
 };
 
 static struct meson_pmx_func meson_gxl_aobus_functions[] = {
@@ -708,6 +725,7 @@ static struct meson_pmx_func meson_gxl_aobus_functions[] = {
 	FUNCTION(pwm_ao_a),
 	FUNCTION(pwm_ao_b),
 	FUNCTION(i2s_out_ao),
+	FUNCTION(spdif_out_ao),
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-- 
2.9.3
