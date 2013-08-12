From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:03 +0530
Subject: [PATCH 5/9] clk: armada-xp: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/armada-xp.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index 13b62ce..9922c44 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -40,7 +40,7 @@
 
 enum { AXP_CPU_TO_NBCLK, AXP_CPU_TO_HCLK, AXP_CPU_TO_DRAMCLK };
 
-static const struct coreclk_ratio __initconst axp_coreclk_ratios[] = {
+static const struct coreclk_ratio axp_coreclk_ratios[] __initconst = {
 	{ .id = AXP_CPU_TO_NBCLK, .name = "nbclk" },
 	{ .id = AXP_CPU_TO_HCLK, .name = "hclk" },
 	{ .id = AXP_CPU_TO_DRAMCLK, .name = "dramclk" },
@@ -52,7 +52,7 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
 	return 250000000;
 }
 
-static const u32 __initconst axp_cpu_freqs[] = {
+static const u32 axp_cpu_freqs[] __initconst = {
 	1000000000,
 	1066000000,
 	1200000000,
@@ -89,7 +89,7 @@ static u32 __init axp_get_cpu_freq(void __iomem *sar)
 	return cpu_freq;
 }
 
-static const int __initconst axp_nbclk_ratios[32][2] = {
+static const int axp_nbclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 2}, {2, 2},
 	{1, 2}, {1, 2}, {1, 1}, {2, 3},
 	{0, 1}, {1, 2}, {2, 4}, {0, 1},
@@ -100,7 +100,7 @@ static const int __initconst axp_nbclk_ratios[32][2] = {
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 };
 
-static const int __initconst axp_hclk_ratios[32][2] = {
+static const int axp_hclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 6}, {2, 3},
 	{1, 3}, {1, 4}, {1, 2}, {2, 6},
 	{0, 1}, {1, 6}, {2, 10}, {0, 1},
@@ -111,7 +111,7 @@ static const int __initconst axp_hclk_ratios[32][2] = {
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 };
 
-static const int __initconst axp_dramclk_ratios[32][2] = {
+static const int axp_dramclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 3}, {2, 3},
 	{1, 3}, {1, 2}, {1, 2}, {2, 6},
 	{0, 1}, {1, 3}, {2, 5}, {0, 1},
@@ -169,7 +169,7 @@ CLK_OF_DECLARE(axp_core_clk, "marvell,armada-xp-core-clock",
  * Clock Gating Control
  */
 
-static const struct clk_gating_soc_desc __initconst axp_gating_desc[] = {
+static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ "audio", NULL, 0, 0 },
 	{ "ge3", NULL, 1, 0 },
 	{ "ge2", NULL,  2, 0 },
-- 
1.7.9.5
