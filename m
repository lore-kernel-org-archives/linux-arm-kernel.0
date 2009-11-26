From: jassi.brar@samsung.com (Jassi Brar)
Date: Thu, 26 Nov 2009 15:48:10 +0900
Subject: [PATCH 2/5] SPI S3C64XX: Define SPI-48M clock sources
Message-ID: <1259218090-9815-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defined special 48MHz clock sources for SPI-0,1.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/clock.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..7b9d79c 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -141,6 +141,18 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI1,
 	}, {
+		.name		= "spi_48m",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
+	}, {
+		.name		= "spi_48m",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s3c64xx_sclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
+	}, {
 		.name		= "48m",
 		.id		= 0,
 		.parent		= &clk_48m,
-- 
1.6.2.5
