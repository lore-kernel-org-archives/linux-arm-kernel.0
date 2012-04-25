From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 25 Apr 2012 09:42:22 +0530
Subject: [PATCH 12/33] ARM: S3C24XX: mach-gta02: Use common macro to define
 resources
In-Reply-To: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <1335327163-11794-13-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC: Nelson Castillo <arhuaco@freaks-unidos.net>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
 arch/arm/mach-s3c24xx/mach-gta02.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index ba5d853..0f29f64a 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -387,11 +387,8 @@ static struct physmap_flash_data gta02_nor_flash_data = {
 	.width		= 2,
 };
 
-static struct resource gta02_nor_flash_resource = {
-	.start		= GTA02_FLASH_BASE,
-	.end		= GTA02_FLASH_BASE + GTA02_FLASH_SIZE - 1,
-	.flags		= IORESOURCE_MEM,
-};
+static struct resource gta02_nor_flash_resource =
+	DEFINE_RES_MEM(GTA02_FLASH_BASE, GTA02_FLASH_SIZE);
 
 static struct platform_device gta02_nor_flash = {
 	.name		= "physmap-flash",
-- 
1.7.4.1
