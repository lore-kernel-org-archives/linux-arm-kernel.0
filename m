From: j-keerthy@ti.com (Keerthy)
Date: Thu, 9 Mar 2017 13:36:00 +0530
Subject: [PATCH v2 6/8] thermal: ti-soc-thermal: Fetch slope and offset from DT
In-Reply-To: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
References: <1489046762-11288-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1489046762-11288-7-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently slope and offset values for calculating the hot spot
temperature of a thermal zone is being taken directly from driver
data. So fetch them from device tree.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 0586bd0..2054a5c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -96,8 +96,8 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 		return ret;
 
 	/* Default constants */
-	slope = s->slope;
-	constant = s->constant;
+	slope = thermal_zone_get_slope(data->ti_thermal);
+	constant = thermal_zone_get_offset(data->ti_thermal);
 
 	pcb_tz = data->pcb_tz;
 	/* In case pcb zone is available, use the extrapolation rule with it */
-- 
1.9.1
