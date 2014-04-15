From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 15 Apr 2014 14:58:49 +0530
Subject: [PATCH 1/6] ARM: EXYNOS: Remove duplicate lines in Makefile
In-Reply-To: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1397554134-11827-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Group all files compiled under common config option together.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/Makefile |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index a656dbe3b78c..f6dcc256db56 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -12,20 +12,15 @@ obj-				:=
 
 # Core
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o
+obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o pmu.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
-
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
-obj-$(CONFIG_ARCH_EXYNOS)	+= exynos-smc.o
-obj-$(CONFIG_ARCH_EXYNOS)	+= firmware.o
-
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
-- 
1.7.9.5
