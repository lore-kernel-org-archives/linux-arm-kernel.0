From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Thu, 15 May 2014 12:40:44 +0200
Subject: [PATCH v2 03/10] iommu/ipmmu-vmsa: Fix the supported page sizes
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1400150451-13469-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hardware supports 2MB page sizes, not 1MB.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 49dbedd..313b5b9 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -959,7 +959,7 @@ static struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_1M | SZ_64K | SZ_4K,
+	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.5.5
