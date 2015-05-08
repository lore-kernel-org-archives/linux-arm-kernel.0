From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 May 2015 14:57:30 -0500
Subject: [PATCH 2/2] cpufreq: dt: allow driver to boot automatically
In-Reply-To: <1431115050-23693-1-git-send-email-balbi@ti.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
Message-ID: <1431115050-23693-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by adding the missing MODULE_ALIAS(), cpufreq-dt
can be autoloaded by udev/systemd.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cpufreq/cpufreq-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db54b7e..528a82bf5038 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -416,6 +416,7 @@ static struct platform_driver dt_cpufreq_platdrv = {
 };
 module_platform_driver(dt_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:cpufreq-dt");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
 MODULE_DESCRIPTION("Generic cpufreq driver");
-- 
2.4.0.rc3
