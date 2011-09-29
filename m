From: afzal@ti.com (Afzal Mohammed)
Date: Thu, 29 Sep 2011 12:14:17 +0530
Subject: [PATCH] ARM: OMAP2+: dmtimer: Fix warning
Message-ID: <1317278657-12414-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix,

arch/arm/mach-omap2/timer.c: In function 'omap_timer_init':
arch/arm/mach-omap2/timer.c:482: warning: assignment from incompatible pointer type

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Fix on tony/master

 arch/arm/mach-omap2/timer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1140e98..e49fc7b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -434,7 +434,7 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	int ret = 0;
 	char *name = "omap_timer";
 	struct dmtimer_platform_data *pdata;
-	struct omap_device *od;
+	struct platform_device *pdev;
 	struct omap_timer_capability_dev_attr *timer_dev_attr;
 	struct powerdomain *pwrdm;
 
@@ -476,12 +476,12 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 #ifdef CONFIG_PM
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 #endif
-	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+	pdev = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
 			omap2_dmtimer_latency,
 			ARRAY_SIZE(omap2_dmtimer_latency),
 			0);
 
-	if (IS_ERR(od)) {
+	if (IS_ERR(pdev)) {
 		pr_err("%s: Can't build omap_device for %s: %s.\n",
 			__func__, name, oh->name);
 		ret = -EINVAL;
-- 
1.6.2.4
