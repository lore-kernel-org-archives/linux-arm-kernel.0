From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:20:42 +0200
Subject: [PATCH 5/5] pinctrl: meson-gxl: Add Ethernet PHY LEDS pins
In-Reply-To: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614042-2676-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson GXL SoCs embeds an 10/100 Ethernet PHY, this patchs enables
the Link and Activity LEDs signals.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 7d81287..78a9af5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -239,6 +239,9 @@
 
 static const unsigned int spdif_out_h_pins[]	= { PIN(GPIOH_4, EE_OFF) };
 
+static const unsigned int eth_link_led_pins[]	= { PIN(GPIOZ_14, EE_OFF) };
+static const unsigned int eth_act_led_pins[]	= { PIN(GPIOZ_15, EE_OFF) };
+
 static const struct pinctrl_pin_desc meson_gxl_aobus_pins[] = {
 	MESON_PIN(GPIOAO_0, 0),
 	MESON_PIN(GPIOAO_1, 0),
@@ -437,6 +440,8 @@
 	GROUP(i2s_out_ch23_z,	3,	26),
 	GROUP(i2s_out_ch45_z,	3,	25),
 	GROUP(i2s_out_ch67_z,	3,	24),
+	GROUP(eth_link_led,	4,	25),
+	GROUP(eth_act_led,	4,	24),
 
 	/* Bank H */
 	GROUP(hdmi_hpd,		6,	31),
@@ -665,6 +670,10 @@
 	"spdif_out_h",
 };
 
+static const char * const eth_led_groups[] = {
+	"eth_link_led", "eth_act_led",
+};
+
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
@@ -736,6 +745,7 @@
 	FUNCTION(hdmi_i2c),
 	FUNCTION(i2s_out),
 	FUNCTION(spdif_out),
+	FUNCTION(eth_led),
 };
 
 static struct meson_pmx_func meson_gxl_aobus_functions[] = {
-- 
1.9.1
