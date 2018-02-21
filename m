From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed, 21 Feb 2018 15:59:11 -0700
Subject: [PATCH 01/14] iommu: Add DOMAIN_ATTR_ENABLE_TTBR1
In-Reply-To: <20180221225924.30737-1-jcrouse@codeaurora.org>
References: <20180221225924.30737-1-jcrouse@codeaurora.org>
Message-ID: <20180221225924.30737-2-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new domain attribute to enable the TTBR1 pagetable for drivers
and devices that support it.  This will enabled using a TTBR1 (otherwise
known as a "global" or "system" pagetable for devices that support a split
pagetable scheme for switching pagetables quickly and safely.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 641aaf0f1b81..e2c49e583d8d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -153,6 +153,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_ENABLE_TTBR1,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.16.1
