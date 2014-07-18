From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 18 Jul 2014 15:09:53 +0100
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
In-Reply-To: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
References: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1405692594-19352-2-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ?rjan Eide <orjan.eide@arm.com>

These functions are indended for use by drivers and should be available
also when the driver is built as a module.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
---
 drivers/devfreq/devfreq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 9f90369..30b538d8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1119,6 +1119,7 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 
 	return opp;
 }
+EXPORT_SYMBOL(devfreq_recommended_opp);
 
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq notified
@@ -1142,6 +1143,7 @@ int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
 
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_register_opp_notifier);
 
 /**
  * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
@@ -1168,6 +1170,7 @@ int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
 
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
 
 static void devm_devfreq_opp_release(struct device *dev, void *res)
 {
-- 
1.7.10.4
