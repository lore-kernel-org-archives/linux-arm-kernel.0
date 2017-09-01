From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  1 Sep 2017 10:01:45 +0800
Subject: [PATCH v1 2/3] clk: rockchip: rk3128: fix up pvtm and mipi_24m gate
 regs description error
In-Reply-To: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
References: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1504231306-4450-3-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index f15c9b874911..ce02d2cff608 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -315,13 +315,13 @@ enum rk3128_plls {
 			RK2928_CLKGATE_CON(10), 8, GFLAGS),
 
 	GATE(SCLK_PVTM_CORE, "clk_pvtm_core", "xin24m", 0,
-			RK2928_CLKGATE_CON(10), 8, GFLAGS),
+			RK2928_CLKGATE_CON(10), 0, GFLAGS),
 	GATE(SCLK_PVTM_GPU, "clk_pvtm_gpu", "xin24m", 0,
-			RK2928_CLKGATE_CON(10), 8, GFLAGS),
+			RK2928_CLKGATE_CON(10), 1, GFLAGS),
 	GATE(SCLK_PVTM_FUNC, "clk_pvtm_func", "xin24m", 0,
-			RK2928_CLKGATE_CON(10), 8, GFLAGS),
+			RK2928_CLKGATE_CON(10), 2, GFLAGS),
 	GATE(SCLK_MIPI_24M, "clk_mipi_24m", "xin24m", CLK_IGNORE_UNUSED,
-			RK2928_CLKGATE_CON(10), 8, GFLAGS),
+			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
 	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 6, 2, MFLAGS, 0, 6, DFLAGS,
-- 
1.9.1
