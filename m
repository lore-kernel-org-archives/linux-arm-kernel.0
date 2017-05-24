From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:20:39 +0200
Subject: [PATCH 2/5] pinctrl: meson-gxl: Fix typo in AO SPDIF pins
In-Reply-To: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614042-2676-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AO SPDIF pins were incorrectly defined with the EE pin offset.

Cc: Jerome Brunet <jbrunet@baylibre.com>
Fixes: b840d649f9ec ("pinctrl: meson: gxl: add spdif output pins")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 9af8e6a..454d73f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -279,8 +279,8 @@
 static const unsigned int i2s_out_ch23_ao_pins[] = { PIN(GPIOAO_8, 0) };
 static const unsigned int i2s_out_ch45_ao_pins[] = { PIN(GPIOAO_9, 0) };
 
-static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, EE_OFF) };
-static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, EE_OFF) };
+static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, 0) };
+static const unsigned int spdif_out_ao_9_pins[]	= { PIN(GPIOAO_9, 0) };
 
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
-- 
1.9.1
