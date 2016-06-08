From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Wed,  8 Jun 2016 21:26:27 +0800
Subject: [PATCH v2 2/7] iommu/rockchip: add map_sg callback for rk_iommu_ops
In-Reply-To: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1465392392-2003-3-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Xue <xxm@rock-chips.com>

The iommu_dma_alloc() in iommu/dma-iommu.c calls iommu_map_sg()
that requires the callback iommu_ops .map_sg(). Adding the
default_iommu_map_sg() to rockchip iommu accordingly.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <xxm@rock-chips.com>
---
 drivers/iommu/rockchip-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ec0ce62..3c16ec3 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1022,6 +1022,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.detach_dev = rk_iommu_detach_device,
 	.map = rk_iommu_map,
 	.unmap = rk_iommu_unmap,
+	.map_sg = default_iommu_map_sg,
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
-- 
1.9.1
