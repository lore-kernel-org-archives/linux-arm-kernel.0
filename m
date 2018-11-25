From: katsuhiro@katsuster.net (Katsuhiro Suzuki)
Date: Mon, 26 Nov 2018 02:56:03 +0900
Subject: [PATCH] clk: rockchip: add clock gate of ACODEC for rk3328
Message-ID: <20181125175603.30592-1-katsuhiro@katsuster.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds small changes into clock gate definition to enable
ACODEC for rk3328.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 drivers/clk/rockchip/clk-rk3328.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index 1eb46aa8b2fa..faa94adb2a37 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -804,7 +804,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
 	GATE(PCLK_USB3_GRF, "pclk_usb3_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 2, GFLAGS),
 	GATE(PCLK_USB2_GRF, "pclk_usb2_grf", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 14, GFLAGS),
 	GATE(0, "pclk_ddrphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 13, GFLAGS),
-	GATE(0, "pclk_acodecphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 5, GFLAGS),
+	GATE(PCLK_ACODECPHY, "pclk_acodecphy", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(17), 5, GFLAGS),
 	GATE(PCLK_HDMIPHY, "pclk_hdmiphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 7, GFLAGS),
 	GATE(0, "pclk_vdacphy", "pclk_phy_pre", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(17), 8, GFLAGS),
 	GATE(0, "pclk_phy_niu", "pclk_phy_pre", 0, RK3328_CLKGATE_CON(15), 15, GFLAGS),
-- 
2.19.1
