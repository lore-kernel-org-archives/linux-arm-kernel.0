From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 26 Oct 2015 18:25:37 +0530
Subject: [PATCH v3 1/7] ARM: EXYNOS: removing redundant code from regs-pmu.h
In-Reply-To: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1445864143-25695-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 6ec4f8d0d91f ("ARM: EXYNOS: add generic function to calculate
cpu number") introduced exynos_pmu_cpunr to be used by multi-cluster SoC's
e.g Exynos5420, but it's no more used in the codebase and hence removing
this part of code.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pmu.c      | 1 +
 arch/arm/mach-exynos/regs-pmu.h | 9 ---------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index de68938..d936ffa 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -17,6 +17,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 
+#include <asm/cputype.h>
 
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index fba9068..5e4f4c2 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -484,15 +484,6 @@
 
 #define EXYNOS5420_SWRESET_KFC_SEL				0x3
 
-#include <asm/cputype.h>
-#define MAX_CPUS_IN_CLUSTER	4
-
-static inline unsigned int exynos_pmu_cpunr(unsigned int mpidr)
-{
-	return ((MPIDR_AFFINITY_LEVEL(mpidr, 1) * MAX_CPUS_IN_CLUSTER)
-		 + MPIDR_AFFINITY_LEVEL(mpidr, 0));
-}
-
 /* Only for EXYNOS5420 */
 #define EXYNOS5420_ISP_ARM_OPTION				0x2488
 #define EXYNOS5420_L2RSTDISABLE_VALUE				BIT(3)
-- 
2.4.5
