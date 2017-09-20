From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:27 +0200
Subject: [PATCH 8/8] pinctrl: meson-gxbb: add missing GPIOX_22 pin
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-9-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIOX_22 is declared as a gpio but the id is no present in the pin
table. This hole trigger an error while reading the pingroup debugfs entry

GPIOX_22 is no routed externally. For all we know, it could an internal
pin of SoC

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 1305d68b0954..62483b67f114 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -136,6 +136,7 @@ static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
 	MESON_PIN(GPIOX_19),
 	MESON_PIN(GPIOX_20),
 	MESON_PIN(GPIOX_21),
+	MESON_PIN(GPIOX_22),
 
 	MESON_PIN(GPIOCLK_0),
 	MESON_PIN(GPIOCLK_1),
-- 
2.13.5
