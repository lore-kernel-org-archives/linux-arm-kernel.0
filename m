From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:57:05 +0800
Subject: [PATCH 0908/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802115705.10501-1-baolex.ni@intel.com>
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
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 2438879..ae09134 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -96,7 +96,7 @@
 
 static int level_mask = LOG_ERROR;
 
-module_param(level_mask, int, 0644);
+module_param(level_mask, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 #ifndef MODULE
 static int __init fas216_log_setup(char *str)
-- 
2.9.2
