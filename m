From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:25 +0530
Subject: [PATCH 15/33] ARM: S3C24XX: mach-nexcoder: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-16-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Guillaume GOURAT <guillaume.gourat@nexvision.tv>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-nexcoder.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 5198e3e..5c05ba1 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -84,11 +84,7 @@ static struct s3c2410_uartcfg nexcoder_uartcfgs[] __initdata = {
 /* NOR Flash on NexVision NexCoder 2440 board */
 
 static struct resource nexcoder_nor_resource[] = {
-	[0] = {
-		.start = S3C2410_CS0,
-		.end   = S3C2410_CS0 + (8*1024*1024) - 1,
-		.flags = IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS0, SZ_8M),
 };
 
 static struct map_info nexcoder_nor_map = {
-- 
1.7.4.1
