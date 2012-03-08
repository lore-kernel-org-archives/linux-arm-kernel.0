From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  8 Mar 2012 20:36:44 +0100
Subject: [PATCH] ARM: davinci: cpufreq: fix compiler warning
Message-ID: <1331235404-15565-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:
	arch/arm/mach-davinci/cpufreq.c: In function davinci_target:
	arch/arm/mach-davinci/cpufreq.c:98: warning: passing argument 2 of dev_printk from incompatible pointer type

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-davinci/cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index 5bba707..031048f 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -95,7 +95,7 @@ static int davinci_target(struct cpufreq_policy *policy,
 	if (freqs.old == freqs.new)
 		return ret;
 
-	dev_dbg(&cpufreq.dev, "transition: %u --> %u\n", freqs.old, freqs.new);
+	dev_dbg(cpufreq.dev, "transition: %u --> %u\n", freqs.old, freqs.new);
 
 	ret = cpufreq_frequency_table_target(policy, pdata->freq_table,
 						freqs.new, relation, &idx);
-- 
1.7.9.1
