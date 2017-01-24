From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Jan 2017 10:41:19 +0100
Subject: [PATCH 2/2] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for the GPU
In-Reply-To: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
References: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
Message-ID: <1914af84712092019181807ddb72adfc5b40c6f4.1485250845.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to achieve all the rates asked by the GPU, we might need to change
the parent frequency.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 0d513d2674cb..a7b3c08ed0e2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -468,7 +468,7 @@ static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(drc_clk, "drc",
 				       0x180, 0, 4, 24, 3, BIT(31), 0);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
-			     0x1a0, 0, 3, BIT(31), 0);
+			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 static const char * const ats_parents[] = { "osc24M", "pll-periph" };
 static SUNXI_CCU_M_WITH_MUX_GATE(ats_clk, "ats", ats_parents,
-- 
git-series 0.8.11
