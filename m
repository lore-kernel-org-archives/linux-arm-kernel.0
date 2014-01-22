From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jan 2014 15:21:16 +0100
Subject: [PATCH RESEND] cpufreq: exynos: Fix build error of no type of
 module_init
Message-ID: <1390400476-22951-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing include to fix build error:
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_init? [-Werror=implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: data definition has no type or storage class [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: error: type defaults to ?int? in declaration of ?module_exit? [-Werror=implicit-int]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: parameter names (without types) in function declaration [enabled by default]
drivers/cpufreq/exynos-cpufreq.c:292:1: warning: ?exynos_cpufreq_platdrv_init? defined but not used [-Wunused-function]
cc1: some warnings being treated as errors
make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2

Build error happens on gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
and was introduced by commit d568b6f71df1 (cpufreq: exynos: Convert
exynos-cpufreq to platform driver).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index fcd2914d081a..fa54c2b88dd7 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/cpufreq.h>
 #include <linux/suspend.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 
 #include <plat/cpu.h>
-- 
1.7.9.5
