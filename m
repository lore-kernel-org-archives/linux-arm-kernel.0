From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 18 Aug 2014 17:30:29 +0200
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider API
In-Reply-To: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 37a4806..f3d087f 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -50,7 +49,7 @@ static struct cpufreq_frequency_table kirkwood_freq_table[] = {
 
 static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
 {
-	if (__clk_is_enabled(priv.powersave_clk))
+	if (clk_is_enabled(priv.powersave_clk))
 		return kirkwood_freq_table[1].frequency;
 	return kirkwood_freq_table[0].frequency;
 }
-- 
1.9.3
