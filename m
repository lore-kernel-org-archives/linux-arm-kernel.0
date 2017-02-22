From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed, 22 Feb 2017 10:59:55 +0800
Subject: [PATCH v1] clk: rockchip: add pll_wait_lock for pll_enable
Message-ID: <1487732395-30353-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If pll is power down,when power up pll need wait pll lock.
The reference documents section:
	PLL frequency change and lock check

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 6ed605776abd..c4dfd26f37ae 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -268,6 +268,7 @@ static int rockchip_rk3036_pll_enable(struct clk_hw *hw)
 
 	writel(HIWORD_UPDATE(0, RK3036_PLLCON1_PWRDOWN, 0),
 	       pll->reg_base + RK3036_PLLCON(1));
+	rockchip_pll_wait_lock(pll);
 
 	return 0;
 }
@@ -500,6 +501,7 @@ static int rockchip_rk3066_pll_enable(struct clk_hw *hw)
 
 	writel(HIWORD_UPDATE(0, RK3066_PLLCON3_PWRDOWN, 0),
 	       pll->reg_base + RK3066_PLLCON(3));
+	rockchip_pll_wait_lock(pll);
 
 	return 0;
 }
@@ -745,6 +747,7 @@ static int rockchip_rk3399_pll_enable(struct clk_hw *hw)
 
 	writel(HIWORD_UPDATE(0, RK3399_PLLCON3_PWRDOWN, 0),
 	       pll->reg_base + RK3399_PLLCON(3));
+	rockchip_rk3399_pll_wait_lock(pll);
 
 	return 0;
 }
-- 
1.9.1
