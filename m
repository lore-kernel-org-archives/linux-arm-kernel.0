From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:39 +0530
Subject: [PATCH 29/33] ARM: S3C64XX: mach-smdk6410: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-30-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d55bc96..1ecd048 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -182,16 +182,9 @@ static struct s3c_fb_platdata smdk6410_lcd_pdata __initdata = {
  */
 
 static struct resource smdk6410_smsc911x_resources[] = {
-	[0] = {
-		.start = S3C64XX_PA_XM0CSN1,
-		.end   = S3C64XX_PA_XM0CSN1 + SZ_64K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = S3C_EINT(10),
-		.end   = S3C_EINT(10),
-		.flags = IORESOURCE_IRQ | IRQ_TYPE_LEVEL_LOW,
-	},
+	[0] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN1, SZ_64K),
+	[1] = DEFINE_RES_NAMED(S3C_EINT(10), 1, NULL, IORESOURCE_IRQ \
+					| IRQ_TYPE_LEVEL_LOW),
 };
 
 static struct smsc911x_platform_config smdk6410_smsc911x_pdata = {
-- 
1.7.4.1
