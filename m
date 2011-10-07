From: olof@lixom.net (Olof Johansson)
Date: Thu,  6 Oct 2011 19:54:16 -0700
Subject: [PATCH 06/14] ARM: tegra: tegra2_clocks: 0 -> NULL changes
In-Reply-To: <1317956064-17650-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
Message-ID: <1317956064-17650-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a bunch of:

arch/arm/mach-tegra/tegra2_clocks.c:921:34: warning: Using plain integer as NULL pointer
arch/arm/mach-tegra/tegra2_clocks.c:1462:4: warning: Using plain integer as NULL pointer
arch/arm/mach-tegra/tegra2_clocks.c:1864:4: warning: Using plain integer as NULL pointer

...

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/tegra2_clocks.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 3325cd6..6dd5133 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -918,7 +918,7 @@ static struct clk_ops tegra_pll_div_ops = {
 static void tegra2_periph_clk_init(struct clk *c)
 {
 	u32 val = clk_readl(c->reg);
-	const struct clk_mux_sel *mux = 0;
+	const struct clk_mux_sel *mux = NULL;
 	const struct clk_mux_sel *sel;
 	if (c->flags & MUX) {
 		for (sel = c->inputs; sel->input != NULL; sel++) {
@@ -1459,7 +1459,7 @@ static struct clk tegra_pll_s = {
 static struct clk_mux_sel tegra_clk_m_sel[] = {
 	{ .input = &tegra_clk_32k, .value = 0},
 	{ .input = &tegra_pll_s,  .value = 1},
-	{ 0, 0},
+	{ NULL , 0},
 };
 
 static struct clk tegra_clk_m = {
@@ -1861,7 +1861,7 @@ static const struct audio_sources {
 	{ .name = "ext_audio_clk1", .value = 6 },
 	{ .name = "ext_vimclk", .value = 7 },
 #endif
-	{ 0, 0 }
+	{ NULL, 0 }
 };
 
 static struct clk tegra_clk_audio = {
@@ -1926,7 +1926,7 @@ static struct clk_mux_sel mux_cclk[] = {
 	{ .input = &tegra_pll_p_out3,	.value = 6},
 	{ .input = &tegra_clk_d,	.value = 7},
 	{ .input = &tegra_pll_x,	.value = 8},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_sclk[] = {
@@ -1938,7 +1938,7 @@ static struct clk_mux_sel mux_sclk[] = {
 	{ .input = &tegra_clk_d,	.value = 5},
 	{ .input = &tegra_clk_32k,	.value = 6},
 	{ .input = &tegra_pll_m_out1,	.value = 7},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk tegra_clk_cclk = {
@@ -2009,7 +2009,7 @@ static struct clk_mux_sel mux_pllm_pllc_pllp_plla[] = {
 	{ .input = &tegra_pll_c, .value = 1},
 	{ .input = &tegra_pll_p, .value = 2},
 	{ .input = &tegra_pll_a_out0, .value = 3},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllm_pllc_pllp_clkm[] = {
@@ -2017,7 +2017,7 @@ static struct clk_mux_sel mux_pllm_pllc_pllp_clkm[] = {
 	{ .input = &tegra_pll_c, .value = 1},
 	{ .input = &tegra_pll_p, .value = 2},
 	{ .input = &tegra_clk_m, .value = 3},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllp_pllc_pllm_clkm[] = {
@@ -2025,7 +2025,7 @@ static struct clk_mux_sel mux_pllp_pllc_pllm_clkm[] = {
 	{ .input = &tegra_pll_c, .value = 1},
 	{ .input = &tegra_pll_m, .value = 2},
 	{ .input = &tegra_clk_m, .value = 3},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllaout0_audio2x_pllp_clkm[] = {
@@ -2033,7 +2033,7 @@ static struct clk_mux_sel mux_pllaout0_audio2x_pllp_clkm[] = {
 	{.input = &tegra_clk_audio_2x, .value = 1},
 	{.input = &tegra_pll_p, .value = 2},
 	{.input = &tegra_clk_m, .value = 3},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllp_plld_pllc_clkm[] = {
@@ -2041,7 +2041,7 @@ static struct clk_mux_sel mux_pllp_plld_pllc_clkm[] = {
 	{.input = &tegra_pll_d_out0, .value = 1},
 	{.input = &tegra_pll_c, .value = 2},
 	{.input = &tegra_clk_m, .value = 3},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllp_pllc_audio_clkm_clk32[] = {
@@ -2050,39 +2050,39 @@ static struct clk_mux_sel mux_pllp_pllc_audio_clkm_clk32[] = {
 	{.input = &tegra_clk_audio,     .value = 2},
 	{.input = &tegra_clk_m,     .value = 3},
 	{.input = &tegra_clk_32k,   .value = 4},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllp_pllc_pllm[] = {
 	{.input = &tegra_pll_p,     .value = 0},
 	{.input = &tegra_pll_c,     .value = 1},
 	{.input = &tegra_pll_m,     .value = 2},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_clk_m[] = {
 	{ .input = &tegra_clk_m, .value = 0},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pllp_out3[] = {
 	{ .input = &tegra_pll_p_out3, .value = 0},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_plld[] = {
 	{ .input = &tegra_pll_d, .value = 0},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_clk_32k[] = {
 	{ .input = &tegra_clk_32k, .value = 0},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk_mux_sel mux_pclk[] = {
 	{ .input = &tegra_clk_pclk, .value = 0},
-	{ 0, 0},
+	{ NULL, 0},
 };
 
 static struct clk tegra_clk_emc = {
-- 
1.7.4.1
