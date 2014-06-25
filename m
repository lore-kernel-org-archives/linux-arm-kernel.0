From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 25 Jun 2014 14:12:28 +0530
Subject: [PATCH 1/2] cpufreq: Add support for per-policy driver data
In-Reply-To: <cover.1403684824.git.viresh.kumar@linaro.org>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
Message-ID: <28dc4ae67a7c3c712714abc14619b7c1d4bfb361.1403684824.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers supporting multiple clusters or multiple 'struct cpufreq_policy'
instances may need to keep some per-policy data. If the core doesn't support
them, they might do it in the most unoptimized way: per-cpu data.

This patch adds another field in 'struct cpufreq_policy': driver_data. It isn't
accessed by core and is completely for driver's internal use.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ec4112d..d4b1108 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -112,6 +112,9 @@ struct cpufreq_policy {
 	spinlock_t		transition_lock;
 	wait_queue_head_t	transition_wait;
 	struct task_struct	*transition_task; /* Task which is doing the transition */
+
+	/* For cpufreq driver's internal use */
+	void			*driver_data;
 };
 
 /* Only for ACPI */
-- 
2.0.0.rc2
