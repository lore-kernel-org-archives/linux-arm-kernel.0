From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 May 2014 19:29:50 -0500
Subject: [PATCH 4/7] clk: sunxi: fix function type for CLK_OF_DECLARE
In-Reply-To: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
References: <1399940993-1773-1-git-send-email-robherring2@gmail.com>
Message-ID: <1399940993-1773-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Adding function type checking to CLK_OF_DECLARE found a type mismatch with
sunxi_init_clocks. The function takes a single struct device_node
parameter.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: "Emilio L?pez" <emilio@elopez.com.ar>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 7977106..792773d 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1309,7 +1309,7 @@ static void __init sunxi_clock_protect(void)
 	}
 }
 
-static void __init sunxi_init_clocks(void)
+static void __init sunxi_init_clocks(struct device_node *np)
 {
 	/* Register factor clocks */
 	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
-- 
1.9.1
