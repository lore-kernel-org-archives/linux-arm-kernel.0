From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 29 Mar 2013 23:51:42 +0100
Subject: [PATCH] ARM: S3C64XX: remove obsolete Makefile line
Message-ID: <1364597502.1345.103.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a07613a54d700a974f3a4a657da78ef5d097315d ("Merge branch
'samsung/dt' into samsung/cleanup") added this line to
arch/arm/mach-s3c64xx/Makefile:
    obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o

But at that time CONFIG_S3C64XX_DEV_SPI wasn't a valid Kconfig macro
anymore and arch/arm/mach-s3c64xx/dev-spi.c was already removed. So we
can remove this line.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/arm/mach-s3c64xx/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index f9ce1dc..31d0c91 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
 obj-y				+= dev-uart.o
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 # Device setup
 
-- 
1.7.11.7
