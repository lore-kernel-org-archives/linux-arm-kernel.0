From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jan 2013 22:30:33 +0100
Subject: [PATCH 1/7] pinctrl: pinconf-generic: add drive strength parameter
In-Reply-To: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1358544639-14761-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pin configurations IP allows to set the current output to the pin.
This patch adds such a parameter to the pinconf-generic mechanism.

This parameter takes as argument the drive strength in mA.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 include/linux/pinctrl/pinconf-generic.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index 47a1bdd..c533789 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -46,6 +46,8 @@
  * @PIN_CONFIG_DRIVE_OPEN_SOURCE: the pin will be driven with open source
  *	(open emitter). Sending this config will enabale open drain mode, the
  *	argument is ignored.
+ * @PIN_CONFIG_DRIVE_STRENGTH: the pin will output the current passed as
+ * 	argument. The argument is in mA.
  * @PIN_CONFIG_INPUT_SCHMITT_DISABLE: disable schmitt-trigger mode on the pin.
  * @PIN_CONFIG_INPUT_SCHMITT: this will configure an input pin to run in
  *	schmitt-trigger mode. If the schmitt-trigger has adjustable hysteresis,
@@ -74,6 +76,7 @@ enum pin_config_param {
 	PIN_CONFIG_DRIVE_PUSH_PULL,
 	PIN_CONFIG_DRIVE_OPEN_DRAIN,
 	PIN_CONFIG_DRIVE_OPEN_SOURCE,
+	PIN_CONFIG_DRIVE_STRENGTH,
 	PIN_CONFIG_INPUT_SCHMITT_DISABLE,
 	PIN_CONFIG_INPUT_SCHMITT,
 	PIN_CONFIG_INPUT_DEBOUNCE,
-- 
1.7.10.4
