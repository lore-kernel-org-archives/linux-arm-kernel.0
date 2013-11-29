From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:15:49 +0000
Subject: [PATCH 3/4] iommu: add IOMMU_EXEC flag for safely allowing XN mappings
In-Reply-To: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
References: <1385727350-20032-1-git-send-email-will.deacon@arm.com>
Message-ID: <1385727350-20032-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst most IOMMU mappings should probably be non-executable, there
may be cases (HSA?) where executable mappings are required.

This patch introduces a new mapping flag, IOMMU_EXEC, to indicate that
the mapping should be mapped as executable.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/iommu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a444c790fa72..709a697c4e02 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -24,9 +24,10 @@
 #include <linux/types.h>
 #include <trace/events/iommu.h>
 
-#define IOMMU_READ	(1)
-#define IOMMU_WRITE	(2)
-#define IOMMU_CACHE	(4) /* DMA cache coherency */
+#define IOMMU_READ	(1 << 0)
+#define IOMMU_WRITE	(1 << 1)
+#define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
+#define IOMMU_EXEC	(1 << 3)
 
 struct iommu_ops;
 struct iommu_group;
-- 
1.8.2.2
