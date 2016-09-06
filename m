From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Tue,  6 Sep 2016 15:56:37 +0800
Subject: [PATCH] drivers/hwtracing: add missing header dependencies
Message-ID: <1473148597-25478-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 1 warning when building kernel with W=1:
drivers/hwtracing/coresight/coresight-etm-perf.c:345:5: warning: no previous prototype for 'etm_perf_symlink' [-Wmissing-prototypes]

In fact, this function is declared in coresight-etm-perf.h, so this patch
add missing header dependencies.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 755125f..d936e82 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -28,6 +28,7 @@
 #include <linux/workqueue.h>
 
 #include "coresight-priv.h"
+#include "coresight-etm-perf.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
-- 
2.7.4
