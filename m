From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 3 Jun 2015 17:18:18 -0400
Subject: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
In-Reply-To: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
and also contains modular function calls so it should explicitly include
module.h to avoid compile breakage during pending header shuffles.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ patch will be appended to the implicit include fixup series, see:
  https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker at windriver.com
  for the original series posting.]

 drivers/cpufreq/exynos-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb20f7e..4c157302365f 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -10,6 +10,7 @@
 */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-- 
2.2.1
