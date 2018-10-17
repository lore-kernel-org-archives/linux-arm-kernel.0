From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 17 Oct 2018 06:11:59 +0000
Subject: [PATCH 1/2] clk: imx: cpu clock should be always critical
Message-ID: <1539756441-18776-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CLK_IS_CRITICAL flag for cpu clock type to
make cpu clock use count correct, as cpu clock
should be always critical.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index 9d46eac..ed1b7e9 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -94,7 +94,7 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 
 	init.name = name;
 	init.ops = &clk_cpu_ops;
-	init.flags = 0;
+	init.flags = CLK_IS_CRITICAL;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-- 
2.7.4
