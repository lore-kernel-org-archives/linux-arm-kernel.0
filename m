From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 15 Aug 2010 13:08:04 -0000
Subject: [PATCH 1/3] ARM: S3C64XX: Add SDMA clocks
Message-ID: <4c67e6ad.887b0e0a.49b7.2837@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock definition bits for SDMA.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7e03f0a..1362d31 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -230,6 +230,18 @@ static struct clk init_clocks_disable[] = {
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
1.7.0.4
