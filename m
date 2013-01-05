From: josh.coombs@gmail.com (Joshua Coombs)
Date: Fri,  4 Jan 2013 20:50:46 -0500
Subject: [PATCH v2] clk: mvebu: Remove inappropriate __init tagging
Message-ID: <1357350646-1513-1-git-send-email-josh.coombs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the Orion WDT driver is built as a module, an opps occurs during clk lookup when calling mvebu_clk_gating_get_src().  Remove the inappropriate __init tag so the function is available for modules after kernel init.

Signed-off-by: Joshua Coombs <josh.coombs@gmail.com>
---
This is a fix for a bug and is intended for 3.8-rc

 drivers/clk/mvebu/clk-gating-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index c6d3c26..8fa5408 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -32,7 +32,7 @@ struct mvebu_soc_descr {
 
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
-static struct clk __init *mvebu_clk_gating_get_src(
+static struct clk *mvebu_clk_gating_get_src(
 	struct of_phandle_args *clkspec, void *data)
 {
 	struct mvebu_gating_ctrl *ctrl = (struct mvebu_gating_ctrl *)data;
-- 
1.8.0.2
