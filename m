From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:46 +0800
Subject: [PATCH 0007/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103346.14216-1-baolex.ni@intel.com>
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
 arch/arm/mach-pxa/colibri-pxa270.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index e68acdd..d2188d0 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -271,7 +271,7 @@ static inline void colibri_pxa270_tsc_init(void) {}
 #endif
 
 static int colibri_pxa270_baseboard;
-core_param(colibri_pxa270_baseboard, colibri_pxa270_baseboard, int, 0444);
+core_param(colibri_pxa270_baseboard, colibri_pxa270_baseboard, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 static void __init colibri_pxa270_init(void)
 {
-- 
2.9.2
