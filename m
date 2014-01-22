From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jan 2014 15:18:57 +0100
Subject: [PATCH] ARM: EXYNOS: cpuidle: Fix build error of no type of
 module_init
Message-ID: <1390400337-22850-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing include to fix build error:
arch/arm/mach-exynos/cpuidle.c:256:1: warning: data definition has no type or storage class [enabled by default]
arch/arm/mach-exynos/cpuidle.c:256:1: error: type defaults to ?int? in declaration of ?module_init? [-Werror=implicit-int]
arch/arm/mach-exynos/cpuidle.c:256:1: warning: parameter names (without types) in function declaration [enabled by default]
arch/arm/mach-exynos/cpuidle.c:256:1: warning: data definition has no type or storage class [enabled by default]
arch/arm/mach-exynos/cpuidle.c:256:1: error: type defaults to ?int? in declaration of ?module_exit? [-Werror=implicit-int]
arch/arm/mach-exynos/cpuidle.c:256:1: warning: parameter names (without types) in function declaration [enabled by default]
arch/arm/mach-exynos/cpuidle.c:256:1: warning: ?exynos_cpuidle_driver_init? defined but not used [-Wunused-function]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-exynos/cpuidle.o] Error 1

Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
and was introduced by commit 35baa3369d1c (ARM: EXYNOS: convert cpuidle
driver to be a platform driver).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index f57cb91f02aa..53dc1e705b2f 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/export.h>
 #include <linux/time.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
-- 
1.7.9.5
