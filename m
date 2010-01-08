From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:17 +0000
Subject: [S3C-CLK] ARM: S3C64XX: Fixup .reg_src and .reg_div with named
	initialisers
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change these two fields to have named initialisers as per the
review comments from Kyungmin Park.

sed used:

s@\.reg_src\(.*\)=\(.*\){\(.*\),\(.*\),\(.*\)}@.reg_src\1=\2{ .reg =\3, .shift =\4, .size =\5 }@g
s@\.reg_div\(.*\)=\(.*\){\(.*\),\(.*\),\(.*\)}@.reg_div\1=\2{ .reg =\3, .shift =\4, .size =\5 }@g

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/s3c6400-clock.c |   50 ++++++++++++++++----------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index f85406a..555d1aa 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -69,7 +69,7 @@ static struct clksrc_clk clk_mout_apll = {
 		.name		= "mout_apll",
 		.id		= -1,
 	},
-	.reg_src	= { S3C_CLK_SRC, 0, 1 },
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 0, .size = 1  },
 	.sources	= &clk_src_apll,
 };
 
@@ -88,7 +88,7 @@ static struct clksrc_clk clk_mout_epll = {
 		.name		= "mout_epll",
 		.id		= -1,
 	},
-	.reg_src	= { S3C_CLK_SRC, 2, 1 },
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 2, .size = 1  },
 	.sources	= &clk_src_epll,
 };
 
@@ -107,7 +107,7 @@ static struct clksrc_clk clk_mout_mpll = {
 		.name		= "mout_mpll",
 		.id		= -1,
 	},
-	.reg_src	= { S3C_CLK_SRC, 1, 1 },
+	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 1, .size = 1  },
 	.sources	= &clk_src_mpll,
 };
 
@@ -313,8 +313,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 18, 2 },
-		.reg_div	= { S3C_CLK_DIV1, 0, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 18, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 0, .size = 4  },
 		.sources	= &clkset_spi_mmc,
 	}, {
 		.clk	= {
@@ -323,8 +323,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 20, 2 },
-		.reg_div	= { S3C_CLK_DIV1, 4, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 20, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 4, .size = 4  },
 		.sources	= &clkset_spi_mmc,
 	}, {
 		.clk	= {
@@ -333,8 +333,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 22, 2 },
-		.reg_div 	= { S3C_CLK_DIV1, 8, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 22, .size = 2  },
+		.reg_div 	= { .reg = S3C_CLK_DIV1, .shift = 8, .size = 4  },
 		.sources	= &clkset_spi_mmc,
 	}, {
 		.clk	= {
@@ -343,8 +343,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src 	= { S3C_CLK_SRC, 5, 2 },
-		.reg_div	= { S3C_CLK_DIV1, 20, 4 },
+		.reg_src 	= { .reg = S3C_CLK_SRC, .shift = 5, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV1, .shift = 20, .size = 4  },
 		.sources	= &clkset_uhost,
 	}, {
 		.clk	= {
@@ -353,8 +353,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_UART,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 13, 1 },
-		.reg_div	= { S3C_CLK_DIV2, 16, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 13, .size = 1  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 16, .size = 4  },
 		.sources	= &clkset_uart,
 	}, {
 /* Where does UCLK0 come from? */
@@ -364,8 +364,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 14, 2 },
-		.reg_div	= { S3C_CLK_DIV2, 0, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 14, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 0, .size = 4  },
 		.sources	= &clkset_spi_mmc,
 	}, {
 		.clk	= {
@@ -374,8 +374,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_SPI1,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 16, 2 },
-		.reg_div	= { S3C_CLK_DIV2, 4, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 16, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 4, .size = 4  },
 		.sources	= &clkset_spi_mmc,
 	}, {
 		.clk	= {
@@ -384,8 +384,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 7, 3 },
-		.reg_div	= { S3C_CLK_DIV2, 8, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 7, .size = 3  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 8, .size = 4  },
 		.sources	= &clkset_audio0,
 	}, {
 		.clk	= {
@@ -394,8 +394,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 10, 3 },
-		.reg_div	= { S3C_CLK_DIV2, 12, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 10, .size = 3  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 12, .size = 4  },
 		.sources	= &clkset_audio1,
 	}, {
 		.clk	= {
@@ -404,8 +404,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_src	= { S3C_CLK_SRC, 24, 2 },
-		.reg_div	= { S3C_CLK_DIV2, 20, 4 },
+		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 24, .size = 2  },
+		.reg_div	= { .reg = S3C_CLK_DIV2, .shift = 20, .size = 4  },
 		.sources	= &clkset_irda,
 	}, {
 		.clk	= {
@@ -414,8 +414,8 @@ static struct clksrc_clk clksrcs[] = {
 			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-		.reg_div	= { S3C_CLK_DIV0, 20, 4 },
-		.reg_src	= { NULL, 0, 0 },
+		.reg_div	= { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
+		.reg_src	= { .reg = NULL, .shift = 0, .size = 0  },
 		.sources	= &clkset_camif,
 	},
 };
-- 
1.6.0.4
