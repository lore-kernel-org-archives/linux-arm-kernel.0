From: pullip.cho@samsung.com (Cho KyongHo)
Date: Mon, 07 Oct 2013 10:52:30 +0900
Subject: [PATCH v10 01/20] iommu/exynos: do not include removed header
Message-ID: <20131007105230.dd412c8aa151c35d9b3aea86@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from
exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without
removing remaining use of it from exynos-iommu driver, thus causing a
compilation error.

This patch fixes the error by removing respective include line
from exynos-iommu.c.

CC: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0740189..4876d35 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -12,6 +12,7 @@
 #define DEBUG
 #endif
 
+#include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -29,8 +30,6 @@
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
 
-#include <mach/sysmmu.h>
-
 /* We does not consider super section mapping (16MB) */
 #define SECT_ORDER 20
 #define LPAGE_ORDER 16
-- 
1.7.2.5
