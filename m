From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Apr 2015 15:22:12 +0200
Subject: [PATCH 1/8] clk: rockchip: Staticize file-scope declarations
In-Reply-To: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1428499339-29569-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing static to local (file-scope only) symbols.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 7eb684c50d42..d045a6ae4e5f 100644
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
index 05d7a0bc0599..fabc4d63a100 100644
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
