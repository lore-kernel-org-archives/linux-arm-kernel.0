From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Sun, 16 Dec 2012 13:32:03 +0100
Subject: [PATCH] ARM: iommu: Include linux/kref.h in asm/dma-iommu.h
Message-ID: <1355661123-26474-1-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_iommu_mapping structure defined in asm/dma-iommu.h embeds a
struct kref, include the appropriate header file.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/include/asm/dma-iommu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 799b094..666d8a8 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -7,6 +7,7 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 #include <linux/kmemcheck.h>
+#include <linux/kref.h>
 
 struct dma_iommu_mapping {
 	/* iommu specific data */
-- 
1.7.8.6
