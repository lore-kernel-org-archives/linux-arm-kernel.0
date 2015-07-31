From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 31 Jul 2015 20:49:17 +0200
Subject: [PATCH v3 5/5] cpufreq: remove no longer needed CPU_FREQ_BOOST_SW
 config option
In-Reply-To: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1438368557-2352-6-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove no longer needed CPU_FREQ_BOOST_SW config option.

As a result scaling_boost_freqs sysfs attribute is available
when cpufreq-dt driver is used and boost support is enabled.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/Kconfig      | 4 ----
 drivers/cpufreq/freq_table.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index bf6d596..de00a52 100644
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
index a8f1daf..4c5de5b 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -293,9 +293,7 @@ EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_boost_freqs);
 
 struct freq_attr *cpufreq_generic_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
-#ifdef CONFIG_CPU_FREQ_BOOST_SW
 	&cpufreq_freq_attr_scaling_boost_freqs,
-#endif
 	NULL,
 };
 EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
-- 
1.9.1
