From: b29396@freescale.com (Dong Aisheng)
Date: Thu, 5 Apr 2012 17:07:23 +0800
Subject: [PATCH 1/1] pinctrl: fix compile error if not select PINMUX support
Message-ID: <1333616843-3607-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The pinctrl_register_mappings is defined in core.c, so change the dependent
macro from CONFIG_MUX to CONFIG_PINCTRL.

The compile error message is:
drivers/pinctrl/core.c:886: error: redefinition of 'pinctrl_register_mappings'
include/linux/pinctrl/machine.h:160: note: previous definition of 'pinctrl_register_mappings' was here
make[2]: *** [drivers/pinctrl/core.o] Error 1
make[1]: *** [drivers/pinctrl] Error 2
make: *** [drivers] Error 2

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 include/linux/pinctrl/machine.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index 226444e..e4d1de7 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -150,7 +150,7 @@ struct pinctrl_map {
 #define PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(dev, grp, cfgs)		\
 	PIN_MAP_CONFIGS_GROUP(dev, PINCTRL_STATE_DEFAULT, dev, grp, cfgs)
 
-#ifdef CONFIG_PINMUX
+#ifdef CONFIG_PINCTRL
 
 extern int pinctrl_register_mappings(struct pinctrl_map const *map,
 				unsigned num_maps);
-- 
1.7.0.4
