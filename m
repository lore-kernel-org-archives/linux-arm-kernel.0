From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu,  4 May 2017 20:49:32 +0200
Subject: [PATCH 4/4] pinctrl: meson: meson8: add the AO HDMI CEC pin
In-Reply-To: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170504184932.5372-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds another missing pin found in the Meson8 SoCs. Currently
there's no driver which would use this pin yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 55fbd1a17dbe..f022965866b0 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -416,6 +416,8 @@ static const unsigned int i2s_ao_clk_out_ao_pins[] = { PIN(GPIOAO_9, AO_OFF) };
 static const unsigned int i2s_lr_clk_out_ao_pins[] = { PIN(GPIOAO_10, AO_OFF) };
 static const unsigned int i2s_out_ch01_ao_pins[] = { PIN(GPIOAO_11, AO_OFF) };
 
+static const unsigned int hdmi_cec_ao_pins[] = { PIN(GPIOAO_12, AO_OFF) };
+
 static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOX_0, 0),
 	GPIO_GROUP(GPIOX_1, 0),
@@ -769,6 +771,8 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 	GROUP(i2s_ao_clk_out_ao,	0,	29),
 	GROUP(i2s_lr_clk_out_ao,	0,	28),
 	GROUP(i2s_out_ch01_ao,		0,	27),
+
+	GROUP(hdmi_cec_ao,		0,	17),
 };
 
 static const char * const gpio_groups[] = {
@@ -985,6 +989,10 @@ static const char * const i2s_ao_groups[] = {
 	"i2s_out_ch01_ao"
 };
 
+static const char * const hdmi_cec_ao_groups[] = {
+	"hdmi_cec_ao"
+};
+
 static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(sd_a),
@@ -1029,6 +1037,7 @@ static struct meson_pmx_func meson8_aobus_functions[] = {
 	FUNCTION(i2c_mst_ao),
 	FUNCTION(pwm_f_ao),
 	FUNCTION(i2s_ao),
+	FUNCTION(hdmi_cec_ao),
 };
 
 static struct meson_bank meson8_cbus_banks[] = {
-- 
2.12.2
