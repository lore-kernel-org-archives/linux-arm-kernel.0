From: s-anna@ti.com (Suman Anna)
Date: Wed, 16 Sep 2015 18:48:22 -0500
Subject: [PATCH 4/4] ARM: OMAP2+: Remove omap_mmu_dev_attr structure
In-Reply-To: <1442447302-5246-1-git-send-email-s-anna@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
Message-ID: <1442447302-5246-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure omap_mmu_dev_attr was used in the hwmod data for
supplying device-specific data through the .dev_attr field and
used in constructing the platform data for legacy device creation.
The legacy device creation of OMAP IOMMU devices has been cleaned
up, and this structure is no longer needed, so remove it.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/platform_data/iommu-omap.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 54a0a9582fad..0496d171700a 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -29,15 +29,6 @@ struct omap_iommu_arch_data {
 	struct omap_iommu *iommu_dev;
 };
 
-/**
- * struct omap_mmu_dev_attr - OMAP mmu device attributes for omap_hwmod
- * @nr_tlb_entries:	number of entries supported by the translation
- *			look-aside buffer (TLB).
- */
-struct omap_mmu_dev_attr {
-	int nr_tlb_entries;
-};
-
 struct iommu_platform_data {
 	const char *name;
 	const char *reset_name;
-- 
2.5.0
