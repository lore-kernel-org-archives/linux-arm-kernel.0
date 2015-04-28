From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 28 Apr 2015 13:46:16 +0900
Subject: [PATCH v2 1/8] clk: rockchip: Staticize file-scope declarations
In-Reply-To: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1430196383-9190-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing static to local (file-scope only) symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 556ce041d371..e4f9d472f1ff 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -26,7 +26,7 @@ enum rk3188_plls {
 	apll, cpll, dpll, gpll,
 };
 
-struct rockchip_pll_rate_table rk3188_pll_rates[] = {
+static struct rockchip_pll_rate_table rk3188_pll_rates[] = {
 	RK3066_PLL_RATE(2208000000, 1, 92, 1),
 	RK3066_PLL_RATE(2184000000, 1, 91, 1),
 	RK3066_PLL_RATE(2160000000, 1, 90, 1),
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index d17eb4528a28..4f817ed9e6ee 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -27,7 +27,7 @@ enum rk3288_plls {
 	apll, dpll, cpll, gpll, npll,
 };
 
-struct rockchip_pll_rate_table rk3288_pll_rates[] = {
+static struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE(2208000000, 1, 92, 1),
 	RK3066_PLL_RATE(2184000000, 1, 91, 1),
 	RK3066_PLL_RATE(2160000000, 1, 90, 1),
-- 
1.9.1
