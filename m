From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:31 +0530
Subject: [PATCH 21/33] ARM: S3C24XX: mach-vr1000: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-22-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-vr1000.c |   39 +++++++---------------------------
 1 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 87608d4..bd5f189 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -187,40 +187,17 @@ static struct platform_device serial_device = {
 /* DM9000 ethernet devices */
 
 static struct resource vr1000_dm9k0_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5 + VR1000_PA_DM9000,
-		.end   = S3C2410_CS5 + VR1000_PA_DM9000 + 3,
-		.flags = IORESOURCE_MEM
-	},
-	[1] = {
-		.start = S3C2410_CS5 + VR1000_PA_DM9000 + 0x40,
-		.end   = S3C2410_CS5 + VR1000_PA_DM9000 + 0x7f,
-		.flags = IORESOURCE_MEM
-	},
-	[2] = {
-		.start = IRQ_VR1000_DM9000A,
-		.end   = IRQ_VR1000_DM9000A,
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
-	}
-
+	[0] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000, 4),
+	[1] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0x40, 0x40),
+	[2] = DEFINE_RES_NAMED(IRQ_VR1000_DM9000A, 1, NULL, IORESOURCE_IRQ \
+						| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 static struct resource vr1000_dm9k1_resource[] = {
-	[0] = {
-		.start = S3C2410_CS5 + VR1000_PA_DM9000 + 0x80,
-		.end   = S3C2410_CS5 + VR1000_PA_DM9000 + 0x83,
-		.flags = IORESOURCE_MEM
-	},
-	[1] = {
-		.start = S3C2410_CS5 + VR1000_PA_DM9000 + 0xC0,
-		.end   = S3C2410_CS5 + VR1000_PA_DM9000 + 0xFF,
-		.flags = IORESOURCE_MEM
-	},
-	[2] = {
-		.start = IRQ_VR1000_DM9000N,
-		.end   = IRQ_VR1000_DM9000N,
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0x80, 4),
+	[1] = DEFINE_RES_MEM(S3C2410_CS5 + VR1000_PA_DM9000 + 0xC0, 0x40),
+	[2] = DEFINE_RES_NAMED(IRQ_VR1000_DM9000N, 1, NULL, IORESOURCE_IRQ \
+						| IORESOURCE_IRQ_HIGHLEVEL),
 };
 
 /* for the moment we limit ourselves to 16bit IO until some
-- 
1.7.4.1
