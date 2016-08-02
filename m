From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:43 +0800
Subject: [PATCH 0006/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103343.14150-1-baolex.ni@intel.com>
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
 arch/arm/mach-integrator/impd1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 38b0da3..6fc2e7a 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -34,7 +34,7 @@
 
 static int module_id;
 
-module_param_named(lmid, module_id, int, 0444);
+module_param_named(lmid, module_id, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(lmid, "logic module stack position");
 
 struct impd1_module {
-- 
2.9.2
