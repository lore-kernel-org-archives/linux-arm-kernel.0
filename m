From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 07 Nov 2011 14:45:50 +0900
Subject: [PATCH] arm: exynos: Fix compiler error with THIS_MODULE
Message-ID: <20111107054550.GA1943@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

  CC      arch/arm/mach-exynos/cpuidle.o
arch/arm/mach-exynos/cpuidle.c:36: error: 'THIS_MODULE' undeclared here (not in a function)
arch/arm/mach-exynos/cpuidle.c: In function 'exynos4_enter_idle':
arch/arm/mach-exynos/cpuidle.c:42: error: storage size of 'before' isn't known
arch/arm/mach-exynos/cpuidle.c:42: error: storage size of 'after' isn't known
arch/arm/mach-exynos/cpuidle.c:46: error: implicit declaration of function 'do_gettimeofday'
arch/arm/mach-exynos/cpuidle.c:52: error: 'USEC_PER_SEC' undeclared (first use in this function)
arch/arm/mach-exynos/cpuidle.c:52: error: (Each undeclared identifier is reported only once
arch/arm/mach-exynos/cpuidle.c:52: error: for each function it appears in.)
arch/arm/mach-exynos/cpuidle.c:42: warning: unused variable 'after'
arch/arm/mach-exynos/cpuidle.c:42: warning: unused variable 'before'
make[1]: *** [arch/arm/mach-exynos/cpuidle.o] Error 1

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index bf7e96f..84628a8 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -9,6 +9,7 @@
 */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/cpuidle.h>
 #include <linux/io.h>
