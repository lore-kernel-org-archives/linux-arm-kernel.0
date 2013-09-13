From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 18:29:24 +0530
Subject: [PATCH 018/228] cpufreq: davinci: use
 cpufreq_table_validate_and_show()
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <e23d2b93ec6623c2c2774dbf3ecd73beb507cda4.1379063063.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index d049937..ba03e6f 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -138,15 +138,13 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = davinci_getspeed(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result) {
-		pr_err("%s: cpufreq_frequency_table_cpuinfo() failed",
+		pr_err("%s: cpufreq_table_validate_and_show() failed",
 				__func__);
 		return result;
 	}
 
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
-
 	/*
 	 * Time measurement across the target() function yields ~1500-1800us
 	 * time taken with no drivers on notification list.
-- 
1.7.12.rc2.18.g61b472e
