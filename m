From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 28 Apr 2016 08:15:18 +0000
Subject: [PATCH v8 3/8] iommu: introduce an msi cookie
In-Reply-To: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
References: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461831323-5480-4-git-send-email-eric.auger@linaro.org>
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
index ea5d288..cb8d30a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -91,6 +91,7 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
+	void *msi_cookie;
 };
 
 enum iommu_cap {
-- 
1.9.1
