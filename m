From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:39:01 +0800
Subject: [PATCH 0712/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802113901.29520-1-baolex.ni@intel.com>
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
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index a19e73f..f480cde 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -43,7 +43,7 @@ MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, nicvf_id_table);
 
 static int debug = 0x00;
-module_param(debug, int, 0644);
+module_param(debug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Debug message level bitmap");
 
 static int cpi_alg = CPI_ALG_NONE;
-- 
2.9.2
