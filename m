From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:30 +0800
Subject: [PATCH 0003/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103330.13946-1-baolex.ni@intel.com>
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
 arch/arm/mach-imx/mach-mx31lilly.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index e9549a3..05e0312 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -241,7 +241,7 @@ static struct platform_device *devices[] __initdata = {
 };
 
 static int mx31lilly_baseboard;
-core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, 0444);
+core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-- 
2.9.2
