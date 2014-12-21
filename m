From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 21 Dec 2014 22:14:30 +0100
Subject: [PATCH 09/28] iommu: drop owner assignment from platform_drivers
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1419196495-9626-10-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 drivers/iommu/rockchip-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index b2023af384b9..6a8b1ec4a48a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1009,7 +1009,6 @@ static struct platform_driver rk_iommu_driver = {
 	.remove = rk_iommu_remove,
 	.driver = {
 		   .name = "rk_iommu",
-		   .owner = THIS_MODULE,
 		   .of_match_table = of_match_ptr(rk_iommu_dt_ids),
 	},
 };
-- 
2.1.3
