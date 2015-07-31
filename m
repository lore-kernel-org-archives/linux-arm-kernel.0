From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 31 Jul 2015 17:03:13 +0200
Subject: [PATCH] soc: mediatek: Fix SCPSYS compilation
Message-ID: <1438354993-21098-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCPSYS driver misses the module.h include which makes it fail
when compiling with allmodconf.

This patch fixes this.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/soc/mediatek/mtk-scpsys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 43a79ed..164a7d8 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
-- 
1.9.1
