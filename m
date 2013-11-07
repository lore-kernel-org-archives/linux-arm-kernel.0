From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  7 Nov 2013 16:07:06 +0100
Subject: [PATCH 2/4] ARM: socfpga: clk: fix define typo
In-Reply-To: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1383836828-24886-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It should be SOCFPGA instead of SOCFGPA.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 9bcf84e..c6fd6e6 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -43,7 +43,7 @@
 #define SOCFPGA_PLL_DIVF_SHIFT	3
 #define SOCFPGA_PLL_DIVQ_MASK		0x003F0000
 #define SOCFPGA_PLL_DIVQ_SHIFT	16
-#define SOCFGPA_MAX_PARENTS	3
+#define SOCFPGA_MAX_PARENTS	3
 
 #define SOCFPGA_L4_MP_CLK		"l4_mp_clk"
 #define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
@@ -258,7 +258,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	struct clk *clk;
 	struct socfpga_clk *socfpga_clk;
 	const char *clk_name = node->name;
-	const char *parent_name[SOCFGPA_MAX_PARENTS];
+	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	int rc;
 	int i = 0;
@@ -299,7 +299,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 	init.name = clk_name;
 	init.ops = ops;
 	init.flags = 0;
-	while (i < SOCFGPA_MAX_PARENTS && (parent_name[i] =
+	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
 			of_clk_get_parent_name(node, i)) != NULL)
 		i++;
 
-- 
1.8.4.rc3
