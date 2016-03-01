From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 01 Mar 2016 10:36:23 +0100
Subject: [PATCH] iommu/mtk: fix handling of of_count_phandle_with_args result
Message-ID: <1456824983-13550-1-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function can return negative value so it should be assigned to signed
variable. The patch changes also type of related i variable to make code
more compact and coherent.

The problem has been detected using patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/iommu/mtk_iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 721ffdb..de9241b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -578,8 +578,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct resource         *res;
 	struct component_match  *match = NULL;
 	void                    *protect;
-	unsigned int            i, larb_nr;
-	int                     ret;
+	int                     i, larb_nr, ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-- 
1.9.1
