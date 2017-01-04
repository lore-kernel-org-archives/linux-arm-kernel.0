From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 4 Jan 2017 14:55:33 -0600
Subject: [PATCH v3 1/4] PM / Domains: Add generic data pointer to genpd data
 struct
In-Reply-To: <20170104205536.15963-1-d-gerlach@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
Message-ID: <20170104205536.15963-2-d-gerlach@ti.com>
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
index 81ece61075df..73c9dba5cfcc 100644
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
