From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  5 Apr 2016 12:39:30 +0100
Subject: [PATCH 1/3] iommu: Add MMIO mapping type
Message-ID: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platforms, MMIO regions might need slightly different treatment
compared to mapping regular memory; add the notion of MMIO mappings to
the IOMMU API's memory type flags, so that callers can let the IOMMU
drivers know to do the right thing.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Hi all,

Since this is a prerequisite for both MSI remapping and slave DMA
handling to function properly, and the latter still needs some design
work to reach a consensus[1], I thought it worth reposting this
separately from Niklas' series. I've also split it up now that there's
short-descriptor format to cover as well.

Robin.

[1]:http://lists.linuxfoundation.org/pipermail/iommu/2016-March/016059.html

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..34b6432 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -30,6 +30,7 @@
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
+#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
 
 struct iommu_ops;
 struct iommu_group;
-- 
2.7.3.dirty
