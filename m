From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue,  8 Oct 2013 16:47:43 +0530
Subject: [PATCH 05/10] clk: socfpga: Use NULL instead of 0
In-Reply-To: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1381231068-6053-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'div_reg' is a pointer. Assign NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
---
 drivers/clk/socfpga/clk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 5bb848c..454ddc1 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -292,7 +292,7 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 		socfpga_clk->shift = div_reg[1];
 		socfpga_clk->width = div_reg[2];
 	} else {
-		socfpga_clk->div_reg = 0;
+		socfpga_clk->div_reg = NULL;
 	}
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
-- 
1.7.9.5
