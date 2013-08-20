From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 10:30:16 +0100
Subject: [PATCH v4 14/19] cpufreq: spear-cpufreq: remove device tree parsing
 for cpu nodes
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376991021-12160-15-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Deepak Sikri <sikrid@qti.qualcomm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/spear-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index c3efa7f..19e364fa 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -223,7 +223,7 @@ static int spear_cpufreq_driver_init(void)
 	const __be32 *val;
 	int cnt, i, ret;
 
-	np = of_find_node_by_path("/cpus/cpu at 0");
+	np = of_cpu_device_node_get(0);
 	if (!np) {
 		pr_err("No cpu node found");
 		return -ENODEV;
-- 
1.8.1.2
