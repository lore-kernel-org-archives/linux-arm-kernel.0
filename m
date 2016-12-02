From: sricharan@codeaurora.org (Sricharan R)
Date: Fri,  2 Dec 2016 20:25:06 +0530
Subject: [RESEND PATCH V6 3/6] common: DMA-mapping: add DMA_ATTR_PRIVILEGED
 attribute
In-Reply-To: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
References: <1480690509-13490-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1480690509-13490-4-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

This patch adds the DMA_ATTR_PRIVILEGED attribute to the DMA-mapping
subsystem.

Some advanced peripherals such as remote processors and GPUs perform
accesses to DMA buffers in both privileged "supervisor" and unprivileged
"user" modes.  This attribute is used to indicate to the DMA-mapping
subsystem that the buffer is fully accessible at the elevated privilege
level (and ideally inaccessible or at least read-only at the
lesser-privileged levels).

Cc: linux-doc at vger.kernel.org
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---

[V6] No change

 Documentation/DMA-attributes.txt | 10 ++++++++++
 include/linux/dma-mapping.h      |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 98bf7ac..44c6bc4 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -143,3 +143,13 @@ So, this provides a way for drivers to avoid those error messages on calls
 where allocation failures are not a problem, and shouldn't bother the logs.
 
 NOTE: At the moment DMA_ATTR_NO_WARN is only implemented on PowerPC.
+
+DMA_ATTR_PRIVILEGED
+------------------------------
+
+Some advanced peripherals such as remote processors and GPUs perform
+accesses to DMA buffers in both privileged "supervisor" and unprivileged
+"user" modes.  This attribute is used to indicate to the DMA-mapping
+subsystem that the buffer is fully accessible at the elevated privilege
+level (and ideally inaccessible or at least read-only at the
+lesser-privileged levels).
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6f3e6ca..ee31ea1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -63,6 +63,13 @@
 #define DMA_ATTR_NO_WARN	(1UL << 8)
 
 /*
+ * DMA_ATTR_PRIVILEGED: used to indicate that the buffer is fully
+ * accessible at an elevated privilege level (and ideally inaccessible or
+ * at least read-only@lesser-privileged levels).
+ */
+#define DMA_ATTR_PRIVILEGED		(1UL << 8)
+
+/*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
  * reference a dma_addr_t directly because there may be translation between
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
