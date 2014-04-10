From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 10 Apr 2014 13:54:54 +0530
Subject: [PATCH 4/6] ARM: EXYNOS: Remove unnecessary inclusion of cpu.h
In-Reply-To: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
References: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1397118296-6846-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos specific macros and declarations have been moved to
mach-exynos. Inclusion of plat/cpu.h is no more necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    1 -
 arch/arm/mach-exynos/exynos.c  |    2 --
 arch/arm/mach-exynos/hotplug.c |    2 --
 arch/arm/mach-exynos/platsmp.c |    2 --
 arch/arm/mach-exynos/pm.c      |    1 -
 arch/arm/mach-exynos/pmu.c     |    2 --
 6 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index c57cae0e8779..3dd385ebf195 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -24,7 +24,6 @@
 #include <asm/unified.h>
 #include <asm/cpuidle.h>
 
-#include <plat/cpu.h>
 #include <plat/pm.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 0ef42b9efd36..63a0ef714c70 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -26,8 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/memory.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "mfc.h"
 #include "regs-pmu.h"
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead530c6f8..884e83cfbfbb 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -19,8 +19,6 @@
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "regs-pmu.h"
 
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 03e5e9f94705..c28cdb1c82cd 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -26,8 +26,6 @@
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "regs-pmu.h"
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 15af0ceb0a66..ca672e24b5cd 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -26,7 +26,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/cpu.h>
 #include <plat/pm-common.h>
 #include <plat/pll.h>
 #include <plat/regs-srom.h>
diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 05c7ce15322a..fb0deda3b3a4 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -13,8 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/bug.h>
 
-#include <plat/cpu.h>
-
 #include "common.h"
 #include "regs-pmu.h"
 
-- 
1.7.9.5
