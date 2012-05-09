From: jose.goncalves@inov.pt (=?UTF-8?q?Jos=C3=A9=20Miguel=20Gon=C3=A7alves?=)
Date: Thu, 10 May 2012 00:46:49 +0100
Subject: [PATCH] ARM: SAMSUNG: Fix for S3C2412 EBI memory mapping.
Message-ID: <1336607209-6409-1-git-send-email-jose.goncalves@inov.pt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While upgrading the kernel on a S3C2412 based board I've noted that it was impossible to boot the board with a 2.6.32 or upper kernel.
I've tracked down the problem to the EBI virtual memory mapping that is in conflict with the IO mapping definition in arch/arm/mach-s3c24xx/s3c2412.c.

Signed-off-by: Jos? Miguel Gon?alves <jose.goncalves@inov.pt>
---
 arch/arm/plat-samsung/include/plat/map-s3c.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/plat-samsung/include/plat/map-s3c.h
index 7d04875..c0c70a8 100644
--- a/arch/arm/plat-samsung/include/plat/map-s3c.h
+++ b/arch/arm/plat-samsung/include/plat/map-s3c.h
@@ -22,7 +22,7 @@
 #define S3C24XX_VA_WATCHDOG	S3C_VA_WATCHDOG
 
 #define S3C2412_VA_SSMC		S3C_ADDR_CPU(0x00000000)
-#define S3C2412_VA_EBI		S3C_ADDR_CPU(0x00010000)
+#define S3C2412_VA_EBI		S3C_ADDR_CPU(0x00100000)
 
 #define S3C2410_PA_UART		(0x50000000)
 #define S3C24XX_PA_UART		S3C2410_PA_UART
-- 
1.7.5.4
