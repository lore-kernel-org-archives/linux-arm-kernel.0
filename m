From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 16 Oct 2014 10:11:34 -0700
Subject: [PATCH RFC v2 7/8] pinctrl: zynq: Use generic map_all function
In-Reply-To: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1413479495-14206-8-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic pinconf_generic_dt_node_to_map_all() function
to parse config and mux settings from DT.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/pinctrl/pinctrl-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 0136bddbb4be..743a6f563c1e 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -790,7 +790,7 @@ static const struct pinctrl_ops zynq_pctrl_ops = {
 	.get_groups_count = zynq_pctrl_get_groups_count,
 	.get_group_name = zynq_pctrl_get_group_name,
 	.get_group_pins = zynq_pctrl_get_group_pins,
-	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
 	.dt_free_map = pinctrl_utils_dt_free_map
 };
 
-- 
2.1.2.1.g5e69ed6
