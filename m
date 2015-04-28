From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Apr 2015 13:46:18 +0900
Subject: [PATCH v2 3/8] clk: tegra: Fix inconsistent indenting
In-Reply-To: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the indentation - spaces used instead of tabs and actually wrong
number of spaces.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/tegra/clk-emc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 615da43a508d..8757feda4a11 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -130,11 +130,11 @@ static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	tegra = container_of(hw, struct tegra_clk_emc, hw);
 
-         for (i = 0; i < tegra->num_timings; i++) {
-                if (tegra->timings[i].ram_code != ram_code)
-                        continue;
+	for (i = 0; i < tegra->num_timings; i++) {
+		if (tegra->timings[i].ram_code != ram_code)
+			continue;
 
-                timing = tegra->timings + i;
+		timing = tegra->timings + i;
 
 		if (timing->rate > max_rate) {
 			i = min(i, 1);
@@ -145,11 +145,11 @@ static long emc_determine_rate(struct clk_hw *hw, unsigned long rate,
 			continue;
 
 		if (timing->rate >= rate)
-                        return timing->rate;
-        }
+			return timing->rate;
+	}
 
-        if (timing)
-                return timing->rate;
+	if (timing)
+		return timing->rate;
 
 	return __clk_get_rate(hw->clk);
 }
-- 
1.9.1
