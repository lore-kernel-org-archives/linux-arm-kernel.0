From: ido@wizery.com (Ido Yariv)
Date: Mon,  1 Oct 2012 18:46:31 -0400
Subject: [PATCH v2 5/5] arm: omap: Move iopgtable header to drivers/iommu/
In-Reply-To: <1349131591-10804-1-git-send-email-ido@wizery.com>
References: <20120927195526.GP4840@atomide.com>
 <1349131591-10804-1-git-send-email-ido@wizery.com>
Message-ID: <1349131591-10804-5-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iopgtable header file is only used by the iommu & iovmm drivers, so
move it to drivers/iommu/, as part of the single zImage effort.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/iommu/omap-iommu-debug.c                                       | 3 +--
 drivers/iommu/omap-iommu.c                                             | 3 +--
 .../include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h         | 0
 drivers/iommu/omap-iovmm.c                                             | 3 +--
 4 files changed, 3 insertions(+), 6 deletions(-)
 rename arch/arm/plat-omap/include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h (100%)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 8c1e30b..84dbfd2 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -22,8 +22,7 @@
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/iovmm-omap.h>
 
-#include <plat/iopgtable.h>
-
+#include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
 #define MAXCOLUMN 100 /* for short messages */
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 6100334..1ca33b0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -26,8 +26,7 @@
 
 #include <linux/platform_data/iommu-omap.h>
 
-#include <plat/iopgtable.h>
-
+#include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
diff --git a/arch/arm/plat-omap/include/plat/iopgtable.h b/drivers/iommu/omap-iopgtable.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/iopgtable.h
rename to drivers/iommu/omap-iopgtable.h
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index b5ac2cd..2820e3a 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -24,8 +24,7 @@
 #include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/iovmm-omap.h>
 
-#include <plat/iopgtable.h>
-
+#include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
 static struct kmem_cache *iovm_area_cachep;
-- 
1.7.11.4
