From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:52 +0800
Subject: [PATCH 0008/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103352.14282-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/arm/mach-pxa/sharpsl_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index b80eab9..35a7472 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -802,8 +802,8 @@ static ssize_t battery_voltage_show(struct device *dev, struct device_attribute
 	return sprintf(buf, "%d\n", sharpsl_pm.battstat.mainbat_voltage);
 }
 
-static DEVICE_ATTR(battery_percentage, 0444, battery_percentage_show, NULL);
-static DEVICE_ATTR(battery_voltage, 0444, battery_voltage_show, NULL);
+static DEVICE_ATTR(battery_percentage, S_IRUSR | S_IRGRP | S_IROTH, battery_percentage_show, NULL);
+static DEVICE_ATTR(battery_voltage, S_IRUSR | S_IRGRP | S_IROTH, battery_voltage_show, NULL);
 
 extern void (*apm_get_power_status)(struct apm_power_info *);
 
-- 
2.9.2
