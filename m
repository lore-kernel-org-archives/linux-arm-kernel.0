From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 12:30:13 +0100
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Message-ID: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the use of 0 instead of NULL to clk_get() call. This stops the
following warning:

drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pm at vger.kernel.org
Cc: linux-kernel at lists.codethink.co.uk
---
 drivers/cpufreq/mvebu-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index e920889..ed915ee 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -70,7 +70,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			continue;
 		}
 
-		clk = clk_get(cpu_dev, 0);
+		clk = clk_get(cpu_dev, NULL);
 		if (IS_ERR(clk)) {
 			pr_err("Cannot get clock for CPU %d\n", cpu);
 			return PTR_ERR(clk);
-- 
2.8.1
