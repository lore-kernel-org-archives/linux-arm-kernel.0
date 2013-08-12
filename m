From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:05 +0530
Subject: [PATCH 7/9] clk: kirkwood: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-7-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/kirkwood.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 71d2461..2636a55 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -78,7 +78,7 @@
 
 enum { KIRKWOOD_CPU_TO_L2, KIRKWOOD_CPU_TO_DDR };
 
-static const struct coreclk_ratio __initconst kirkwood_coreclk_ratios[] = {
+static const struct coreclk_ratio kirkwood_coreclk_ratios[] __initconst = {
 	{ .id = KIRKWOOD_CPU_TO_L2, .name = "l2clk", },
 	{ .id = KIRKWOOD_CPU_TO_DDR, .name = "ddrclk", }
 };
@@ -90,7 +90,7 @@ static u32 __init kirkwood_get_tclk_freq(void __iomem *sar)
 	return (opt) ? 166666667 : 200000000;
 }
 
-static const u32 __initconst kirkwood_cpu_freqs[] = {
+static const u32 kirkwood_cpu_freqs[] __initconst = {
 	0, 0, 0, 0,
 	600000000,
 	0,
@@ -111,12 +111,12 @@ static u32 __init kirkwood_get_cpu_freq(void __iomem *sar)
 	return kirkwood_cpu_freqs[opt];
 }
 
-static const int __initconst kirkwood_cpu_l2_ratios[8][2] = {
+static const int kirkwood_cpu_l2_ratios[8][2] __initconst = {
 	{ 0, 1 }, { 1, 2 }, { 0, 1 }, { 1, 3 },
 	{ 0, 1 }, { 1, 4 }, { 0, 1 }, { 0, 1 }
 };
 
-static const int __initconst kirkwood_cpu_ddr_ratios[16][2] = {
+static const int kirkwood_cpu_ddr_ratios[16][2] __initconst = {
 	{ 0, 1 }, { 0, 1 }, { 1, 2 }, { 0, 1 },
 	{ 1, 3 }, { 0, 1 }, { 1, 4 }, { 2, 9 },
 	{ 1, 5 }, { 1, 6 }, { 0, 1 }, { 0, 1 },
@@ -145,7 +145,7 @@ static void __init kirkwood_get_clk_ratio(
 	}
 }
 
-static const u32 __initconst mv88f6180_cpu_freqs[] = {
+static const u32 mv88f6180_cpu_freqs[] __initconst = {
 	0, 0, 0, 0, 0,
 	600000000,
 	800000000,
@@ -158,7 +158,7 @@ static u32 __init mv88f6180_get_cpu_freq(void __iomem *sar)
 	return mv88f6180_cpu_freqs[opt];
 }
 
-static const int __initconst mv88f6180_cpu_ddr_ratios[8][2] = {
+static const int mv88f6180_cpu_ddr_ratios[8][2] __initconst = {
 	{ 0, 1 }, { 0, 1 }, { 0, 1 }, { 0, 1 },
 	{ 0, 1 }, { 1, 3 }, { 1, 4 }, { 1, 5 }
 };
@@ -219,7 +219,7 @@ CLK_OF_DECLARE(mv88f6180_core_clk, "marvell,mv88f6180-core-clock",
  * Clock Gating Control
  */
 
-static const struct clk_gating_soc_desc __initconst kirkwood_gating_desc[] = {
+static const struct clk_gating_soc_desc kirkwood_gating_desc[] __initconst = {
 	{ "ge0", NULL, 0, 0 },
 	{ "pex0", NULL, 2, 0 },
 	{ "usb0", NULL, 3, 0 },
-- 
1.7.9.5
