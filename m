From: geliangtang@gmail.com (Geliang Tang)
Date: Fri, 24 Mar 2017 22:12:23 +0800
Subject: [PATCH] arm/dma-mapping: use for_each_sg
Message-ID: <e9923f7ea2c0fd866efb48be52ffe91d25dd0290.1490326970.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use for_each_sg() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 63eabb0..e551351 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1720,7 +1720,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	if (iova == DMA_ERROR_CODE)
 		return -ENOMEM;
 
-	for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
+	for_each_sg(sg, s, size >> PAGE_SHIFT, count) {
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-- 
2.9.3
