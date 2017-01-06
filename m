From: sricharan@codeaurora.org (Sricharan R)
Date: Fri,  6 Jan 2017 18:58:08 +0530
Subject: [PATCH V9 1/9] iommu: add IOMMU_PRIV attribute
In-Reply-To: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
References: <1483709296-32761-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1483709296-32761-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

Add the IOMMU_PRIV attribute, which is used to indicate privileged
mappings.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/iommu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ff5111..69e2417 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,6 +31,13 @@
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
+/*
+ * This is to make the IOMMU API setup privileged
+ * mapppings accessible by the master only@higher
+ * privileged execution level and inaccessible at
+ * less privileged levels.
+ */
+#define IOMMU_PRIV	(1 << 5)
 
 struct iommu_ops;
 struct iommu_group;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
