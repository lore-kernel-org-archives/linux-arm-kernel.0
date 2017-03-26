From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 26 Mar 2017 19:19:17 +0200
Subject: [PATCH v2 2/8] pinctrl: meson: gxbb: add spdif output pins
In-Reply-To: <20170326171923.19269-1-jbrunet@baylibre.com>
References: <20170326171923.19269-1-jbrunet@baylibre.com>
Message-ID: <20170326171923.19269-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE and AO domains pins for the spdif output.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index b9772a124a82..9b00be15d258 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -240,6 +240,8 @@ static const unsigned int i2s_out_ch23_y_pins[]	= { PIN(GPIOY_8, EE_OFF) };
 static const unsigned int i2s_out_ch45_y_pins[]	= { PIN(GPIOY_9, EE_OFF) };
 static const unsigned int i2s_out_ch67_y_pins[]	= { PIN(GPIOY_10, EE_OFF) };
 
+static const unsigned int spdif_out_y_pins[]	= { PIN(GPIOY_12, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -285,6 +287,9 @@ static const unsigned int i2s_out_ch01_ao_pins[] = { PIN(GPIOAO_11, 0) };
 static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_12, 0) };
 static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_13, 0) };
 
+static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, 0) };
+static const unsigned int spdif_out_ao_13_pins[] = { PIN(GPIOAO_13, 0) };
+
 static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -440,6 +445,7 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(i2s_out_ch23_y,	1,	5),
 	GROUP(i2s_out_ch45_y,	1,	6),
 	GROUP(i2s_out_ch67_y,	1,	7),
+	GROUP(spdif_out_y,	1,	9),
 
 	/* Bank Z */
 	GROUP(eth_mdio,		6,	1),
@@ -543,6 +549,8 @@ static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
 	GROUP(i2s_out_ch01_ao,	0,	27),
 	GROUP(i2s_out_ch23_ao,	1,	0),
 	GROUP(i2s_out_ch45_ao,	1,	1),
+	GROUP(spdif_out_ao_6,	0,	16),
+	GROUP(spdif_out_ao_13,	0,	4),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -676,6 +684,10 @@ static const char * const i2s_out_groups[] = {
 	"i2s_out_ch23_y", "i2s_out_ch45_y", "i2s_out_ch67_y",
 };
 
+static const char * const spdif_out_groups[] = {
+	"spdif_out_y",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -723,6 +735,10 @@ static const char * const i2s_out_ao_groups[] = {
 	"i2s_out_ch01_ao", "i2s_out_ch23_ao", "i2s_out_ch45_ao",
 };
 
+static const char * const spdif_out_ao_groups[] = {
+	"spdif_out_ao_6", "spdif_out_ao_13",
+};
+
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -747,6 +763,7 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(hdmi_hpd),
 	FUNCTION(hdmi_i2c),
 	FUNCTION(i2s_out),
+	FUNCTION(spdif_out),
 };
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
@@ -761,6 +778,7 @@ static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
 	FUNCTION(pwm_ao_a_12),
 	FUNCTION(pwm_ao_b),
 	FUNCTION(i2s_out_ao),
+	FUNCTION(spdif_out_ao),
 };
 
 static struct meson_bank meson_gxbb_periphs_banks[] = {
-- 
2.9.3
