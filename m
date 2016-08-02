From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:42:07 +0800
Subject: [PATCH 0745/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802114207.31726-1-baolex.ni@intel.com>
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
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 7397087..eaea2d8 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -957,7 +957,7 @@ static ssize_t temac_show_llink_regs(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(llink_regs, 0440, temac_show_llink_regs, NULL);
+static DEVICE_ATTR(llink_regs, S_IRUSR | S_IRGRP, temac_show_llink_regs, NULL);
 
 static struct attribute *temac_device_attrs[] = {
 	&dev_attr_llink_regs.attr,
-- 
2.9.2
