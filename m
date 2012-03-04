From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 4 Mar 2012 19:04:38 +0100
Subject: [PATCH 3/6] ARM: S3C24XX: Add map entries needed by the s3c64xx-spi
 devices
In-Reply-To: <201203041902.38318.heiko@sntech.de>
References: <201203041902.38318.heiko@sntech.de>
Message-ID: <201203041904.38865.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S3C_PA_SPIx constants are only used by the s3c64xx-spi driver
and don't conflict with the older SoCs as they don't support hsspi.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/include/mach/map.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c24xx/include/mach/map.h
index 78ae807..8ba381f 100644
--- a/arch/arm/mach-s3c24xx/include/mach/map.h
+++ b/arch/arm/mach-s3c24xx/include/mach/map.h
@@ -98,6 +98,8 @@
 
 /* SPI */
 #define S3C2410_PA_SPI	   (0x59000000)
+#define S3C2443_PA_SPI0		(0x52000000)
+#define S3C2443_PA_SPI1		S3C2410_PA_SPI
 
 /* SDI */
 #define S3C2410_PA_SDI	   (0x5A000000)
@@ -162,4 +164,7 @@
 #define S3C_PA_WDT	    S3C2410_PA_WATCHDOG
 #define S3C_PA_NAND	    S3C24XX_PA_NAND
 
+#define S3C_PA_SPI0		S3C2443_PA_SPI0
+#define S3C_PA_SPI1		S3C2443_PA_SPI1
+
 #endif /* __ASM_ARCH_MAP_H */
-- 
1.7.2.3
