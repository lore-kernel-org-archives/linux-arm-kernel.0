From: jassi.brar@samsung.com (Jassi Brar)
Date: Wed, 11 Nov 2009 14:47:17 +0900
Subject: [PATCH 1/2] S3C6410 I2S: Added 'iis' clock for I2S_v4
Message-ID: <1257918437-24259-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implemented 'iis'(PCLK source) for the I2S_v4(I2S-2) controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..3fa49a6 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -129,6 +129,12 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
 	}, {
+		.name		= "iis",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
+	}, {
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_p,
-- 
1.6.2.5
