From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Nov 2014 16:34:48 +0100
Subject: [PATCH v4 1/9] PM / Domains: Change prototype for the ->attach_dev()
 callback
In-Reply-To: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1415028896-9005-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Convert the prototype to return and int. This is just an initial step,
needed to support error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Kevin Hilman <khilman@linaro.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Prerequisite

Ulf wrote:

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
index 73e938b7e9374c68..d44f071988a861ff 100644
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
