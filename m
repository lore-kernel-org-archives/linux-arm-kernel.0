From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 15:52:20 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Move pm_domains driver to drivers/soc/samsung
Message-ID: <1462888341-21963-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos PM domains driver does not have mach-specific dependencies so it
can be safely moved out of arm/mach-exynos to drivers/soc. This in
future will allow re-using it on ARM64 boards.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/Makefile                              | 1 -
 drivers/soc/samsung/Makefile                               | 1 +
 {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c (100%)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 34d29df3e006..838249d4ff5c 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_PM_SLEEP)		+= suspend.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index f64ac4d80564..8acba2bbbd78 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
diff --git a/arch/arm/mach-exynos/pm_domains.c b/drivers/soc/samsung/pm_domains.c
similarity index 100%
rename from arch/arm/mach-exynos/pm_domains.c
rename to drivers/soc/samsung/pm_domains.c
-- 
1.9.1
