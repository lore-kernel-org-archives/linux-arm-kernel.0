From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 17 Sep 2014 13:16:08 -0700
Subject: [PATCH 1/2] iommu: add IOMMU_PRIV flag for access-protected mappings
In-Reply-To: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
References: <1410984969-2340-1-git-send-email-mitchelh@codeaurora.org>
Message-ID: <1410984969-2340-2-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some IOMMUs support access-protected mappings. Add a mapping flag to
indicate that the mapping should be created with access protection
configured.

Cc: Shubhraprakash Das <sadas@codeaurora.org>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a52792..44101c9332 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -28,6 +28,7 @@
 #define IOMMU_WRITE	(1 << 1)
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_EXEC	(1 << 3)
+#define IOMMU_PRIV	(1 << 4)
 
 struct iommu_ops;
 struct iommu_group;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
