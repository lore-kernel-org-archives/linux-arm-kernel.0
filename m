From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Nov 2014 17:27:25 +0000
Subject: [RFC PATCH 1/4] iommu: build iova.c for any IOMMU
In-Reply-To: <cover.1416931258.git.robin.murphy@arm.com>
References: <cover.1416931258.git.robin.murphy@arm.com>
Message-ID: <90240865e7cc00d0f7e471605ba9d2478b81ea88.1416931258.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for sharing the IOVA allocator, build it for all
IOMMU API users.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 16edef7..9f7910b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_IOMMU_API) += iommu.o
+obj-$(CONFIG_IOMMU_API) += iommu.o iova.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
@@ -7,7 +7,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
+obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
-- 
1.9.1
