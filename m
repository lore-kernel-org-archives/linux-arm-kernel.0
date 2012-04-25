From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:27 +0530
Subject: [PATCH 17/33] ARM: S3C24XX: mach-otom: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-18-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Guillaume GOURAT <guillaume.gourat@nexvision.tv>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-otom.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 5f1e0ee..bc4b6ef 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -77,11 +77,7 @@ static struct s3c2410_uartcfg otom11_uartcfgs[] __initdata = {
 /* NOR Flash on NexVision OTOM board */
 
 static struct resource otom_nor_resource[] = {
-	[0] = {
-		.start = S3C2410_CS0,
-		.end   = S3C2410_CS0 + (4*1024*1024) - 1,
-		.flags = IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS0, SZ_4M),
 };
 
 static struct platform_device otom_device_nor = {
-- 
1.7.4.1
