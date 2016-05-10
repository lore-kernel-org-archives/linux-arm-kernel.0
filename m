From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 16:31:26 +0200
Subject: [PATCH] soc: samsung: pm_domains: Enable COMPILE_TEST for build
 coverage
Message-ID: <1462890686-8843-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a platform selectable symbol EXYNOS_PM_DOMAINS which can be
also toggled on by COMPILE_TEST for some build coverage.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 drivers/soc/samsung/Kconfig  | 4 ++++
 drivers/soc/samsung/Makefile | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index e65aa7d11b20..58b334f5f1d6 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -19,6 +19,7 @@ menuconfig ARCH_EXYNOS
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
+	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index d7fc123006a3..245533907d1b 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -10,4 +10,8 @@ config EXYNOS_PMU
 	bool "Exynos PMU controller driver" if COMPILE_TEST
 	depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
 
+config EXYNOS_PM_DOMAINS
+	bool "Exynos PM domains" if COMPILE_TEST
+	depends on PM_GENERIC_DOMAINS || COMPILE_TEST
+
 endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 8acba2bbbd78..e60f173c503a 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,3 +1,3 @@
-obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
+obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
-- 
1.9.1
