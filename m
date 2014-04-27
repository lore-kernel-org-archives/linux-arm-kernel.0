From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 27 Apr 2014 14:28:50 +0100
Subject: [PATCH 1/5] pm: domains: quieten down generic pm domains
In-Reply-To: <20140427132312.GC26756@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
Message-ID: <E1WeP8U-0000Ug-RQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index bfb8955c406c..ea91ea0e137b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -42,7 +42,7 @@
 	struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;			\
 	if (!__retval && __elapsed > __td->field) {				\
 		__td->field = __elapsed;					\
-		dev_warn(dev, name " latency exceeded, new value %lld ns\n",	\
+		dev_dbg(dev, name " latency exceeded, new value %lld ns\n",	\
 			__elapsed);						\
 		genpd->max_off_time_changed = true;				\
 		__td->constraint_changed = true;				\
@@ -242,7 +242,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 			genpd->max_off_time_changed = true;
 			genpd_recalc_cpu_exit_latency(genpd);
 			if (genpd->name)
-				pr_warning("%s: Power-on latency exceeded, "
+				pr_debug("%s: Power-on latency exceeded, "
 					"new value %lld ns\n", genpd->name,
 					elapsed_ns);
 		}
@@ -566,7 +566,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 			genpd->power_off_latency_ns = elapsed_ns;
 			genpd->max_off_time_changed = true;
 			if (genpd->name)
-				pr_warning("%s: Power-off latency exceeded, "
+				pr_debug("%s: Power-off latency exceeded, "
 					"new value %lld ns\n", genpd->name,
 					elapsed_ns);
 		}
-- 
1.8.3.1
