From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 17 Sep 2016 17:09:44 +0200
Subject: [PATCH 03/24] ste_dma40: Rename a jump label in d40_lcla_allocate()
In-Reply-To: <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <92810066-69b6-94e7-dcec-a28594b1328f@users.sourceforge.net>
Message-ID: <44b5c6a8-3e6d-573c-c556-a8036d25d3e4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 17 Sep 2016 08:23:37 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/dma/ste_dma40.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 80a199a..76d63b6 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3429,7 +3429,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 
 			for (j = 0; j < i; j++)
 				free_pages(page_list[j], base->lcla_pool.pages);
-			goto failure;
+			goto free_page_list;
 		}
 
 		if ((virt_to_phys((void *)page_list[i]) &
@@ -3456,7 +3456,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 							 GFP_KERNEL);
 		if (!base->lcla_pool.base_unaligned) {
 			ret = -ENOMEM;
-			goto failure;
+			goto free_page_list;
 		}
 
 		base->lcla_pool.base = PTR_ALIGN(base->lcla_pool.base_unaligned,
@@ -3469,12 +3469,12 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	if (dma_mapping_error(base->dev, pool->dma_addr)) {
 		pool->dma_addr = 0;
 		ret = -ENOMEM;
-		goto failure;
+		goto free_page_list;
 	}
 
 	writel(virt_to_phys(base->lcla_pool.base),
 	       base->virtbase + D40_DREG_LCLA);
-failure:
+ free_page_list:
 	kfree(page_list);
 	return ret;
 }
-- 
2.10.0
