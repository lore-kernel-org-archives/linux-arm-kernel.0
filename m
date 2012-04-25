From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:36 +0530
Subject: [PATCH 26/33] ARM: S3C64XX: mach-crag6410: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-27-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 7dce84b..0569765 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -232,21 +232,10 @@ static struct platform_device crag6410_gpio_keydev = {
 };
 
 static struct resource crag6410_dm9k_resource[] = {
-	[0] = {
-		.start	= S3C64XX_PA_XM0CSN5,
-		.end	= S3C64XX_PA_XM0CSN5 + 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C64XX_PA_XM0CSN5 + (1 << 8),
-		.end	= S3C64XX_PA_XM0CSN5 + (1 << 8) + 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= S3C_EINT(17),
-		.end	= S3C_EINT(17),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN5, 2),
+	[1] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN5 + (1 << 8), 2),
+	[2] = DEFINE_RES_NAMED(S3C_EINT(17), 1, NULL, IORESOURCE_IRQ \
+				| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 static struct dm9000_plat_data mini6410_dm9k_pdata = {
@@ -262,12 +251,7 @@ static struct platform_device crag6410_dm9k_device = {
 };
 
 static struct resource crag6410_mmgpio_resource[] = {
-	[0] = {
-		.name	= "dat",
-		.start	= S3C64XX_PA_XM0CSN4 + 1,
-		.end	= S3C64XX_PA_XM0CSN4 + 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	[0] = DEFINE_RES_MEM_NAMED(S3C64XX_PA_XM0CSN4, 1, "dat"),
 };
 
 static struct platform_device crag6410_mmgpio = {
-- 
1.7.4.1
