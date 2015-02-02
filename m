From: edubezval@gmail.com (Eduardo Valentin)
Date: Mon,  2 Feb 2015 16:58:05 -0400
Subject: [PATCH 02/14] cpufreq: exynos4210: iounmap in error path
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Message-ID: <1422910697-5920-3-git-send-email-edubezval@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When error occurs, allow systems to release iomapped area.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4210-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index dba48f0..8a25dce 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -180,6 +180,7 @@ err_mout_mpll:
 err_moutcore:
 	clk_put(cpu_clk);
 
+	iounmap(info->cmu_regs);
 	of_node_put(np);
 	pr_debug("%s: failed initialization\n", __func__);
 
-- 
2.1.3
