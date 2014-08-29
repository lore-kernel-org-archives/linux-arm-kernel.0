From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Aug 2014 16:54:26 +0100
Subject: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a device
 with a set of IDs
In-Reply-To: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409327670-3495-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new function to the iommu_ops structure to allow a
device to be added to a specific IOMMU instance along with a set of
opaque IDs that are used internally by the IOMMU for identifying and
configuring translations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a527922a..3dd1b99c4542 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -114,6 +114,8 @@ struct iommu_ops {
 	int (*domain_has_cap)(struct iommu_domain *domain,
 			      unsigned long cap);
 	int (*add_device)(struct device *dev);
+	int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
+				     void *data);
 	void (*remove_device)(struct device *dev);
 	int (*device_group)(struct device *dev, unsigned int *groupid);
 	int (*domain_get_attr)(struct iommu_domain *domain,
-- 
2.1.0
