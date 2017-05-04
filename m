From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu,  4 May 2017 20:49:29 +0200
Subject: [PATCH 1/4] pinctrl: meson: meson8b: add the PWM pins
In-Reply-To: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170504184932.5372-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing pins for the PWM controllers found in Amlogic
Meson8 SoCs. This includes the pins for PWM_A, PWM_B, PWM_C, PWM_D,
PWM_E and PWM_F controllers.
There is an additional PWM function with the name PWM_VS in the vendor
kernel sources which seems to be used for external video input. Thus
it's not part of this change as the IP block behind the pwm-meson driver
is not responsible for these pins.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 62 ++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 07f1cb21c1b8..9d9ddd9c0f83 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -205,6 +205,9 @@ static const unsigned int i2c_sck_d0_pins[] = { PIN(GPIOX_17, 0) };
 static const unsigned int xtal_32k_out_pins[] = { PIN(GPIOX_10, 0) };
 static const unsigned int xtal_24m_out_pins[] = { PIN(GPIOX_11, 0) };
 
+static const unsigned int pwm_e_pins[] = { PIN(GPIOX_10, 0) };
+static const unsigned int pwm_b_x_pins[] = { PIN(GPIOX_11, 0) };
+
 /* bank Y */
 static const unsigned int uart_tx_c_pins[] = { PIN(GPIOY_0, 0) };
 static const unsigned int uart_rx_c_pins[] = { PIN(GPIOY_1, 0) };
@@ -219,6 +222,8 @@ static const unsigned int pcm_clk_b_pins[] = { PIN(GPIOY_7, 0) };
 static const unsigned int i2c_sda_c0_pins[] = { PIN(GPIOY_0, 0) };
 static const unsigned int i2c_sck_c0_pins[] = { PIN(GPIOY_1, 0) };
 
+static const unsigned int pwm_a_y_pins[] = { PIN(GPIOY_16, 0) };
+
 /* bank DV */
 static const unsigned int dvin_rgb_pins[] = { PIN(GPIODV_0, 0), PIN(GPIODV_1, 0),
 					      PIN(GPIODV_2, 0), PIN(GPIODV_3, 0),
@@ -264,6 +269,10 @@ static const unsigned int uart_rts_b1_pins[] = { PIN(GPIODV_27, 0) };
 static const unsigned int vga_vs_pins[] = { PIN(GPIODV_24, 0) };
 static const unsigned int vga_hs_pins[] = { PIN(GPIODV_25, 0) };
 
+static const unsigned int pwm_c_dv9_pins[] = { PIN(GPIODV_9, 0) };
+static const unsigned int pwm_c_dv29_pins[] = { PIN(GPIODV_29, 0) };
+static const unsigned int pwm_d_pins[] = { PIN(GPIODV_28, 0) };
+
 /* bank H */
 static const unsigned int hdmi_hpd_pins[] = { PIN(GPIOH_0, 0) };
 static const unsigned int hdmi_sda_pins[] = { PIN(GPIOH_1, 0) };
@@ -312,6 +321,11 @@ static const unsigned int i2c_sck_a1_pins[] = { PIN(GPIOZ_1, 0) };
 static const unsigned int i2c_sda_a2_pins[] = { PIN(GPIOZ_0, 0) };
 static const unsigned int i2c_sck_a2_pins[] = { PIN(GPIOZ_1, 0) };
 
+static const unsigned int pwm_a_z0_pins[] = { PIN(GPIOZ_0, 0) };
+static const unsigned int pwm_a_z7_pins[] = { PIN(GPIOZ_7, 0) };
+static const unsigned int pwm_b_z_pins[] = { PIN(GPIOZ_1, 0) };
+static const unsigned int pwm_c_z_pins[] = { PIN(GPIOZ_8, 0) };
+
 /* bank BOOT */
 static const unsigned int sd_d0_c_pins[] = { PIN(BOOT_0, 0) };
 static const unsigned int sd_d1_c_pins[] = { PIN(BOOT_1, 0) };
@@ -382,6 +396,8 @@ static const unsigned int uart_rx_ao_b1_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 static const unsigned int i2c_mst_sck_ao_pins[] = { PIN(GPIOAO_4, AO_OFF) };
 static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
+static const unsigned int pwm_f_ao_pins[] = { PIN(GPIO_TEST_N, AO_OFF) };
+
 static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOX_0, 0),
 	GPIO_GROUP(GPIOX_1, 0),
@@ -523,6 +539,9 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GROUP(xtal_32k_out,	3,	22),
 	GROUP(xtal_24m_out,	3,	23),
 
+	GROUP(pwm_e,		9,	19),
+	GROUP(pwm_b_x,		2,	3),
+
 	/* bank Y */
 	GROUP(uart_tx_c,	1,	19),
 	GROUP(uart_rx_c,	1,	18),
@@ -537,6 +556,8 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GROUP(i2c_sda_c0,	1,	15),
 	GROUP(i2c_sck_c0,	1,	14),
 
+	GROUP(pwm_a_y,		9,	14),
+
 	/* bank DV */
 	GROUP(dvin_rgb,		0,	6),
 	GROUP(dvin_vs,		0,	9),
@@ -571,6 +592,10 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GROUP(vga_vs,		0,	21),
 	GROUP(vga_hs,		0,	20),
 
+	GROUP(pwm_c_dv9,	3,	24),
+	GROUP(pwm_c_dv29,	3,	25),
+	GROUP(pwm_d,		3,	26),
+
 	/* bank H */
 	GROUP(hdmi_hpd,		1,	26),
 	GROUP(hdmi_sda,		1,	25),
@@ -619,6 +644,11 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GROUP(i2c_sda_a2,	5,	7),
 	GROUP(i2c_sck_a2,	5,	6),
 
+	GROUP(pwm_a_z0,		9,	16),
+	GROUP(pwm_a_z7,		2,	0),
+	GROUP(pwm_b_z,		9,	15),
+	GROUP(pwm_c_z,		2,	1),
+
 	/* bank BOOT */
 	GROUP(sd_d0_c,		6,	29),
 	GROUP(sd_d1_c,		6,	28),
@@ -701,6 +731,8 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 
 	GROUP(i2c_mst_sck_ao,		0,	6),
 	GROUP(i2c_mst_sda_ao,		0,	5),
+
+	GROUP(pwm_f_ao,			0,	19),
 };
 
 static const char * const gpio_groups[] = {
@@ -849,6 +881,26 @@ static const char * const nor_groups[] = {
 	"nor_d", "nor_q", "nor_c", "nor_cs"
 };
 
+static const char * const pwm_a_groups[] = {
+	"pwm_a_y", "pwm_a_z0", "pwm_a_z7"
+};
+
+static const char * const pwm_b_groups[] = {
+	"pwm_b_x", "pwm_b_z"
+};
+
+static const char * const pwm_c_groups[] = {
+	"pwm_c_dv9", "pwm_c_dv29", "pwm_c_z"
+};
+
+static const char * const pwm_d_groups[] = {
+	"pwm_d"
+};
+
+static const char * const pwm_e_groups[] = {
+	"pwm_e"
+};
+
 static const char * const sd_b_groups[] = {
 	"sd_d1_b", "sd_d0_b", "sd_clk_b", "sd_cmd_b",
 	"sd_d3_b", "sd_d2_b"
@@ -878,6 +930,10 @@ static const char * const i2c_mst_ao_groups[] = {
 	"i2c_mst_sck_ao", "i2c_mst_sda_ao"
 };
 
+static const char * const pwm_f_ao_groups[] = {
+	"pwm_f"
+};
+
 static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(sd_a),
@@ -905,6 +961,11 @@ static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(nor),
 	FUNCTION(sd_b),
 	FUNCTION(sdxc_b),
+	FUNCTION(pwm_a),
+	FUNCTION(pwm_b),
+	FUNCTION(pwm_c),
+	FUNCTION(pwm_d),
+	FUNCTION(pwm_e),
 };
 
 static struct meson_pmx_func meson8_aobus_functions[] = {
@@ -913,6 +974,7 @@ static struct meson_pmx_func meson8_aobus_functions[] = {
 	FUNCTION(i2c_slave_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_mst_ao),
+	FUNCTION(pwm_f_ao),
 };
 
 static struct meson_bank meson8_cbus_banks[] = {
-- 
2.12.2
