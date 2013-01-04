From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 4 Jan 2013 18:00:49 +0100
Subject: [PATCH] pinctrl: add pinconf-generic defines for output
Message-ID: <1357318849-12616-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds a definition of a generic output configuration
for a certain pin when using the generic pin configuration
library. Whereas driving pins low/high is usually a GPIO
business, you may want to set up pins into a default state
using hogs, and never touch them again. This helps out
with that scenario.

Based on a patch from Patrice Chotard.

Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c       | 1 +
 include/linux/pinctrl/pinconf-generic.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 833a364..bcf8157 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -46,6 +46,7 @@ struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "time units"),
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector"),
 	PCONFDUMP(PIN_CONFIG_LOW_POWER_MODE, "pin low power", "mode"),
+	PCONFDUMP(PIN_CONFIG_OUTPUT, "pin output", "level"),
 };
 
 void pinconf_generic_dump_pin(struct pinctrl_dev *pctldev,
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 47a1bdd..b23d99d 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -62,6 +62,8 @@
  *	operation, if several modes of operation are supported these can be
  *	passed in the argument on a custom form, else just use argument 1
  *	to indicate low power mode, argument 0 turns low power mode off.
+ * @PIN_CONFIG_OUTPUT: this will configure the pin in output, use argument
+ *	1 to indicate high level, argument 0 to indicate low level.
  * @PIN_CONFIG_END: this is the last enumerator for pin configurations, if
  *	you need to pass in custom configurations to the pin controller, use
  *	PIN_CONFIG_END+1 as the base offset.
@@ -79,6 +81,7 @@ enum pin_config_param {
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_POWER_SOURCE,
 	PIN_CONFIG_LOW_POWER_MODE,
+	PIN_CONFIG_OUTPUT,
 	PIN_CONFIG_END = 0x7FFF,
 };
 
-- 
1.7.11.3
