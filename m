From: ceh@ti.com (Hernandez, Carlos)
Date: Tue, 12 Aug 2014 13:49:16 +0000
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
In-Reply-To: <1405692594-19352-2-git-send-email-punit.agrawal@arm.com>
References: <1405692594-19352-1-git-send-email-punit.agrawal@arm.com>
 <1405692594-19352-2-git-send-email-punit.agrawal@arm.com>
Message-ID: <32B5D12402BE454796026F6AC58AA86E32F2EFD6@DLEE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-By: Carlos Hernandez <ceh@ti.com>

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of Punit Agrawal
Sent: Friday, July 18, 2014 10:10 AM
To: linux-pm at vger.kernel.org; linux-samsung-soc at vger.kernel.org
Cc: orjan.eide at arm.com; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; MyungJoo Ham; Kyungmin Park
Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drivers

From: ?rjan Eide <orjan.eide@arm.com>

These functions are indended for use by drivers and should be available also when the driver is built as a module.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: ?rjan Eide <orjan.eide@arm.com>
---
 drivers/devfreq/devfreq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c index 9f90369..30b538d8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1119,6 +1119,7 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 
 	return opp;
 }
+EXPORT_SYMBOL(devfreq_recommended_opp);
 
 /**
  * devfreq_register_opp_notifier() - Helper function to get devfreq notified @@ -1142,6 +1143,7 @@ int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
 
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_register_opp_notifier);
 
 /**
  * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq @@ -1168,6 +1170,7 @@ int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
 
 	return ret;
 }
+EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
 
 static void devm_devfreq_opp_release(struct device *dev, void *res)  {
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body of a message to majordomo at vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
