From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 14 May 2014 17:32:58 -0700
Subject: [RFC PATCH 02/10] clk: tegra: Fix xusb_fs_src mux
In-Reply-To: <1400113986-339-1-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
Message-ID: <1400113986-339-3-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jim Lin <jilin@nvidia.com>

The parent-to-index mapping for xusb_fs_src is incorrect.
Fix it by adding a mux table.

Signed-off-by: Jim Lin <jilin@nvidia.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/tegra/clk-tegra-periph.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 1fa5c3f..a4063bc 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -329,7 +329,9 @@ static u32 mux_clkm_pllp_pllc_pllre_idx[] = {
 static const char *mux_clkm_48M_pllp_480M[] = {
 	"clk_m", "pll_u_48M", "pll_p", "pll_u_480M"
 };
-#define mux_clkm_48M_pllp_480M_idx NULL
+static u32 mux_clkm_48M_pllp_480M_idx[] = {
+	[0] = 0, [1] = 2, [2] = 4, [3] = 6,
+};
 
 static const char *mux_clkm_pllre_clk32_480M_pllc_ref[] = {
 	"clk_m", "pll_re_out", "clk_32k", "pll_u_480M", "pll_c", "pll_ref"
-- 
1.9.1.423.g4596e3a
