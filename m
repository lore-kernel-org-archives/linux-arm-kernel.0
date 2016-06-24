From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 24 Jun 2016 10:13:27 +0800
Subject: [PATCH v5 2/8] iommu/rockchip: Add map_sg callback for rk_iommu_ops
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1466734413-7453-3-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Xue <xxm@rock-chips.com>

The iommu_dma_alloc() in iommu/dma-iommu.c calls iommu_map_sg()
that requires the callback iommu_ops .map_sg(). Adding the
default_iommu_map_sg() to Rockchip IOMMU accordingly.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <xxm@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/iommu/rockchip-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5a9659a..53fa0d9 100644
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
