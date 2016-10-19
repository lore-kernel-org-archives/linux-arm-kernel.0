From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 19 Oct 2016 15:33:44 -0500
Subject: [PATCH v2 1/4] PM / Domains: Add generic data pointer to genpd data
 struct
In-Reply-To: <20161019203347.17893-1-d-gerlach@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
Message-ID: <20161019203347.17893-2-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a void *data pointer to struct generic_pm_domain_data. Because this
exists for each device associated with a genpd it will allow us to
assign per-device data if needed on a platform for control of that
specific device.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a09fe5c009c8..9c0a897fe605 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -105,6 +105,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	void *data;
 };
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
-- 
2.9.3
