From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Jul 2010 17:55:00 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Move RTC clock from init_clocks to
	init_clocks_disable
In-Reply-To: <1279702501-6803-1-git-send-email-kgene.kim@samsung.com>
References: <1279702501-6803-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279702501-6803-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Atul Dahiya <atul.dahiya@samsung.com>

RTC clock does not require to be enabled at boot time.

Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fbd85a9..f577eb7 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -133,6 +133,12 @@ static struct clk init_clocks_disable[] = {
 		.id		= -1,
 		.parent		= &clk_h,
 	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_PCLK_RTC,
+	}, {
 		.name		= "adc",
 		.id		= -1,
 		.parent		= &clk_p,
@@ -295,12 +301,6 @@ static struct clk init_clocks[] = {
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_UART3,
 	}, {
-		.name		= "rtc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c64xx_pclk_ctrl,
-		.ctrlbit	= S3C_CLKCON_PCLK_RTC,
-	}, {
 		.name		= "watchdog",
 		.id		= -1,
 		.parent		= &clk_p,
-- 
1.6.2.5
