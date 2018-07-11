From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:25 -0600
Subject: [PATCH 15/25] coresight: include vmalloc.h for vmap/vunmap
In-Reply-To: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531338035-11729-16-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The newly introduced code fails to build in some configurations
unless we include the right headers:

drivers/hwtracing/coresight/coresight-tmc-etr.c: In function 'tmc_free_table_pages':
drivers/hwtracing/coresight/coresight-tmc-etr.c:206:3: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]

Fixes: 79613ae8715a ("coresight: Add generic TMC sg table framework")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6164eed0b5fe..3556d9a849e9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
 
-- 
2.7.4
