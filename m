From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 20 Feb 2014 15:54:52 +0200
Subject: [PATCH] clk: tegra: Fix vic03 mux index
Message-ID: <1392904492-11979-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vic03 mux uses a linear mapping.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra-periph.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index f5376a3..1fa5c3f 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -371,9 +371,7 @@ static const char *mux_pllp3_pllc_clkm[] = {
 static const char *mux_pllm_pllc_pllp_plla_pllc2_c3_clkm[] = {
 	"pll_m", "pll_c", "pll_p", "pll_a", "pll_c2", "pll_c3", "clk_m"
 };
-static u32 mux_pllm_pllc_pllp_plla_pllc2_c3_clkm_idx[] = {
-	[0] = 0, [1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 6,
-};
+#define mux_pllm_pllc_pllp_plla_pllc2_c3_clkm_idx NULL
 
 static const char *mux_pllm_pllc2_c_c3_pllp_plla_pllc4[] = {
 	"pll_m", "pll_c2", "pll_c", "pll_c3", "pll_p", "pll_a_out0", "pll_c4",
-- 
1.7.7.rc0.72.g4b5ea.dirty
