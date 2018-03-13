From: dbasehore@chromium.org (Derek Basehore)
Date: Tue, 13 Mar 2018 13:37:19 -0700
Subject: [PATCH] clk: rockchip: Add 1.6GHz PLL rate
Message-ID: <20180313203719.75639-1-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need this rate to generate 100, 200, and 228.57MHz from the same
PLL. 228.57MHz is useful for a pixel clock when the VPLL is used for
and external display.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/rockchip/clk-rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 6847120b61cd..3e57c6eef93d 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -57,6 +57,7 @@ static struct rockchip_pll_rate_table rk3399_pll_rates[] = {
 	RK3036_PLL_RATE(1656000000, 1, 69, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1632000000, 1, 68, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1608000000, 1, 67, 1, 1, 1, 0),
+	RK3036_PLL_RATE(1600000000, 3, 200, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1584000000, 1, 66, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1560000000, 1, 65, 1, 1, 1, 0),
 	RK3036_PLL_RATE(1536000000, 1, 64, 1, 1, 1, 0),
-- 
2.16.2.660.g709887971b-goog
