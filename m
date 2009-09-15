From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:02:36 +0900
Subject: [PATCH 04/10] S3C64XX I2S: I2S controller-2 clock declare
Message-ID: <1253008956-10537-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Defined main clock for I2S controller-2 for S3C6410.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/clock.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..858c2d3 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -129,6 +129,14 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
 	}, {
+#ifdef CONFIG_CPU_S3C6410
+		.name		= "iis",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
+	}, {
+#endif
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_p,
-- 
1.6.2.5
