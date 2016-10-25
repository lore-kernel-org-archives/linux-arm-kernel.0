From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Oct 2016 09:21:24 +0200
Subject: [PATCH 1/2] cpufreq: enable the DT cpufreq driver on the Integrators
Message-ID: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the generic DT and OPP-based cpufreq driver on the
ARM Integrator/AP and Integrator/CP.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 71267626456b..142a6f615e52 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -26,6 +26,9 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
 
+	{ .compatible = "arm,integrator-ap", },
+	{ .compatible = "arm,integrator-cp", },
+
 	{ .compatible = "hisilicon,hi6220", },
 
 	{ .compatible = "fsl,imx27", },
-- 
2.7.4
