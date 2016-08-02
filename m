From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:15:32 +0000
Subject: [PATCH v12 3/8] iommu: introduce an msi cookie
In-Reply-To: <1470158137-6931-1-git-send-email-eric.auger@redhat.com>
References: <1470158137-6931-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470158137-6931-4-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This opaque pointer will enable to store information about msi
iommu mappings.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

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
index 1b553ee..f7a5d13 100644
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
