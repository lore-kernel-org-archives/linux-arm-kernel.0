From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 27 Mar 2012 15:42:48 +0200
Subject: [PATCHv2 14/14] common: DMA-mapping: add NON-CONSISTENT attribute
In-Reply-To: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1332855768-32583-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
consistent or non-consistent memory as it sees fit.  By using this API,
you are guaranteeing to the platform that you have all the correct and
necessary sync points for this memory in the driver should it choose to
return non-consistent memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/DMA-attributes.txt |    9 +++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 811a5d4..9120de2 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -41,3 +41,12 @@ buffered to improve performance.
 Since it is optional for platforms to implement DMA_ATTR_WRITE_COMBINE,
 those that do not will simply ignore the attribute and exhibit default
 behavior.
+
+DMA_ATTR_NON_CONSISTENT
+-----------------------
+
+DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
+consistent or non-consistent memory as it sees fit.  By using this API,
+you are guaranteeing to the platform that you have all the correct and
+necessary sync points for this memory in the driver should it choose to
+return non-consistent memory.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index ada61e1..547ab56 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -14,6 +14,7 @@ enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
 	DMA_ATTR_WEAK_ORDERING,
 	DMA_ATTR_WRITE_COMBINE,
+	DMA_ATTR_NON_CONSISTENT,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.1.569.g6f426
