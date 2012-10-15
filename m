From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 15 Oct 2012 14:05:18 -0000
Subject: [RFC 1/2] common: DMA-mapping: add DMA_ATTR_FORCE_CONTIGUOUS attribute
In-Reply-To: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
References: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1350309832-18461-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA_ATTR_FORCE_CONTIGUOUS attribute to the DMA-mapping
subsystem.

By default DMA-mapping subsystem is allowed to assemble the buffer
allocated by dma_alloc_attrs() function from individual pages if it can
be mapped as contiguous chunk into device dma address space. By
specifing this attribute the allocated buffer is forced to be contiguous
also in physical memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/DMA-attributes.txt |    9 +++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 10 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index f503090..e59480d 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -91,3 +91,12 @@ transferred to 'device' domain. This attribute can be also used for
 dma_unmap_{single,page,sg} functions family to force buffer to stay in
 device domain after releasing a mapping for it. Use this attribute with
 care!
+
+DMA_ATTR_FORCE_CONTIGUOUS
+-------------------------
+
+By default DMA-mapping subsystem is allowed to assemble the buffer
+allocated by dma_alloc_attrs() function from individual pages if it can
+be mapped as contiguous chunk into device dma address space. By
+specifing this attribute the allocated buffer is forced to be contiguous
+also in physical memory.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index f83f793..c8e1831 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -17,6 +17,7 @@ enum dma_attr {
 	DMA_ATTR_NON_CONSISTENT,
 	DMA_ATTR_NO_KERNEL_MAPPING,
 	DMA_ATTR_SKIP_CPU_SYNC,
+	DMA_ATTR_FORCE_CONTIGUOUS,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.9.5
