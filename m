From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:48 -0500
Subject: [PATCH 2/7] clk: rockchip: fix function type for CLK_OF_DECLARE
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Adding function type checking to CLK_OF_DECLARE found a type mismatch with
rk2928_gate_clk_init. The function only takes a single struct device_node
parameter.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/rockchip/clk-rockchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rockchip.c b/drivers/clk/rockchip/clk-rockchip.c
index 967c141..4cf838d5 100644
--- a/drivers/clk/rockchip/clk-rockchip.c
+++ b/drivers/clk/rockchip/clk-rockchip.c
@@ -24,8 +24,7 @@ static DEFINE_SPINLOCK(clk_lock);
  * Gate clocks
  */
 
-static void __init rk2928_gate_clk_init(struct device_node *node,
-					 void *data)
+static void __init rk2928_gate_clk_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 	const char *clk_parent;
-- 
1.9.1
