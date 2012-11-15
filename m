From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 16:36:33 +0800
Subject: [PATCH v5 04/10] pinctrl: generic: add input schmitt disable parameter
In-Reply-To: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352968600-15345-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Marvell PXA/MMP silicons, input schmitt disable value is 0x40, not 0.
So append new config parameter -- input schmitt disable.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinconf-generic.c       |    1 +
 include/linux/pinctrl/pinconf-generic.h |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 33fbaea..833a364 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -41,6 +41,7 @@ struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL),
+	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT_DISABLE, "input schmitt disabled", NULL),
 	PCONFDUMP(PIN_CONFIG_INPUT_SCHMITT, "input schmitt trigger", NULL),
 	PCONFDUMP(PIN_CONFIG_INPUT_DEBOUNCE, "input debounce", "time units"),
 	PCONFDUMP(PIN_CONFIG_POWER_SOURCE, "pin power source", "selector"),
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 4f0abb9..47a1bdd 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -46,11 +46,11 @@
  * @PIN_CONFIG_DRIVE_OPEN_SOURCE: the pin will be driven with open source
  *	(open emitter). Sending this config will enabale open drain mode, the
  *	argument is ignored.
+ * @PIN_CONFIG_INPUT_SCHMITT_DISABLE: disable schmitt-trigger mode on the pin.
  * @PIN_CONFIG_INPUT_SCHMITT: this will configure an input pin to run in
  *	schmitt-trigger mode. If the schmitt-trigger has adjustable hysteresis,
  *	the threshold value is given on a custom format as argument when
- *	setting pins to this mode. The argument zero turns the schmitt trigger
- *	off.
+ *	setting pins to this mode.
  * @PIN_CONFIG_INPUT_DEBOUNCE: this will configure the pin to debounce mode,
  *	which means it will wait for signals to settle when reading inputs. The
  *	argument gives the debounce time on a custom format. Setting the
@@ -74,6 +74,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_PUSH_PULL,
 	PIN_CONFIG_DRIVE_OPEN_DRAIN,
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
+	PIN_CONFIG_INPUT_SCHMITT_DISABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
 	PIN_CONFIG_INPUT_DEBOUNCE,
 	PIN_CONFIG_POWER_SOURCE,
-- 
1.7.10.4
