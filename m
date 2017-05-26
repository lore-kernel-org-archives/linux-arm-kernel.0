From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 26 May 2017 15:38:21 +0800
Subject: [PATCH v2 3/3] clk: hi3660: Set PPLL2 to 2880M
In-Reply-To: <20170526073821.25971-1-guodong.xu@linaro.org>
References: <20170526073821.25971-1-guodong.xu@linaro.org>
Message-ID: <20170526073821.25971-4-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Set PPLL2 to 2880M. With this patch, we saw better compatibility
on various 1080p HDMI monitors.

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Zheng Shaobo <zhengshaobo1@huawei.com>
---
 drivers/clk/hisilicon/clk-hi3660.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 67c4d44..eb9ba41 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -20,7 +20,7 @@ static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
 	{ HI3660_CLK_FLL_SRC, "clk_fll_src", NULL, 0, 128000000, },
 	{ HI3660_CLK_PPLL0, "clk_ppll0", NULL, 0, 1600000000, },
 	{ HI3660_CLK_PPLL1, "clk_ppll1", NULL, 0, 1866000000, },
-	{ HI3660_CLK_PPLL2, "clk_ppll2", NULL, 0, 960000000, },
+	{ HI3660_CLK_PPLL2, "clk_ppll2", NULL, 0, 2880000000, },
 	{ HI3660_CLK_PPLL3, "clk_ppll3", NULL, 0, 1290000000, },
 	{ HI3660_CLK_SCPLL, "clk_scpll", NULL, 0, 245760000, },
 	{ HI3660_PCLK, "pclk", NULL, 0, 20000000, },
@@ -42,7 +42,7 @@ static const struct hisi_fixed_factor_clock hi3660_crg_fixed_factor_clks[] = {
 	{ HI3660_CLK_GATE_I2C6, "clk_gate_i2c6", "clk_i2c6_iomcu", 1, 4, 0, },
 	{ HI3660_CLK_DIV_SYSBUS, "clk_div_sysbus", "clk_mux_sysbus", 1, 7, 0, },
 	{ HI3660_CLK_DIV_320M, "clk_div_320m", "clk_320m_pll_gt", 1, 5, 0, },
-	{ HI3660_CLK_DIV_A53, "clk_div_a53hpm", "clk_a53hpm_andgt", 1, 2, 0, },
+	{ HI3660_CLK_DIV_A53, "clk_div_a53hpm", "clk_a53hpm_andgt", 1, 6, 0, },
 	{ HI3660_CLK_GATE_SPI0, "clk_gate_spi0", "clk_ppll0", 1, 8, 0, },
 	{ HI3660_CLK_GATE_SPI2, "clk_gate_spi2", "clk_ppll0", 1, 8, 0, },
 	{ HI3660_PCIEPHY_REF, "clk_pciephy_ref", "clk_div_pciephy", 1, 1, 0, },
-- 
2.10.2
