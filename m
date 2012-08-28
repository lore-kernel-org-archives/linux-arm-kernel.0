From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 28 Aug 2012 14:43:51 +0300
Subject: [PATCH 3/4] ARM: dma-mapping: Refrain noisy console message
In-Reply-To: <1346154232-13299-1-git-send-email-hdoyu@nvidia.com>
References: <1346154232-13299-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1346154232-13299-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With many IOMMU'able devices, console gets noisy.

Tegra30 has a few dozen of IOMMU'able devices.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 8cb9542..2621282 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1747,7 +1747,7 @@ int arm_iommu_attach_device(struct device *dev,
 	dev->archdata.mapping = mapping;
 	set_dma_ops(dev, &iommu_ops);
 
-	pr_info("Attached IOMMU controller to %s device.\n", dev_name(dev));
+	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
 }
 
-- 
1.7.5.4
