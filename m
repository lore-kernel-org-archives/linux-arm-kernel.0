From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Fri,  8 Jul 2016 19:09:17 -0700
Subject: [PATCH v2 4/6] common: DMA-mapping: add
 DMA_ATTR_PRIVILEGED_EXECUTABLE attribute
In-Reply-To: <20160709020919.6760-1-mitchelh@codeaurora.org>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
Message-ID: <20160709020919.6760-5-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DMA_ATTR_PRIVILEGED_EXECUTABLE attribute to the
DMA-mapping subsystem.

Some architectures require that writable mappings also be non-executable at
lesser-privileged levels of execution.  This attribute is used to indicate
to the DMA-mapping subsystem that it should do whatever is necessary to
ensure that the buffer is executable at an elevated privilege level (by
making it read-only at the lesser-privileged levels, for example).

Cc: linux-doc at vger.kernel.org
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 Documentation/DMA-attributes.txt | 9 +++++++++
 include/linux/dma-attrs.h        | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index e8cf9cf873b3..6a22d4307008 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -126,3 +126,12 @@ means that we won't try quite as hard to get them.
 
 NOTE: At the moment DMA_ATTR_ALLOC_SINGLE_PAGES is only implemented on ARM,
 though ARM64 patches will likely be posted soon.
+
+DMA_ATTR_PRIVILEGED_EXECUTABLE
+------------------------------
+
+Some architectures require that writable mappings also be non-executable at
+lesser-privileged levels of execution.  This attribute is used to indicate
+to the DMA-mapping subsystem that it should do whatever is necessary to
+ensure that the buffer is executable at an elevated privilege level (by
+making it read-only at the lesser-privileged levels, for example).
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 5246239a4953..8cf4dff6185b 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -19,6 +19,7 @@ enum dma_attr {
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_FORCE_CONTIGUOUS,
 	DMA_ATTR_ALLOC_SINGLE_PAGES,
+	DMA_ATTR_PRIVILEGED_EXECUTABLE,
 	DMA_ATTR_MAX,
 };
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
