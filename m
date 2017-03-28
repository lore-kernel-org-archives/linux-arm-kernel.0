From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Tue, 28 Mar 2017 18:06:54 +0800
Subject: [PATCH v2 4/4] clk: rockchip: rk3368: make some special clk as
 critical_clocks
In-Reply-To: <1490695614-3220-1-git-send-email-zhangqing@rock-chips.com>
References: <1490695614-3220-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1490695614-3220-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3368.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 6cb474c593e7..b38343f9177c 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -638,7 +638,7 @@ enum rk3368_plls {
 	GATE(SCLK_MAC_TX, "sclk_mac_tx", "mac_clk", 0,
 			RK3368_CLKGATE_CON(7), 5, GFLAGS),
 
-	GATE(0, "jtag", "ext_jtag", 0,
+	GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
 			RK3368_CLKGATE_CON(7), 0, GFLAGS),
 
 	COMPOSITE_NODIV(0, "hsic_usbphy_480m", mux_hsic_usbphy480m_p, 0,
@@ -858,6 +858,9 @@ enum rk3368_plls {
 	 */
 	"pclk_pwm1",
 	"pclk_pd_pmu",
+	"pclk_ddrphy",
+	"pclk_ddrupctl",
+	"pmu_hclk_otg0",
 };
 
 static void __init rk3368_clk_init(struct device_node *np)
-- 
1.9.1
