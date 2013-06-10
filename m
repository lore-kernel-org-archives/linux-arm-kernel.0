From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 10 Jun 2013 16:05:06 +0100
Subject: [PATCH 1/2] clk: vexpress: Use full node name to identify individual
 clocks
In-Reply-To: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
References: <1370876707-25265-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1370876707-25265-2-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously all the clocks were reported as "osc". Now it will be
something like "/dcc/osc at 0".

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/clk/versatile/clk-vexpress-osc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index 256c8be..2dc8b41 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -107,7 +107,7 @@ void __init vexpress_osc_of_setup(struct device_node *node)
 	osc->func = vexpress_config_func_get_by_node(node);
 	if (!osc->func) {
 		pr_err("Failed to obtain config func for node '%s'!\n",
-				node->name);
+				node->full_name);
 		goto error;
 	}
 
@@ -119,7 +119,7 @@ void __init vexpress_osc_of_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &init.name);
 	if (!init.name)
-		init.name = node->name;
+		init.name = node->full_name;
 
 	init.ops = &vexpress_osc_ops;
 	init.flags = CLK_IS_ROOT;
-- 
1.8.1.2
