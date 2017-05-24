From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:20:41 +0200
Subject: [PATCH 4/5] pinctrl: meson-gxl: Add CEC pins
In-Reply-To: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614042-2676-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AO and EE domain CEC pins for the Amlogic Meson GXL SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 454d73f..7d81287 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -282,6 +282,9 @@
 static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, 0) };
 static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, 0) };
 
+static const unsigned int ao_cec_pins[]		= { PIN(GPIOAO_8, 0) };
+static const unsigned int ee_cec_pins[]		= { PIN(GPIOAO_8, 0) };
+
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
 	GPIO_GROUP(GPIOZ_1, EE_OFF),
@@ -527,6 +530,8 @@
 	GROUP(i2s_out_ch45_ao,	1,	1),
 	GROUP(spdif_out_ao_6,	0,	16),
 	GROUP(spdif_out_ao_9,	0,	4),
+	GROUP(ao_cec,		0,	15),
+	GROUP(ee_cec,		0,	14),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -702,6 +707,10 @@
 	"spdif_out_ao_6", "spdif_out_ao_9",
 };
 
+static const char * const cec_ao_groups[] = {
+	"ao_cec", "ee_cec",
+};
+
 static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
@@ -740,6 +749,7 @@
 	FUNCTION(pwm_ao_b),
 	FUNCTION(i2s_out_ao),
 	FUNCTION(spdif_out_ao),
+	FUNCTION(cec_ao),
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-- 
1.9.1
