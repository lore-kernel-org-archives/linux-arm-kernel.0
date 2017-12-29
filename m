From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:33 +0100
Subject: [PATCH 29/67] dma-direct: use node local allocations for coherent
 memory
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-30-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index d0266b39788b..ab81de3ac1d3 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
 	if (!page)
-		page = alloc_pages(gfp, page_order);
+		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
 	if (!page)
 		return NULL;
 
-- 
2.14.2
