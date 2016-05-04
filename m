From: eric.auger@linaro.org (Eric Auger)
Date: Wed,  4 May 2016 11:40:02 +0000
Subject: [PATCH v9 3/8] iommu: introduce an msi cookie
In-Reply-To: <1462362007-2753-1-git-send-email-eric.auger@linaro.org>
References: <1462362007-2753-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1462362007-2753-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This opaque pointer will enable to store information about msi
iommu mappings.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v7 -> v8:
remove spinlock and RB tree

v5 -> v6:
- initialize reserved_binding_list
- use a spinlock instead of a mutex
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 021b659..09fba4c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -90,6 +90,7 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
+	void *msi_cookie;
 };
 
 enum iommu_cap {
-- 
1.9.1
