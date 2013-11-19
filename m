From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 22:44:28 +0100
Subject: [PATCH] ARM: ux500: delete remnant pin config macros
Message-ID: <1384897468-21723-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This deletes a few final pin configuration macros from the
ux500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index ff532ba30610..c98004beeccd 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -23,28 +23,6 @@ BIAS(abx500_out_lo, PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, 0));
 BIAS(abx500_in_pd, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 1));
 BIAS(abx500_in_nopull, PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN, 0));
 
-/* We use these to define hog settings that are always done on boot */
-#define DB8500_MUX_HOG(group,func) \
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-db8500", group, func)
-#define DB8500_PIN_HOG(pin,conf) \
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-db8500", pin, conf)
-
-/* These are default states associated with device and changed runtime */
-#define DB8500_MUX(group,func,dev) \
-	PIN_MAP_MUX_GROUP_DEFAULT(dev, "pinctrl-db8500", group, func)
-#define DB8500_PIN(pin,conf,dev) \
-	PIN_MAP_CONFIGS_PIN_DEFAULT(dev, "pinctrl-db8500", pin, conf)
-#define DB8500_PIN_IDLE(pin, conf, dev) \
-	PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_IDLE, "pinctrl-db8500",	\
-			    pin, conf)
-#define DB8500_PIN_SLEEP(pin, conf, dev) \
-	PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_SLEEP, "pinctrl-db8500",	\
-			    pin, conf)
-#define DB8500_MUX_STATE(group, func, dev, state) \
-	PIN_MAP_MUX_GROUP(dev, state, "pinctrl-db8500", group, func)
-#define DB8500_PIN_STATE(pin, conf, dev, state) \
-	PIN_MAP_CONFIGS_PIN(dev, state, "pinctrl-db8500", pin, conf)
-
 #define AB8500_MUX_HOG(group, func) \
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-ab8500.0", group, func)
 #define AB8500_PIN_HOG(pin, conf) \
-- 
1.8.3.1
