From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:34 +0800
Subject: [PATCH 0004/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103334.14014-1-baolex.ni@intel.com>
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
 arch/arm/mach-imx/mach-mx31lite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 4822a17..0da699c 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -224,7 +224,7 @@ void __init mx31lite_map_io(void)
 }
 
 static int mx31lite_baseboard;
-core_param(mx31lite_baseboard, mx31lite_baseboard, int, 0444);
+core_param(mx31lite_baseboard, mx31lite_baseboard, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
-- 
2.9.2
