From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 13 Nov 2014 15:19:21 +0800
Subject: [PATCH] clk: rockchip: fix clk_usbphy480m_gate bit location in
 register
Message-ID: <1415863161-15495-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to rk3288 trm, the clk_usbphy480m_gate is locate at
bit 14 of CRU_CLKGATE5_CON register.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 1a9d03c..74f8324 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -588,7 +588,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 
 	COMPOSITE_NODIV(0, "usbphy480m_src", mux_usbphy480m_p, 0,
 			RK3288_CLKSEL_CON(13), 11, 2, MFLAGS,
-			RK3288_CLKGATE_CON(5), 15, GFLAGS),
+			RK3288_CLKGATE_CON(5), 14, GFLAGS),
 	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
 			RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
 			RK3288_CLKGATE_CON(3), 6, GFLAGS),
-- 
1.9.1
