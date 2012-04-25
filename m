From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:37 +0530
Subject: [PATCH 27/33] ARM: S3C64XX: mach-mini6410: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-28-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Darius Augulis <augulis.darius@gmail.com>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c64xx/mach-mini6410.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index c34c2ab..b2166d4 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -85,21 +85,10 @@ static struct s3c2410_uartcfg mini6410_uartcfgs[] __initdata = {
 /* DM9000AEP 10/100 ethernet controller */
 
 static struct resource mini6410_dm9k_resource[] = {
-	[0] = {
-		.start	= S3C64XX_PA_XM0CSN1,
-		.end	= S3C64XX_PA_XM0CSN1 + 1,
-		.flags	= IORESOURCE_MEM
-	},
-	[1] = {
-		.start	= S3C64XX_PA_XM0CSN1 + 4,
-		.end	= S3C64XX_PA_XM0CSN1 + 5,
-		.flags	= IORESOURCE_MEM
-	},
-	[2] = {
-		.start	= S3C_EINT(7),
-		.end	= S3C_EINT(7),
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL
-	}
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN1, 2),
+	[1] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN1 + 4, 2),
+	[2] = DEFINE_RES_NAMED(S3C_EINT(7), 1, NULL, IORESOURCE_IRQ \
+					| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 static struct dm9000_plat_data mini6410_dm9k_pdata = {
-- 
1.7.4.1
