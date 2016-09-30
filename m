From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 30 Sep 2016 10:33:59 +0200
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix the clock gate flag
Message-ID: <20160930083359.14943-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the gate part of the peripheral clock setting the bit disables the
clock and clearing it enables the clock. This is not the default behavior
of clk_gate component, so we need to use the CLK_GATE_SET_TO_DISABLE flag.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index d5dfbad4ceab..cecb0fdfaef6 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -329,6 +329,7 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
 		gate->lock = lock;
 		gate_ops = gate_hw->init->ops;
 		gate->reg = reg + (u64)gate->reg;
+		gate->flags = CLK_GATE_SET_TO_DISABLE;
 	}
 
 	if (data->rate_hw) {
-- 
2.9.3
