From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Jun 2018 13:48:38 +0200
Subject: [PATCH] coresight: include vmalloc.h for vmap/vunmap
Message-ID: <20180605114856.1558554-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced code fails to build in some configurations
unless we include the right headers:

drivers/hwtracing/coresight/coresight-tmc-etr.c: In function 'tmc_free_table_pages':
drivers/hwtracing/coresight/coresight-tmc-etr.c:206:3: error: implicit declaration of function 'vunmap'; did you mean 'iounmap'? [-Werror=implicit-function-declaration]

Fixes: 79613ae8715a ("coresight: Add generic TMC sg table framework")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.9.0
