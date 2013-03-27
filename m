From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 27 Mar 2013 15:45:06 +0100
Subject: [PATCH] clk: zynq: Add missing zynq clk header
Message-ID: <1364395506-28250-1-git-send-email-michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include zynq clk header where init function is declared.

It removes this sparse warning:
drivers/clk/clk-zynq.c:373:13: warning: symbol
'xilinx_zynq_clocks_init' was not declared. Should it be static?

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/clk/clk-zynq.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-zynq.c b/drivers/clk/clk-zynq.c
index b14a25f..3206297 100644
--- a/drivers/clk/clk-zynq.c
+++ b/drivers/clk/clk-zynq.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/zynq.h>
 
 static void __iomem *slcr_base;
 
-- 
1.7.9.7
