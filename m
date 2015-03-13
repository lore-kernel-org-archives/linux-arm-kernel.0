From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 16:43:49 +0100
Subject: [PATCH 9/9] Revert "PM / Domains: Power on the PM domain right after
 attach completes"
In-Reply-To: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1426261429-31883-10-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the invent of dev_pm_domain_get|put() API and related code in the
generic PM domain, we can now safely revert this commit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7314459..e89eb74 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2220,7 +2220,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
-	pm_genpd_poweron(pd);
 
 	return 0;
 }
-- 
1.9.1
