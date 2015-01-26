From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Mon, 26 Jan 2015 09:22:24 -0700
Subject: [PATCH 8/9] coresight-etm: remove check for unknown Kconfig macro
In-Reply-To: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
References: <1422289345-2084-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1422289345-2084-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Bolle <pebolle@tiscali.nl>

The CoreSight ETM/PTM driver contains a check for a
CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE macro. But there's no related
Kconfig symbol CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE. Remove that check
and the single line of code it hides.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-etm3x.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
index 73c36696f1b6..c965f5724abd 100644
--- a/drivers/coresight/coresight-etm3x.c
+++ b/drivers/coresight/coresight-etm3x.c
@@ -34,14 +34,8 @@
 
 #include "coresight-etm.h"
 
-#ifdef CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
-static int boot_enable = 1;
-#else
 static int boot_enable;
-#endif
-module_param_named(
-	boot_enable, boot_enable, int, S_IRUGO
-);
+module_param_named(boot_enable, boot_enable, int, S_IRUGO);
 
 /* The number of ETM/PTM currently registered */
 static int etm_count;
-- 
1.9.1
