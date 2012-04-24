From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 24 Apr 2012 08:59:23 +0200
Subject: [PATCH 1/1] pinctrl: fix pinctrl_register_mappings
Message-ID: <1335250763-7678-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the function was to pinctrl

e93bcee00c4 pinctrl: move generic functions to the pinctrl_ namespace

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 include/linux/pinctrl/machine.h |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index fee4349..fb6b649 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -148,18 +148,7 @@ struct pinctrl_map {
 #define PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(dev, grp, cfgs)		\
 	PIN_MAP_CONFIGS_GROUP(dev, PINCTRL_STATE_DEFAULT, dev, grp, cfgs)
 
-#ifdef CONFIG_PINMUX
-
-extern int pinctrl_register_mappings(struct pinctrl_map const *map,
+extern int pinctrl_register_mappings(struct pinctrl_map const *maps,
 				unsigned num_maps);
 
-#else
-
-static inline int pinctrl_register_mappings(struct pinctrl_map const *map,
-					   unsigned num_maps)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_PINMUX */
 #endif
-- 
1.7.9.1
