From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 27 Mar 2012 15:42:47 +0200
Subject: [PATCHv2 13/14] common: DMA-mapping: add WRITE_COMBINE attribute
In-Reply-To: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1332855768-32583-14-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA_ATTR_WRITE_COMBINE specifies that writes to the mapping may be
buffered to improve performance. It will be used by the replacement for
ARM/ARV32 specific dma_alloc_writecombine() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/DMA-attributes.txt |   10 ++++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index b768cc0..811a5d4 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -31,3 +31,13 @@ may be weakly ordered, that is that reads and writes may pass each other.
 Since it is optional for platforms to implement DMA_ATTR_WEAK_ORDERING,
 those that do not will simply ignore the attribute and exhibit default
 behavior.
+
+DMA_ATTR_WRITE_COMBINE
+----------------------
+
+DMA_ATTR_WRITE_COMBINE specifies that writes to the mapping may be
+buffered to improve performance.
+
+Since it is optional for platforms to implement DMA_ATTR_WRITE_COMBINE,
+those that do not will simply ignore the attribute and exhibit default
+behavior.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 71ad34e..ada61e1 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -13,6 +13,7 @@
 enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
 	DMA_ATTR_WEAK_ORDERING,
+	DMA_ATTR_WRITE_COMBINE,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.1.569.g6f426
