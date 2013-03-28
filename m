From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 28 Mar 2013 17:21:08 +0100
Subject: [PATCH 1/2] ARM: ux500: remove redundant DB8500_PIN_SLEEP definition
In-Reply-To: <1364487669-24368-1-git-send-email-fabio.baltieri@linaro.org>
References: <1364487669-24368-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1364487669-24368-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DB8500_PIN_SLEEP was defined twice, drop one of the two.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0a3f30d..625880f 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -78,9 +78,6 @@ BIAS(out_wkup_pdis, PIN_SLPM_DIR_OUTPUT|PIN_SLPM_WAKEUP_ENABLE|
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-db8500", group, func)
 #define DB8500_PIN_HOG(pin,conf) \
 	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-db8500", pin, conf)
-#define DB8500_PIN_SLEEP(pin, conf, dev) \
-	PIN_MAP_CONFIGS_PIN(dev, PINCTRL_STATE_SLEEP, "pinctrl-db8500",	\
-			    pin, conf)
 
 /* These are default states associated with device and changed runtime */
 #define DB8500_MUX(group,func,dev) \
-- 
1.8.1.3
