From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 7 Mar 2017 04:22:30 -0600
Subject: [PATCH v4 1/5] PM / Domains: Add generic data pointer to genpd data
 struct
In-Reply-To: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1488882154-21485-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a void *data pointer to struct generic_pm_domain_data. Because this
exists for each device associated with a genpd it will allow us to
assign per-device data if needed on a platform for control of that
specific device.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5bd6f9..b213d22daefd 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -117,6 +117,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	void *data;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.11.0
