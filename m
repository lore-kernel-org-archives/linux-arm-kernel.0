From: lina.iyer@linaro.org (Lina Iyer)
Date: Wed,  5 Oct 2016 14:31:53 -0600
Subject: [PATCH 2/8] PM / Domain: Add residency property to genpd states
In-Reply-To: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1475699519-109623-3-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Residency of a domain's idle state indicates that the minimum idle time
for the domain's idle state to be beneficial for power. Add the
parameter to the state node. Future patches, will use the residency
value in the genpd governor to determine if it is worth while to enter
an idle state.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bd1ffb9..c113713 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -38,6 +38,7 @@ struct gpd_dev_ops {
 struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
+	s64 residency_ns;
 };
 
 struct generic_pm_domain {
-- 
2.7.4
