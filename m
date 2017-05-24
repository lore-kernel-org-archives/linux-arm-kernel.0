From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:20:38 +0200
Subject: [PATCH 1/5] pinctrl: meson-gxl: Fix typo in AO I2S pins
In-Reply-To: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614042-2676-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AO I2S pins were incorrectly defined with the EE pin offset.

Cc: Jerome Brunet <jbrunet@baylibre.com>
Fixes: 2899adf0422 ("pinctrl: meson: gxl: add i2s output pins")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 719ff1b..9af8e6a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -276,8 +276,8 @@
 static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
 static const unsigned int pwm_ao_b_6_pins[]	= { PIN(GPIOAO_6, 0) };
 
-static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, EE_OFF) };
-static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, EE_OFF) };
+static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, 0) };
+static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, 0) };
 
 static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, EE_OFF) };
 static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, EE_OFF) };
-- 
1.9.1
