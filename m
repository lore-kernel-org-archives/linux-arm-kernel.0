From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 30 Oct 2014 13:02:49 +0100
Subject: [PATCH] PM / Domains: Change prototype for the ->attach_dev() callback
Message-ID: <1414670569-3002-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the prototype to return and int. This is just an initial step,
needed to support error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

This patch is intended as fix for 3.18 rc[n]. Why?

There are other SOC specific patches around that adds genpd support and which
implements the ->attach_dev() callback. To prevent having an "atomic" patch
during the next release cycle, let's change the prototype now instead.

Further patches will add the actual error handling in genpd and these can then
be reviewed and tested thoroughly.

---
 include/linux/pm_domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 73e938b..d44f071 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -72,7 +72,7 @@ struct generic_pm_domain {
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
 	struct gpd_cpuidle_data *cpuidle_data;
-	void (*attach_dev)(struct device *dev);
+	int (*attach_dev)(struct device *dev);
 	void (*detach_dev)(struct device *dev);
 };
 
-- 
1.9.1
