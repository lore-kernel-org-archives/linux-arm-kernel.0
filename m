From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:26 +0530
Subject: [PATCH 16/33] ARM: S3C24XX: mach-osiris: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-17-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-osiris.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index c5daeb6..95d0772 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -244,16 +244,8 @@ static struct s3c2410_platform_nand __initdata osiris_nand_info = {
 /* PCMCIA control and configuration */
 
 static struct resource osiris_pcmcia_resource[] = {
-	[0] = {
-		.start	= 0x0f000000,
-		.end	= 0x0f100000,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 0x0c000000,
-		.end	= 0x0c100000,
-		.flags	= IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(0x0f000000, SZ_1M),
+	[1] = DEFINE_RES_MEM(0x0c000000, SZ_1M),
 };
 
 static struct platform_device osiris_pcmcia = {
-- 
1.7.4.1
