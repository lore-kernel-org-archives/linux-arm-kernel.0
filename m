From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 09:32:20 +0000
Subject: [PATCH] ARM: S3C64XX: SPI: Define SPI-48M clock sources
In-Reply-To: <1263807142-13186-1-git-send-email-ben-linux@fluff.org>
References: <1263807142-13186-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263807142-13186-3-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Defined special 48MHz clock sources for SPI-0,1.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/clock.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index ae5883c..2989c3a 100644
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
1.6.0.4
