From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:30:14 +0900
Subject: [PATCH 06/12] [ARM][S3C6410] add support for keypad clock definition
Message-ID: <00aa01ca2e2d$005f1dc0$011d5940$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes keypad clock information which is derived from pclk domain.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 7a36e89..27bab2e 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -111,6 +111,12 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_TSADC,
 	}, {
+		.name		= "keypad",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_PCLK_KEYPAD,
+	}, {
 		.name		= "i2c",
 		.id		= -1,
 		.parent		= &clk_p,
-- 
1.6.2.5
