From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri,  3 Mar 2017 12:41:33 -0800
Subject: [PATCH V5 7/9] PM / Domains: allow platform specific data for genpd
 states
In-Reply-To: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1488573695-106680-8-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow platforms to save a state specific parameter for the genpd state.
The parameter would be used to identify the state when the platform is
called to power off the domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 5339ed5..183995a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -42,6 +42,7 @@ struct genpd_power_state {
 	s64 power_on_latency_ns;
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
+	u32 param;
 };
 
 struct genpd_lock_ops;
-- 
2.7.4
