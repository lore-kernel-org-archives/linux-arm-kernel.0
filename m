From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 01 Feb 2013 15:49:03 +0100
Subject: [PATCH] ARM: Exynos: enable ARM_HAS_SG_CHAIN
Message-ID: <1359730143-462-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos DRM driver needs support for scatter-list chaining and all
drivers available on Samsung platform, which use scatter-lists are
already aware of chaining api, so lets enable global support for it.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cb06d7a..939b0d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -836,6 +836,7 @@ config ARCH_EXYNOS
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_SPARSEMEM_ENABLE
+	select ARM_HAS_SG_CHAIN
 	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
-- 
1.7.9.5
