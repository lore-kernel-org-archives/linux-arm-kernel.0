From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:19 +0530
Subject: [PATCH 09/33] ARM: S3C24XX: mach-anubis: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-10-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-anubis.c |   62 ++++++----------------------------
 1 files changed, 11 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 60c72c5..5a7d0c0 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -235,19 +235,9 @@ static struct pata_platform_info anubis_ide_platdata = {
 };
 
 static struct resource anubis_ide0_resource[] = {
-	{
-		.start	= S3C2410_CS3,
-		.end	= S3C2410_CS3 + (8*32) - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= S3C2410_CS3 + (1<<26) + (6*32),
-		.end	= S3C2410_CS3 + (1<<26) + (7*32) - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_IDE0,
-		.end	= IRQ_IDE0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C2410_CS3, 8 * 32),
+	[2] = DEFINE_RES_MEM(S3C2410_CS3 + (1 << 26) + (6 * 32), 32),
+	[3] = DEFINE_RES_IRQ(IRQ_IDE0),
 };
 
 static struct platform_device anubis_device_ide0 = {
@@ -262,19 +252,9 @@ static struct platform_device anubis_device_ide0 = {
 };
 
 static struct resource anubis_ide1_resource[] = {
-	{
-		.start	= S3C2410_CS4,
-		.end	= S3C2410_CS4 + (8*32) - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= S3C2410_CS4 + (1<<26) + (6*32),
-		.end	= S3C2410_CS4 + (1<<26) + (7*32) - 1,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_IDE0,
-		.end	= IRQ_IDE0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C2410_CS4, 8 * 32),
+	[1] = DEFINE_RES_MEM(S3C2410_CS4 + (1 << 26) + (6 * 32), 32),
+	[2] = DEFINE_RES_IRQ(IRQ_IDE0),
 };
 
 static struct platform_device anubis_device_ide1 = {
@@ -298,16 +278,8 @@ static struct ax_plat_data anubis_asix_platdata = {
 };
 
 static struct resource anubis_asix_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5,
-		.end   = S3C2410_CS5 + (0x20 * 0x20) -1,
-		.flags = IORESOURCE_MEM
-	},
-	[1] = {
-		.start = IRQ_ASIX,
-		.end   = IRQ_ASIX,
-		.flags = IORESOURCE_IRQ
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS5, 0x20 * 0x20),
+	[1] = DEFINE_RES_IRQ(IRQ_ASIX),
 };
 
 static struct platform_device anubis_device_asix = {
@@ -323,21 +295,9 @@ static struct platform_device anubis_device_asix = {
 /* SM501 */
 
 static struct resource anubis_sm501_resource[] = {
-	[0] = {
-		.start	= S3C2410_CS2,
-		.end	= S3C2410_CS2 + SZ_8M,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C2410_CS2 + SZ_64M - SZ_2M,
-		.end	= S3C2410_CS2 + SZ_64M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_EINT0,
-		.end	= IRQ_EINT0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(S3C2410_CS2, SZ_8M),
+	[1] = DEFINE_RES_MEM(S3C2410_CS2 + SZ_64M - SZ_2M, SZ_2M),
+	[2] = DEFINE_RES_IRQ(IRQ_EINT0),
 };
 
 static struct sm501_initdata anubis_sm501_initdata = {
-- 
1.7.4.1
