From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 May 2010 11:41:14 +0900
Subject: [PATCH 1/4] ARM: S3C64XX: Add USB OTG HCLK to the list of clocks
In-Reply-To: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
References: <1275014477-23133-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1275014477-23133-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add the USB OTG HCLK clock to the list of clocks to be registered
during initialization.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7a4138b..fbd85a9 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -259,6 +259,12 @@ static struct clk init_clocks[] = {
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC2,
 	}, {
+		.name		= "otg",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_USB,
+	}, {
 		.name		= "timers",
 		.id		= -1,
 		.parent		= &clk_p,
-- 
1.6.3.3
