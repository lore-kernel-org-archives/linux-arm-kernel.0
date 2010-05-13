From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 09:27:49 +0900
Subject: [PATCH 09/11] ARM: S5P6440: Rename clkset_mmc_spi to clkset_group1
Message-ID: <1273710469-14790-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The clock source options avaialable in the clkset_mmc_spi are
applicable to clocks such as sclk_post, sclk_dispcon and
sclk_fimgvg. So this set is renamed as clkset_group1 to indicate
that it can be used as clock sources for other clocks and not
just for sclk_spi and sclk_mmc clocks.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index 26b02d4..b47f77d 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -595,15 +595,15 @@ static struct clk clk_pcm_cd = {
 	.id		= -1,
 };
 
-static struct clk *clkset_spi_mmc_list[] = {
+static struct clk *clkset_group1_list[] = {
 	&clk_mout_epll.clk,
 	&clk_dout_mpll.clk,
 	&clk_fin_epll,
 };
 
-static struct clksrc_sources clkset_spi_mmc = {
-	.sources	= clkset_spi_mmc_list,
-	.nr_sources	= ARRAY_SIZE(clkset_spi_mmc_list),
+static struct clksrc_sources clkset_group1 = {
+	.sources	= clkset_group1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group1_list),
 };
 
 static struct clk *clkset_uart_list[] = {
@@ -624,7 +624,7 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S5P_CLKCON_SCLK0_MMC0,
 			.enable		= s5p6440_sclk_ctrl,
 		},
-		.sources = &clkset_spi_mmc,
+		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 18, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4 },
 	}, {
@@ -634,7 +634,7 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S5P_CLKCON_SCLK0_MMC1,
 			.enable		= s5p6440_sclk_ctrl,
 		},
-		.sources = &clkset_spi_mmc,
+		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 4, .size = 4 },
 	}, {
@@ -644,7 +644,7 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S5P_CLKCON_SCLK0_MMC2,
 			.enable		= s5p6440_sclk_ctrl,
 		},
-		.sources = &clkset_spi_mmc,
+		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 22, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 8, .size = 4 },
 	}, {
@@ -664,7 +664,7 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S5P_CLKCON_SCLK0_SPI0,
 			.enable		= s5p6440_sclk_ctrl,
 		},
-		.sources = &clkset_spi_mmc,
+		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 14, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
 	}, {
@@ -674,7 +674,7 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S5P_CLKCON_SCLK0_SPI1,
 			.enable		= s5p6440_sclk_ctrl,
 		},
-		.sources = &clkset_spi_mmc,
+		.sources = &clkset_group1,
 		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 2 },
 		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
 	}
-- 
1.6.2.5
