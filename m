From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 18 May 2018 12:31:25 +0200
Subject: [PATCH 4/9] PM / Domains: Drop unused parameter in
 genpd_allocate_dev_data()
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1526639490-12167-5-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The in-parameter struct generic_pm_domain *genpd to
genpd_allocate_dev_data() is unused, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f08fa15..050ce07 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1316,7 +1316,6 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
-					struct generic_pm_domain *genpd,
 					struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -1385,7 +1384,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
+	gpd_data = genpd_alloc_dev_data(dev, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-- 
2.7.4
