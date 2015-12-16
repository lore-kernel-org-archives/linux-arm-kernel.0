From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 16 Dec 2015 16:27:18 +0800
Subject: [PATCH 2/5] clk: rockchip: rk3036: enable the CLK_IGNORE_UNUSED flag
 for aclk_vio
In-Reply-To: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
References: <1450254441-3243-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1450254441-3243-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yakir Yang <ykk@rock-chips.com>

ACLK_VIO is the noc bus clock for display module, display cann't
read data from ddr without this clock enabled.

Due to it shouldn't belong to any driver, but we need it enabled,
so just mark it as the CLK_IGNORE_UNUSED flag.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index dc01a2a..b2cb5af 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -358,7 +358,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 
 	/* aclk_vio gates */
-	GATE(ACLK_VIO, "aclk_vio", "aclk_disp1_pre", 0, RK2928_CLKGATE_CON(6), 13, GFLAGS),
+	GATE(ACLK_VIO, "aclk_vio", "aclk_disp1_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(6), 13, GFLAGS),
 	GATE(ACLK_LCDC, "aclk_lcdc", "aclk_disp1_pre", 0, RK2928_CLKGATE_CON(9), 6, GFLAGS),
 
 	GATE(HCLK_VIO_BUS, "hclk_vio_bus", "hclk_disp_pre", 0, RK2928_CLKGATE_CON(6), 12, GFLAGS),
-- 
1.9.1
