From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 19 Sep 2014 20:27:34 +0200
Subject: [PATCH v5 01/11] PM / Domains: Add a detach callback to the struct
 dev_pm_domain
In-Reply-To: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The intent of this callback is to simplify detachment of devices from
their PM domains. Further patches will show the benefit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 72c0fe0..ef4e16f 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -619,6 +619,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
  */
 struct dev_pm_domain {
 	struct dev_pm_ops	ops;
+	void (*detach)(struct device *, bool);
 };
 
 /*
-- 
1.9.1
