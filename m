From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  1 Sep 2017 10:01:44 +0800
Subject: [PATCH v1 1/3] clk: rockchip: rk3128: add pclk_pmu as critical clock
In-Reply-To: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
References: <1504231306-4450-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1504231306-4450-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pclk_pmu need always on, and no dts node to handle this clk,
so make it as critical clock

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 62d7854e4b87..f15c9b874911 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -541,7 +541,7 @@ enum rk3128_plls {
 	GATE(0, "pclk_grf", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 4, GFLAGS),
 	GATE(0, "pclk_mipiphy", "pclk_cpu", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(5), 0, GFLAGS),
 
-	GATE(0, "pclk_pmu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 2, GFLAGS),
+	GATE(0, "pclk_pmu", "pclk_pmu_pre", 0, RK2928_CLKGATE_CON(9), 2, GFLAGS),
 	GATE(0, "pclk_pmu_niu", "pclk_pmu_pre", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 3, GFLAGS),
 
 	/* PD_MMC */
@@ -577,6 +577,7 @@ enum rk3128_plls {
 	"aclk_peri",
 	"hclk_peri",
 	"pclk_peri",
+	"pclk_pmu",
 };
 
 static struct rockchip_clk_provider *__init rk3128_common_clk_init(struct device_node *np)
-- 
1.9.1
