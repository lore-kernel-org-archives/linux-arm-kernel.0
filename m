From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:17 +0530
Subject: [PATCH 07/33] ARM: S3C24XX: bast-ide: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-8-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/bast-ide.c |   36 ++++++------------------------------
 1 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
index 298ecec..ba02cf8 100644
--- a/arch/arm/mach-s3c24xx/bast-ide.c
+++ b/arch/arm/mach-s3c24xx/bast-ide.c
@@ -37,21 +37,9 @@ static struct pata_platform_info bast_ide_platdata = {
 #define IDE_CS	S3C2410_CS5
 
 static struct resource bast_ide0_resource[] = {
-	[0]	= {
-		.start	= IDE_CS + BAST_PA_IDEPRI,
-		.end	= IDE_CS + BAST_PA_IDEPRI + (8 * 0x20) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1]	= {
-		.start	= IDE_CS + BAST_PA_IDEPRIAUX + (6 * 0x20) ,
-		.end	= IDE_CS + BAST_PA_IDEPRIAUX + (7 * 0x20) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2]	= {
-		.start	= IRQ_IDE0,
-		.end	= IRQ_IDE0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDEPRI, 8 * 0x20),
+	[1] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDEPRIAUX + (6 * 0x20), 0x20),
+	[2] = DEFINE_RES_IRQ(IRQ_IDE0),
 };
 
 static struct platform_device bast_device_ide0 = {
@@ -67,21 +55,9 @@ static struct platform_device bast_device_ide0 = {
 };
 
 static struct resource bast_ide1_resource[] = {
-	[0]	= {
-		.start	= IDE_CS + BAST_PA_IDESEC,
-		.end	= IDE_CS + BAST_PA_IDESEC + (8 * 0x20) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1]	= {
-		.start	= IDE_CS + BAST_PA_IDESECAUX + (6 * 0x20),
-		.end	= IDE_CS + BAST_PA_IDESECAUX + (7 * 0x20) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2]	= {
-		.start	= IRQ_IDE1,
-		.end	= IRQ_IDE1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDESEC, 8 * 0x20),
+	[1] = DEFINE_RES_MEM(IDE_CS + BAST_PA_IDESECAUX + (6 * 0x20), 0x20),
+	[2] = DEFINE_RES_IRQ(IRQ_IDE1),
 };
 
 static struct platform_device bast_device_ide1 = {
-- 
1.7.4.1
