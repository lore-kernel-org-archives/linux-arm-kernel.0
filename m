From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 06 Aug 2015 15:41:54 +0200
Subject: [PATCH v4 6/6] cpufreq: remove no longer needed CPU_FREQ_BOOST_SW
 config option
In-Reply-To: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1438868514-8814-7-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove no longer needed CPU_FREQ_BOOST_SW config option.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig      | 4 ----
 drivers/cpufreq/freq_table.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 659879a..aacc0ef 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -21,10 +21,6 @@ if CPU_FREQ
 config CPU_FREQ_GOV_COMMON
 	bool
 
-config CPU_FREQ_BOOST_SW
-	bool
-	depends on THERMAL
-
 config CPU_FREQ_STAT
 	tristate "CPU frequency translation statistics"
 	default y
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 5a00a09..2c6a325 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -293,9 +293,6 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_boost_freqs);
 
 struct freq_attr *cpufreq_generic_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
-#ifdef CONFIG_CPU_FREQ_BOOST_SW
-	&cpufreq_freq_attr_scaling_boost_freqs,
-#endif
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
-- 
1.9.1
