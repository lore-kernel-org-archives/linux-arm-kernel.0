From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  4 Aug 2014 14:48:03 +0200
Subject: [PATCH] cpufreq: cpu0: Do not print error message when deferring
Message-ID: <1407156483-15730-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-EPROBE_DEFER is no real error. We are just waiting unti the necessary
components are ready. The driver core infrastructure will also print an
appropriate info message.

This patch changes the error message to a debug message.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/cpufreq/cpufreq-cpu0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index ee1ae303a07c..26405d5c7a1f 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -137,7 +137,7 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 		 * not yet registered, we should try defering probe.
 		 */
 		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
-			dev_err(cpu_dev, "cpu0 regulator not ready, retry\n");
+			dev_dbg(cpu_dev, "cpu0 regulator not ready, retry\n");
 			ret = -EPROBE_DEFER;
 			goto out_put_node;
 		}
-- 
2.0.1
