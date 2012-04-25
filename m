From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:32 +0530
Subject: [PATCH 22/33] ARM: S3C24XX: simtec-nor: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-23-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/simtec-nor.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/simtec-nor.c b/arch/arm/mach-s3c24xx/simtec-nor.c
index b9d6d4f..029744f 100644
--- a/arch/arm/mach-s3c24xx/simtec-nor.c
+++ b/arch/arm/mach-s3c24xx/simtec-nor.c
@@ -55,11 +55,7 @@ static struct physmap_flash_data simtec_nor_pdata = {
 };
 
 static struct resource simtec_nor_resource[] = {
-	[0] = {
-		.start = S3C2410_CS1 + 0x4000000,
-		.end   = S3C2410_CS1 + 0x4000000 + SZ_8M - 1,
-		.flags = IORESOURCE_MEM,
-	}
+	[0] = DEFINE_RES_MEM(S3C2410_CS1 + 0x4000000, SZ_8M),
 };
 
 static struct platform_device simtec_device_nor = {
-- 
1.7.4.1
