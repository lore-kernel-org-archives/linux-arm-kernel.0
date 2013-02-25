From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Feb 2013 17:30:18 +0100
Subject: [PATCH 3/4] ARM: bugfix i.MX cpufreq clock id
In-Reply-To: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
References: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1361809819-24383-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock id changed some time ago with the new clock framework. The
cpufreq driver still uses "cpu_clk" while all devices register their cpu
clock devices as "cpu".

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpufreq.c b/arch/arm/mach-imx/cpufreq.c
index d8c75c3..9dae54e 100644
--- a/arch/arm/mach-imx/cpufreq.c
+++ b/arch/arm/mach-imx/cpufreq.c
@@ -111,7 +111,7 @@ static int mxc_cpufreq_init(struct cpufreq_policy *policy)
 	if (!get_cpu_op)
 		return -EINVAL;
 
-	cpu_clk = clk_get(NULL, "cpu_clk");
+	cpu_clk = clk_get(NULL, "cpu");
 	if (IS_ERR(cpu_clk)) {
 		printk(KERN_ERR "%s: failed to get cpu clock\n", __func__);
 		return PTR_ERR(cpu_clk);
-- 
1.8.1.2
