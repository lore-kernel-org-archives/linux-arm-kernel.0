From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Oct 2012 17:36:43 -0700
Subject: [PATCH 4/4] ARM: OMAP2+: Move iopgtable header to drivers/iommu/
In-Reply-To: <20121016003513.19701.71718.stgit@muffinssi.local>
References: <20121016003513.19701.71718.stgit@muffinssi.local>
Message-ID: <20121016003643.19701.88277.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ido Yariv <ido@wizery.com>

The iopgtable header file is only used by the iommu & iovmm drivers, so
move it to drivers/iommu/, as part of the single zImage effort.

Cc: Joerg Roedel <joerg.roedel@amd.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Ido Yariv <ido@wizery.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/iommu/omap-iommu-debug.c            |    3 +--
 drivers/iommu/omap-iommu.c                  |    3 +--
 drivers/iommu/omap-iopgtable.h              |    0 
 drivers/iommu/omap-iovmm.c                  |    3 +--
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
