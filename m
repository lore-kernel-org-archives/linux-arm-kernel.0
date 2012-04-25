From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:21 +0530
Subject: [PATCH 11/33] ARM: S3C24XX: mach-bast: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-12-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-bast.c |   45 +++++++-----------------------------
 1 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index 53219c0..1cf1720 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -310,22 +310,10 @@ static struct s3c2410_platform_nand __initdata bast_nand_info = {
 /* DM9000 */
 
 static struct resource bast_dm9k_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5 + BAST_PA_DM9000,
-		.end   = S3C2410_CS5 + BAST_PA_DM9000 + 3,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = S3C2410_CS5 + BAST_PA_DM9000 + 0x40,
-		.end   = S3C2410_CS5 + BAST_PA_DM9000 + 0x40 + 0x3f,
-		.flags = IORESOURCE_MEM,
-	},
-	[2] = {
-		.start = IRQ_DM9000,
-		.end   = IRQ_DM9000,
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
-	}
-
+	[0] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_DM9000, 4),
+	[1] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_DM9000 + 0x40, 0x40),
+	[2] = DEFINE_RES_NAMED(IRQ_DM9000 , 1, NULL, IORESOURCE_IRQ \
+					| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 /* for the moment we limit ourselves to 16bit IO until some
@@ -400,21 +388,9 @@ static struct ax_plat_data bast_asix_platdata = {
 };
 
 static struct resource bast_asix_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5 + BAST_PA_ASIXNET,
-		.end   = S3C2410_CS5 + BAST_PA_ASIXNET + (0x18 * 0x20) - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = S3C2410_CS5 + BAST_PA_ASIXNET + (0x1f * 0x20),
-		.end   = S3C2410_CS5 + BAST_PA_ASIXNET + (0x1f * 0x20),
-		.flags = IORESOURCE_MEM,
-	},
-	[2] = {
-		.start = IRQ_ASIX,
-		.end   = IRQ_ASIX,
-		.flags = IORESOURCE_IRQ
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_ASIXNET, 0x18 * 0x20),
+	[1] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_ASIXNET + (0x1f * 0x20), 1),
+	[2] = DEFINE_RES_IRQ(IRQ_ASIX),
 };
 
 static struct platform_device bast_device_asix = {
@@ -430,11 +406,8 @@ static struct platform_device bast_device_asix = {
 /* Asix AX88796 10/100 ethernet controller parallel port */
 
 static struct resource bast_asixpp_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5 + BAST_PA_ASIXNET + (0x18 * 0x20),
-		.end   = S3C2410_CS5 + BAST_PA_ASIXNET + (0x1b * 0x20) - 1,
-		.flags = IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS5 + BAST_PA_ASIXNET + (0x18 * 0x20), \
+					0x30 * 0x20),
 };
 
 static struct platform_device bast_device_axpp = {
-- 
1.7.4.1
