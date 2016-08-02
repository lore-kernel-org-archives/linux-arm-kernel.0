From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:43:05 +0800
Subject: [PATCH 0132/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802104305.22548-1-baolex.ni@intel.com>
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
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 53d22eb..a8c2c2c 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -55,7 +55,7 @@
  * be increased during dma usage.
  */
 static unsigned int init_nr_desc_per_channel = 64;
-module_param(init_nr_desc_per_channel, uint, 0644);
+module_param(init_nr_desc_per_channel, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(init_nr_desc_per_channel,
 		 "initial descriptors per channel (default: 64)");
 
-- 
2.9.2
