From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 12 Feb 2014 10:41:08 +0100
Subject: [PATCH] ARM: S3C24XX: Fix typo "CONFIG_CPUS_3C2443"
Message-ID: <1392198068.23759.7.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. This needs testing by people with access to knowledge,
compilers, and/or hardware related to CPU_S3C2443. I'm not one of them. 

 arch/arm/mach-s3c24xx/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 4adaa4b..1d77d70 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -484,7 +484,7 @@ struct platform_device s3c2440_device_dma = {
 };
 #endif
 
-#if defined(CONFIG_CPUS_3C2443) || defined(CONFIG_CPU_S3C2416)
+#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
 static struct resource s3c2443_dma_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_DMA, S3C24XX_SZ_DMA),
 	[1] = DEFINE_RES_IRQ(IRQ_S3C2443_DMA0),
-- 
1.8.5.3
