From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Tue, 10 Jan 2017 19:59:18 +0800
Subject: [PATCH 2/4] clk: rockchip: use rk3288 isp_in clock ids
In-Reply-To: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
References: <1484049560-14820-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1484049560-14820-2-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference the newly added isp clock-ids in the clock-tree.


Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 39af05a..8047cea 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -801,7 +801,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	GATE(0, "pclk_vip_in", "ext_vip", 0, RK3288_CLKGATE_CON(16), 0, GFLAGS),
 	INVERTER(0, "pclk_vip", "pclk_vip_in", RK3288_CLKSEL_CON(29), 4, IFLAGS),
-	GATE(0, "pclk_isp_in", "ext_isp", 0, RK3288_CLKGATE_CON(16), 3, GFLAGS),
+	GATE(PCLK_ISP_IN, "pclk_isp_in", "ext_isp", 0, RK3288_CLKGATE_CON(16), 3, GFLAGS),
 	INVERTER(0, "pclk_isp", "pclk_isp_in", RK3288_CLKSEL_CON(29), 3, IFLAGS),
 };
 
-- 
2.7.4
