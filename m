From: paweljarosz3691@gmail.com (=?utf-8?B?UGF3ZcWC?= Jarosz)
Date: Fri, 14 Oct 2016 14:16:39 +0200
Subject: [PATCH v2 1/2] clk: rockchip: Add bindings for cpu and peri clocks
 on rk3066
In-Reply-To: <cover.1476447057.git.paweljarosz3691@gmail.com>
References: <cover.1476447057.git.paweljarosz3691@gmail.com>
Message-ID: <938d05a66c34bd8af255979462fbed387a67abff.1476447057.git.paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for ACLK_CPU, HCLK_CPU, PCLK_CPU, ACLK_PERI, HCLK_PERI, PCLK_PERI.

We need this to init it's rate at boot time.

Signed-off-by: Pawe? Jarosz <paweljarosz3691@gmail.com>
---

Changes in v2:
- none

 drivers/clk/rockchip/clk-rk3188.c             | 12 ++++++------
 include/dt-bindings/clock/rk3188-cru-common.h |  8 +++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index d0e722a..a6d398f 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -306,14 +306,14 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(26), 8, 1, MFLAGS, 0, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(0), 2, GFLAGS),
 
-	GATE(0, "aclk_cpu", "aclk_cpu_pre", 0,
+	GATE(ACLK_CPU, "aclk_cpu", "aclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 3, GFLAGS),
 
 	GATE(0, "atclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 6, GFLAGS),
-	GATE(0, "pclk_cpu", "pclk_cpu_pre", 0,
+	GATE(PCLK_CPU, "pclk_cpu", "pclk_cpu_pre", 0,
 			RK2928_CLKGATE_CON(0), 5, GFLAGS),
-	GATE(0, "hclk_cpu", "hclk_cpu_pre", CLK_IGNORE_UNUSED,
+	GATE(HCLK_CPU, "hclk_cpu", "hclk_cpu_pre", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(0), 4, GFLAGS),
 
 	COMPOSITE(0, "aclk_lcdc0_pre", mux_pll_src_cpll_gpll_p, CLK_IGNORE_UNUSED,
@@ -323,12 +323,12 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKSEL_CON(31), 15, 1, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(1), 4, GFLAGS),
 
-	GATE(0, "aclk_peri", "aclk_peri_pre", 0,
+	GATE(ACLK_PERI, "aclk_peri", "aclk_peri_pre", 0,
 			RK2928_CLKGATE_CON(2), 1, GFLAGS),
-	COMPOSITE_NOMUX(0, "hclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(HCLK_PERI, "hclk_peri", "aclk_peri_pre", 0,
 			RK2928_CLKSEL_CON(10), 8, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 2, GFLAGS),
-	COMPOSITE_NOMUX(0, "pclk_peri", "aclk_peri_pre", 0,
+	COMPOSITE_NOMUX(PCLK_PERI, "pclk_peri", "aclk_peri_pre", 0,
 			RK2928_CLKSEL_CON(10), 12, 2, DFLAGS | CLK_DIVIDER_POWER_OF_TWO,
 			RK2928_CLKGATE_CON(2), 3, GFLAGS),
 
diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index 4f53e70..d141c1f 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -72,6 +72,8 @@
 #define ACLK_IPP		200
 #define ACLK_RGA		201
 #define ACLK_CIF0		202
+#define ACLK_CPU		203
+#define ACLK_PERI		204
 
 /* pclk gates */
 #define PCLK_GRF		320
@@ -104,6 +106,8 @@
 #define PCLK_EFUSE		347
 #define PCLK_TZPC		348
 #define PCLK_TSADC		349
+#define PCLK_CPU		350
+#define PCLK_PERI		351
 
 /* hclk gates */
 #define HCLK_SDMMC		448
@@ -126,8 +130,10 @@
 #define HCLK_IPP		465
 #define HCLK_RGA		466
 #define HCLK_NANDC0		467
+#define HCLK_CPU		468
+#define HCLK_PERI		469
 
-#define CLK_NR_CLKS		(HCLK_NANDC0 + 1)
+#define CLK_NR_CLKS		(HCLK_PERI + 1)
 
 /* soft-reset indices */
 #define SRST_MCORE		2
-- 
2.7.4
