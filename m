From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:33:57 +0800
Subject: [PATCH 0009/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802103357.14350-1-baolex.ni@intel.com>
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
 arch/arm/mm/alignment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 7d5f4c7..d3c4432 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -86,7 +86,7 @@ static unsigned long ai_multi;
 static int ai_usermode;
 static unsigned long cr_no_alignment;
 
-core_param(alignment, ai_usermode, int, 0600);
+core_param(alignment, ai_usermode, int, S_IRUSR | S_IWUSR);
 
 #define UM_WARN		(1 << 0)
 #define UM_FIXUP	(1 << 1)
-- 
2.9.2
