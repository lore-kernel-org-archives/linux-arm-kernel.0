From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Jul 2017 07:47:02 +0200
Subject: [PATCH] iommu/exynos: Replace non-existing big-endian Kconfig option
Message-ID: <1500270422-4805-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wrong Kconfig option was used when adding warning for untested
big-endian capabilities. There is no CONFIG_BIG_ENDIAN option.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iommu/exynos-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 2395478dde75..b7aebaf28b82 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -54,7 +54,7 @@ typedef u32 sysmmu_pte_t;
 #define lv2ent_small(pent) ((*(pent) & 2) == 2)
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
-#ifdef CONFIG_BIG_ENDIAN
+#ifdef CONFIG_CPU_BIG_ENDIAN
 #warning "revisit driver if we can enable big-endian ptes"
 #endif
 
-- 
2.7.4
