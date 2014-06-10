From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:21 +0200
Subject: [PATCH 08/24] ARM: shmobile: Drop dev_irq_safe from R-mobile genpd
 config
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev_irq_safe configuration is redundant, genpd don't have any
special treatmeant for handling it. Let's remove it.

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-shmobile/pm-rmobile.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index f710235..42b96da 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -111,7 +111,6 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.stop		= pm_clk_suspend;
 	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
-	genpd->dev_irq_safe		= true;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
 	__rmobile_pd_power_up(rmobile_pd, false);
-- 
1.7.9.5
