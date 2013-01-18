From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 18 Jan 2013 15:31:15 +0800
Subject: [PATCH v7 11/15] pinctrl: generic: add slew rate config parameter
In-Reply-To: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358494279-16503-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PIN_CONFIG_SLEW_RATE parameter into pinconf-generic driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c       |    1 +
 include/linux/pinctrl/pinconf-generic.h |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 833a364..678db63 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -45,6 +45,7 @@ struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL),
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "time units"),
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector"),
+	PCONFDUMP(PIN_CONFIG_SLEW_RATE, "slew rate", NULL),
 	PCONFDUMP(PIN_CONFIG_LOW_POWER_MODE, "pin low power", "mode"),
 };
 
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 47a1bdd..e970a12 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -58,6 +58,9 @@
  * @PIN_CONFIG_POWER_SOURCE: if the pin can select between different power
  *	supplies, the argument to this parameter (on a custom format) tells
  *	the driver which alternative power source to use.
+ * @PIN_CONFIG_SLEW_RATE: if the pin can select slew rate, the argument to
+ * 	this parameter (on a custom format) tells the driver which alternative
+ * 	slew rate to use.
  * @PIN_CONFIG_LOW_POWER_MODE: this will configure the pin for low power
  *	operation, if several modes of operation are supported these can be
  *	passed in the argument on a custom form, else just use argument 1
@@ -78,6 +81,7 @@ enum pin_config_param {
 	PIN_CONFIG_INPUT_SCHMITT,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_POWER_SOURCE,
+	PIN_CONFIG_SLEW_RATE,
 	PIN_CONFIG_LOW_POWER_MODE,
 	PIN_CONFIG_END = 0x7FFF,
 };
-- 
1.7.10.4
