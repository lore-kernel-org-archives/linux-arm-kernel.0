From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:53 -0500
Subject: [PATCH 7/7] clk: ti: add missing semi-colon on CLK_OF_DECLARE
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-8-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

With common OF_DECLARE macros, a semi-colon will be required for
CLK_OF_DECLARE. Add the missing semi-colon to ti,gate-clock.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/ti/gate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 3e2999d..5873481 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -221,7 +221,7 @@ static void __init of_ti_gate_clk_setup(struct device_node *node)
 {
 	_of_ti_gate_clk_setup(node, &omap_gate_clk_ops, NULL);
 }
-CLK_OF_DECLARE(ti_gate_clk, "ti,gate-clock", of_ti_gate_clk_setup)
+CLK_OF_DECLARE(ti_gate_clk, "ti,gate-clock", of_ti_gate_clk_setup);
 
 static void __init of_ti_wait_gate_clk_setup(struct device_node *node)
 {
-- 
1.9.1
