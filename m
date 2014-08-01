From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  1 Aug 2014 14:45:13 +0200
Subject: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
In-Reply-To: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

This allows IOMMU drivers to compile even if IOMMU_API is not selected
and helps improve compile coverage.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0b5222c7ff97..415608ea2999 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -242,6 +242,12 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 
 #else /* CONFIG_IOMMU_API */
 
+static inline int bus_set_iommu(struct bus_type *bus,
+				const struct iommu_ops *ops)
+{
+	return -ENOSYS;
+}
+
 static inline bool iommu_present(struct bus_type *bus)
 {
 	return false;
-- 
2.0.3
