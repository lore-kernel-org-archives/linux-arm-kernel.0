From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 19:38:45 +0800
Subject: [PATCH 0709/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802113845.29322-1-baolex.ni@intel.com>
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
 drivers/net/ethernet/allwinner/sun4i-emac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index de2c4bf..c502059 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -39,7 +39,7 @@
 
 /* Transmit timeout, default 5 seconds. */
 static int watchdog = 5000;
-module_param(watchdog, int, 0400);
+module_param(watchdog, int, S_IRUSR);
 MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
 
 /* EMAC register address locking.
-- 
2.9.2
