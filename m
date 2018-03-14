From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 Mar 2018 17:58:13 +0100
Subject: [PATCH v6 03/25] PM / Domains: Add generic data pointer to
 genpd_power_state struct
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1521046715-30683-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lina Iyer <lina.iyer@linaro.org>

Let's add a data pointer to the genpd_power_state struct, to allow
platforms to store per state specific data.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 04dbef9..55ad34d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -44,6 +44,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
-- 
2.7.4
