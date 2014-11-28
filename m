From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 28 Nov 2014 09:30:02 +0100
Subject: [PATCH V3 2/3] ARM: shmobile: Convert to genpd flags for PM clocks
 for r8a7779
In-Reply-To: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
References: <1417163403-7070-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1417163403-7070-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
convert to use genpd's flag field and set it to GENPD_PM_CLK.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
        Convert to renamed define.

Changes in v2:
        None.

---
 arch/arm/mach-shmobile/pm-r8a7779.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 82fe3d7..3a09ae7 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -83,9 +83,8 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
 
+	genpd->flags = GENPD_PM_CLK;
 	pm_genpd_init(genpd, NULL, false);
-	genpd->dev_ops.stop = pm_clk_suspend;
-	genpd->dev_ops.start = pm_clk_resume;
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
-- 
1.9.1
