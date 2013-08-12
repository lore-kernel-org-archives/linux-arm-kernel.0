From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 12 Aug 2013 14:44:04 +0530
Subject: [PATCH 6/9] clk: dove: Fix incorrect placement of __initconst
In-Reply-To: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1376298847-21828-6-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__initconst should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 drivers/clk/mvebu/dove.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
index 79d7aed..38aee1e 100644
--- a/drivers/clk/mvebu/dove.c
+++ b/drivers/clk/mvebu/dove.c
@@ -74,12 +74,12 @@
 
 enum { DOVE_CPU_TO_L2, DOVE_CPU_TO_DDR };
 
-static const struct coreclk_ratio __initconst dove_coreclk_ratios[] = {
+static const struct coreclk_ratio dove_coreclk_ratios[] __initconst = {
 	{ .id = DOVE_CPU_TO_L2, .name = "l2clk", },
 	{ .id = DOVE_CPU_TO_DDR, .name = "ddrclk", }
 };
 
-static const u32 __initconst dove_tclk_freqs[] = {
+static const u32 dove_tclk_freqs[] __initconst = {
 	166666667,
 	125000000,
 	0, 0
@@ -92,7 +92,7 @@ static u32 __init dove_get_tclk_freq(void __iomem *sar)
 	return dove_tclk_freqs[opt];
 }
 
-static const u32 __initconst dove_cpu_freqs[] = {
+static const u32 dove_cpu_freqs[] __initconst = {
 	0, 0, 0, 0, 0,
 	1000000000,
 	933333333, 933333333,
@@ -111,12 +111,12 @@ static u32 __init dove_get_cpu_freq(void __iomem *sar)
 	return dove_cpu_freqs[opt];
 }
 
-static const int __initconst dove_cpu_l2_ratios[8][2] = {
+static const int dove_cpu_l2_ratios[8][2] __initconst = {
 	{ 1, 1 }, { 0, 1 }, { 1, 2 }, { 0, 1 },
 	{ 1, 3 }, { 0, 1 }, { 1, 4 }, { 0, 1 }
 };
 
-static const int __initconst dove_cpu_ddr_ratios[16][2] = {
+static const int dove_cpu_ddr_ratios[16][2] __initconst = {
 	{ 1, 1 }, { 0, 1 }, { 1, 2 }, { 2, 5 },
 	{ 1, 3 }, { 0, 1 }, { 1, 4 }, { 0, 1 },
 	{ 1, 5 }, { 0, 1 }, { 1, 6 }, { 0, 1 },
@@ -164,7 +164,7 @@ CLK_OF_DECLARE(dove_core_clk, "marvell,dove-core-clock", dove_coreclk_init);
  * Clock Gating Control
  */
 
-static const struct clk_gating_soc_desc __initconst dove_gating_desc[] = {
+static const struct clk_gating_soc_desc dove_gating_desc[] __initconst = {
 	{ "usb0", NULL, 0, 0 },
 	{ "usb1", NULL, 1, 0 },
 	{ "ge",	"gephy", 2, 0 },
-- 
1.7.9.5
