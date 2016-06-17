From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Jun 2016 08:26:59 +0200
Subject: [PATCH v2 09/10] iommu/exynos: Remove excessive, useless debug
In-Reply-To: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1466144820-6286-10-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove excessive, useless debug about skipping TLB invalidation, which
is a normal situation when more aggressive power management is enabled.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 633e6d023c0d..9d1a14f88891 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -574,9 +574,6 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 			sysmmu_unblock(data);
 		}
 		clk_disable(data->clk_master);
-	} else {
-		dev_dbg(data->master,
-			"disabled. Skipping TLB invalidation @ %#x\n", iova);
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
 }
-- 
1.9.1
