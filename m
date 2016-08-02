From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:20:45 +0800
Subject: [PATCH 0524/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802112045.16892-1-baolex.ni@intel.com>
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
 drivers/media/platform/exynos4-is/fimc-lite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-lite.c b/drivers/media/platform/exynos4-is/fimc-lite.c
index dc1b929..02fddb4 100644
--- a/drivers/media/platform/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/exynos4-is/fimc-lite.c
@@ -38,7 +38,7 @@
 #include "fimc-lite-reg.h"
 
 static int debug;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static const struct fimc_fmt fimc_lite_formats[] = {
 	{
-- 
2.9.2
