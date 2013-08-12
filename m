From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:02 +0530
Subject: [PATCH 4/9] clk: armada-370: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/armada-370.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 079960e..fc777bd 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -32,13 +32,13 @@
 
 enum { A370_CPU_TO_NBCLK, A370_CPU_TO_HCLK, A370_CPU_TO_DRAMCLK };
 
-static const struct coreclk_ratio __initconst a370_coreclk_ratios[] = {
+static const struct coreclk_ratio a370_coreclk_ratios[] __initconst = {
 	{ .id = A370_CPU_TO_NBCLK, .name = "nbclk" },
 	{ .id = A370_CPU_TO_HCLK, .name = "hclk" },
 	{ .id = A370_CPU_TO_DRAMCLK, .name = "dramclk" },
 };
 
-static const u32 __initconst a370_tclk_freqs[] = {
+static const u32 a370_tclk_freqs[] __initconst = {
 	16600000,
 	20000000,
 };
@@ -52,7 +52,7 @@ static u32 __init a370_get_tclk_freq(void __iomem *sar)
 	return a370_tclk_freqs[tclk_freq_select];
 }
 
-static const u32 __initconst a370_cpu_freqs[] = {
+static const u32 a370_cpu_freqs[] __initconst = {
 	400000000,
 	533000000,
 	667000000,
@@ -78,7 +78,7 @@ static u32 __init a370_get_cpu_freq(void __iomem *sar)
 	return cpu_freq;
 }
 
-static const int __initconst a370_nbclk_ratios[32][2] = {
+static const int a370_nbclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 2}, {2, 2},
 	{1, 2}, {1, 2}, {1, 1}, {2, 3},
 	{0, 1}, {1, 2}, {2, 4}, {0, 1},
@@ -89,7 +89,7 @@ static const int __initconst a370_nbclk_ratios[32][2] = {
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 };
 
-static const int __initconst a370_hclk_ratios[32][2] = {
+static const int a370_hclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 6}, {2, 3},
 	{1, 3}, {1, 4}, {1, 2}, {2, 6},
 	{0, 1}, {1, 6}, {2, 10}, {0, 1},
@@ -100,7 +100,7 @@ static const int __initconst a370_hclk_ratios[32][2] = {
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 };
 
-static const int __initconst a370_dramclk_ratios[32][2] = {
+static const int a370_dramclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 3}, {2, 3},
 	{1, 3}, {1, 2}, {1, 2}, {2, 6},
 	{0, 1}, {1, 3}, {2, 5}, {0, 1},
@@ -152,7 +152,7 @@ CLK_OF_DECLARE(a370_core_clk, "marvell,armada-370-core-clock",
  * Clock Gating Control
  */
 
-static const struct clk_gating_soc_desc __initconst a370_gating_desc[] = {
+static const struct clk_gating_soc_desc a370_gating_desc[] __initconst = {
 	{ "audio", NULL, 0, 0 },
 	{ "pex0_en", NULL, 1, 0 },
 	{ "pex1_en", NULL,  2, 0 },
-- 
1.7.9.5
