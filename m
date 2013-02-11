From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 12 Feb 2013 01:10:57 +0800
Subject: [PATCH v8 10/12] pinctrl: generic: rename input schmitt disable
In-Reply-To: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1360602659-4774-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename PIN_CONFIG_INPUT_SCHMITT_DISABLE to
PIN_CONFIG_INPUT_SCHMITT_ENABLE. It's used to make it more generialize.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinconf-generic.c       |    2 +-
 include/linux/pinctrl/pinconf-generic.h |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 4a67848..e43d2e0 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -43,7 +43,7 @@ struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL),
-	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT_DISABLE, "input schmitt disabled", NULL),
+	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT_ENABLE, "input schmitt enabled", NULL),
 	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL),
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "time units"),
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector"),
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index f2daff4..93314cb 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -50,7 +50,9 @@
  *	argument is ignored.
  * @PIN_CONFIG_DRIVE_STRENGTH: the pin will output the current passed as
  * 	argument. The argument is in mA.
- * @PIN_CONFIG_INPUT_SCHMITT_DISABLE: disable schmitt-trigger mode on the pin.
+ * @PIN_CONFIG_INPUT_SCHMITT_ENABLE: control schmitt-trigger mode on the pin.
+ *      If the argument != 0, schmitt-trigger mode is enabled. If it's 0,
+ *      schmitt-trigger mode is disabled.
  * @PIN_CONFIG_INPUT_SCHMITT: this will configure an input pin to run in
  *	schmitt-trigger mode. If the schmitt-trigger has adjustable hysteresis,
  *	the threshold value is given on a custom format as argument when
@@ -85,7 +87,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_OPEN_DRAIN,
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
 	PIN_CONFIG_DRIVE_STRENGTH,
-	PIN_CONFIG_INPUT_SCHMITT_DISABLE,
+	PIN_CONFIG_INPUT_SCHMITT_ENABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_POWER_SOURCE,
-- 
1.7.10.4
