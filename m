From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Tue,  1 Oct 2013 10:30:24 -0500
Subject: [PATCH] cpufreq: highbank-cpufreq: Enable Midway/ECX-2000
Message-ID: <1380641424-5666-1-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calxeda's new ECX-2000 part uses the same cpufreq interface as highbank,
so add it to the driver's compatibility list.

This is a minor change that can safely be applied to the 3.10 and 3.11
stable trees.

Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
---
 drivers/cpufreq/highbank-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index 794123f..bf8902a 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -66,7 +66,8 @@ static int hb_cpufreq_driver_init(void)
 	struct device_node *np;
 	int ret;
 
-	if (!of_machine_is_compatible("calxeda,highbank"))
+	if ((!of_machine_is_compatible("calxeda,highbank")) &&
+		(!of_machine_is_compatible("calxeda,ecx-2000")))
 		return -ENODEV;
 
 	cpu_dev = get_cpu_device(0);
-- 
1.8.1.2
