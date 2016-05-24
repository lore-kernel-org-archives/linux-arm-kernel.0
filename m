From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 May 2016 08:28:07 +0200
Subject: [PATCH 1/4] dma-mapping: Constify attrs passed to dma_get_attr
In-Reply-To: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464071290-15948-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma_get_attr() does not modify passed dma_attrs so the pointer can
point to const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/linux/dma-attrs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 5246239a4953..f3c5aeadb100 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -60,7 +60,8 @@ static inline void dma_set_attr(enum dma_attr attr, struct dma_attrs *attrs)
  * @attr: attribute to set
  * @attrs: struct dma_attrs (may be NULL)
  */
-static inline int dma_get_attr(enum dma_attr attr, struct dma_attrs *attrs)
+static inline int dma_get_attr(enum dma_attr attr,
+			       const struct dma_attrs *attrs)
 {
 	if (attrs == NULL)
 		return 0;
-- 
1.9.1
