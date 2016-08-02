From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:34:02 +0800
Subject: [PATCH 0010/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103402.14418-1-baolex.ni@intel.com>
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
 arch/arm/nwfpe/fpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index ec717c1..fb37045 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -186,5 +186,5 @@ MODULE_DESCRIPTION("NWFPE floating point emulator (" NWFPE_BITS " precision)");
 MODULE_LICENSE("GPL");
 
 #ifdef CONFIG_DEBUG_USER
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 #endif
-- 
2.9.2
