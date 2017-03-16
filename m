From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Thu, 16 Mar 2017 16:44:51 +0800
Subject: [PATCH v1 1/4] clk: rockchip: rk3036: add CLK_IGNORE_UNUSED flag for
 pclk_ddrupctl
In-Reply-To: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
References: <1489653894-2440-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1489653894-2440-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 924f560dcf80..f3495fe603c1 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -377,7 +377,7 @@ enum rk3036_plls {
 
 	/* pclk_cpu gates */
 	GATE(PCLK_GRF, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
-	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 7, GFLAGS),
+	GATE(PCLK_DDRUPCTL, "pclk_ddrupctl", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 7, GFLAGS),
 	GATE(PCLK_ACODEC, "pclk_acodec", "pclk_cpu", 0, RK2928_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(PCLK_HDMI, "pclk_hdmi", "pclk_cpu", 0, RK2928_CLKGATE_CON(3), 8, GFLAGS),
 
-- 
1.9.1
