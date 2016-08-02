From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:22 +0800
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103322.13810-1-baolex.ni@intel.com>
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
 arch/arm/common/bL_switcher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 37dc0fe..bd51c35 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -773,7 +773,7 @@ static int bL_switcher_hotplug_callback(struct notifier_block *nfb,
 }
 
 static bool no_bL_switcher;
-core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
+core_param(no_bL_switcher, no_bL_switcher, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static int __init bL_switcher_init(void)
 {
-- 
2.9.2
