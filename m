From: ping.bai@nxp.com (Bai Ping)
Date: Thu,  8 Mar 2018 17:47:22 +0800
Subject: [PATCH v4 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for busy
 divider and busy mux
Message-ID: <1520502445-22576-1-git-send-email-ping.bai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The busy divider and busy mux is actually used by the system critical clocks,
so add 'CLK_IS_CRITICAL' to clocks registered with these two type.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
 change from V3->v4:
 - fix a typo in commit log
---
 drivers/clk/imx/clk-busy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
index 6df3389..9903652 100644
--- a/drivers/clk/imx/clk-busy.c
+++ b/drivers/clk/imx/clk-busy.c
@@ -101,7 +101,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 
 	init.name = name;
 	init.ops = &clk_busy_divider_ops;
-	init.flags = CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
@@ -175,7 +175,7 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 
 	init.name = name;
 	init.ops = &clk_busy_mux_ops;
-	init.flags = 0;
+	init.flags = CLK_IS_CRITICAL;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
 
-- 
1.9.1
