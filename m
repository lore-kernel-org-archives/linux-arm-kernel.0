From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu, 13 Nov 2014 15:22:37 +0800
Subject: [PATCH 2/2] clk: rockchip: use the clock ID for usbphy480m_src
In-Reply-To: <1415863357-15680-1-git-send-email-kever.yang@rock-chips.com>
References: <1415863357-15680-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <1415863357-15680-2-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the clock ID for usbphy480m_src so that we can find
this clock node in dts.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 74f8324..157b60b 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -586,7 +586,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
 	GATE(0, "jtag", "ext_jtag", 0,
 			RK3288_CLKGATE_CON(4), 14, GFLAGS),
 
-	COMPOSITE_NODIV(0, "usbphy480m_src", mux_usbphy480m_p, 0,
+	COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
 			RK3288_CLKSEL_CON(13), 11, 2, MFLAGS,
 			RK3288_CLKGATE_CON(5), 14, GFLAGS),
 	COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
-- 
1.9.1
