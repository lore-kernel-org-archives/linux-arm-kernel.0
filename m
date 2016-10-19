From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Oct 2016 11:59:10 +0200
Subject: [PATCH 1/5] cpufreq: enable the DT cpufreq driver on the Integrators
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1476871154-32243-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the generic DT and OPP-based cpufreq driver on the
ARM Integrator/AP and Integrator/CP.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
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
