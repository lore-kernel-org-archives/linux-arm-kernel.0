From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:38 +0800
Subject: [PATCH 0005/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103338.14081-1-baolex.ni@intel.com>
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
 arch/arm/mach-imx/mach-mx31moboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 4f2d998..64c2acb 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -513,7 +513,7 @@ static void mx31moboard_poweroff(void)
 }
 
 static int mx31moboard_baseboard;
-core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
+core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 /*
  * Board specific initialization.
-- 
2.9.2
