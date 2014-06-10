From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Jun 2014 12:51:23 +0200
Subject: [PATCH 10/24] PM / Domains: Remove redundant check for CONFIG_PM
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1402397497-26737-11-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PM_GENERIC_DOMAINS depends on CONFIG_PM, thus there are no need
to check explicity for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a2ebc77..0362360 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -67,8 +67,6 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
 	return genpd;
 }
 
-#ifdef CONFIG_PM
-
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
 {
 	if (IS_ERR_OR_NULL(dev->pm_domain))
@@ -282,8 +280,6 @@ int pm_genpd_name_poweron(const char *domain_name)
 	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
 }
 
-#endif /* CONFIG_PM */
-
 #ifdef CONFIG_PM_RUNTIME
 
 static int genpd_start_dev_no_timing(struct generic_pm_domain *genpd,
-- 
1.7.9.5
