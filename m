From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:15 +0200
Subject: [PATCH 4/8] clk: tegra: Fix duplicate const for parent names
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace duplicated const keyword for 'emc_parent_clk_names' with proper
array of const pointers to const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/tegra/clk-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 615da43a508d..637798c3cc59 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -45,7 +45,7 @@
 #define CLK_SOURCE_EMC_EMC_2X_CLK_SRC(x) (((x) & CLK_SOURCE_EMC_EMC_2X_CLK_SRC_MASK) << \
 					  CLK_SOURCE_EMC_EMC_2X_CLK_SRC_SHIFT)
 
-static const char const *emc_parent_clk_names[] = {
+static const char * const emc_parent_clk_names[] = {
 	"pll_m", "pll_c", "pll_p", "clk_m", "pll_m_ud",
 	"pll_c2", "pll_c3", "pll_c_ud"
 };
-- 
1.9.1
