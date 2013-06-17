From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 17:12:28 +0200
Subject: [PATCH] pinctrl: export pinctrl_pm_select_*_state
In-Reply-To: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <3037061.7rG6iWz9IX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three functions pinctrl_pm_select_default_state,
pinctrl_pm_select_sleep_state, and pinctrl_pm_select_idle_state
are used in drivers that can be loadable modules, and should
be exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 33710b5..32eb7e2 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1245,6 +1245,7 @@ int pinctrl_pm_select_default_state(struct device *dev)
 		dev_err(dev, "failed to activate default pinctrl state\n");
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pinctrl_pm_select_default_state);
 
 /**
  * pinctrl_pm_select_sleep_state() - select sleep pinctrl state for PM
@@ -1264,6 +1265,7 @@ int pinctrl_pm_select_sleep_state(struct device *dev)
 		dev_err(dev, "failed to activate pinctrl sleep state\n");
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pinctrl_pm_select_sleep_state);
 
 /**
  * pinctrl_pm_select_idle_state() - select idle pinctrl state for PM
@@ -1283,7 +1285,7 @@ int pinctrl_pm_select_idle_state(struct device *dev)
 		dev_err(dev, "failed to activate pinctrl idle state\n");
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(pinctrl_pm_select_idle_state);
 #endif
 
 #ifdef CONFIG_DEBUG_FS
