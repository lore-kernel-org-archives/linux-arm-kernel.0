From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 31 May 2010 13:58:26 +0200
Subject: [PATCH 1/3] ARM: S3C64XX: Add SDMA clocks
In-Reply-To: <cover.1275306279.git.mcuelenaere@gmail.com>
References: <cover.1275306279.git.mcuelenaere@gmail.com>
Message-ID: <4C03A462.1070108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock definition bits for SDMA.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7a4138b..d3e11a1 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -218,6 +218,18 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_DMA1,
+	}, {
+		.name		= "sdma0",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SDMA0,
+	}, {
+		.name		= "sdma1",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_SDMA1,
 	},
 };
 
-- 
1.7.1
