From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:20 +0200
Subject: [PATCH 07/24] ARM: shmobile: Drop dev_irq_safe from r8a7779 genpd
 config
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-8-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev_irq_safe configuration is redundant, genpd don't have any
special treatmeant for handling it. Let's remove it.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-shmobile/pm-r8a7779.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index d6fe189..8cd2423 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -74,7 +74,6 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 	genpd->dev_ops.stop = pm_clk_suspend;
 	genpd->dev_ops.start = pm_clk_resume;
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
-	genpd->dev_irq_safe = true;
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
 
-- 
1.7.9.5
