From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:04 +0300
Subject: [PATCH 1/6] ARM: s3c24xx: Remove S3C24XX_DMA dependency from
 S3C2410_DMA
Message-ID: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C24XX_DMA enables legacy DMA driver, and since we want to
move to introduced generic dmaengine s3c24xx-dma driver,
it's necessary to remove this redundant dependency.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 04284de..8c2a7f3 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -133,7 +133,6 @@ config S3C2410_DMA_DEBUG
 
 config S3C2410_DMA
 	bool
-	depends on S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442)
 	help
 	  DMA device selection for S3C2410 and compatible CPUs
 
-- 
2.0.0
