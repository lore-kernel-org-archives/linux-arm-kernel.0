From: dacohen@gmail.com (David Cohen)
Date: Sat, 12 Feb 2011 13:09:47 +0200
Subject: [PATCH] OMAP: IOMMU: add missing function declaration
Message-ID: <1297508987-9193-1-git-send-email-dacohen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Function declaration 'iopgtable_lookup_entry' is missing from header
file.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 9e8c104..5a2475f 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -163,6 +163,8 @@ extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
 extern void flush_iotlb_all(struct iommu *obj);
 
 extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
+extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd,
+				   u32 **ppte);
 extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
-- 
1.7.1
