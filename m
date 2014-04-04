From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:48:02 +0200
Subject: [PATCH 16/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle directory
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/Makefile                      |    1 -
 drivers/cpuidle/Kconfig.arm                        |    7 +++++++
 drivers/cpuidle/Makefile                           |    1 +
 .../cpuidle.c => drivers/cpuidle/cpuidle-exynos.c  |    0
 4 files changed, 8 insertions(+), 1 deletion(-)
 rename arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/cpuidle-exynos.c (100%)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 8930b66..2e331f3 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
 
 obj-$(CONFIG_S5P_PM)		+= pm.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
 
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index d988948..92f0c12 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -44,3 +44,10 @@ config ARM_AT91_CPUIDLE
 	depends on ARCH_AT91
 	help
 	  Select this to enable cpuidle for AT91 processors
+
+config ARM_EXYNOS_CPUIDLE
+	bool "Cpu Idle Driver for the Exynos processors"
+	default y
+	depends on ARCH_EXYNOS
+	help
+	  Select this to enable cpuidle for Exynos processors
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b..0d1540a 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
+obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
 
 ###############################################################################
 # POWERPC drivers
diff --git a/arch/arm/mach-exynos/cpuidle.c b/drivers/cpuidle/cpuidle-exynos.c
similarity index 100%
rename from arch/arm/mach-exynos/cpuidle.c
rename to drivers/cpuidle/cpuidle-exynos.c
-- 
1.7.9.5
