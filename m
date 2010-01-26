From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:58 +0000
Subject: [PATCH] ARM: S3C64XX: Move device files into mach-s3c64xx
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the S3C64XX specific device files into mach-s3c64xx

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Makefile                     |    7 +++++++
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-adc.c  |    0
 .../arm/{plat-s3c64xx => mach-s3c64xx}/dev-audio.c |    0
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-rtc.c  |    0
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-spi.c  |    2 +-
 arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-uart.c |    0
 .../include/mach}/spi-clocks.h                     |    2 +-
 arch/arm/plat-s3c64xx/Makefile                     |    9 ---------
 8 files changed, 9 insertions(+), 11 deletions(-)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-adc.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-audio.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-rtc.c (100%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-spi.c (99%)
 rename arch/arm/{plat-s3c64xx => mach-s3c64xx}/dev-uart.c (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/spi-clocks.h (89%)

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 103bed4..129f0a8 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -33,3 +33,10 @@ obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
 obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
 obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
 obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
+
+# device support
+
+obj-y				+= dev-uart.o
+obj-y				+= dev-rtc.o
+obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
+obj-$(CONFIG_SND_S3C24XX_SOC)	+= dev-audio.o
diff --git a/arch/arm/plat-s3c64xx/dev-adc.c b/arch/arm/mach-s3c64xx/dev-adc.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-adc.c
rename to arch/arm/mach-s3c64xx/dev-adc.c
diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-audio.c
rename to arch/arm/mach-s3c64xx/dev-audio.c
diff --git a/arch/arm/plat-s3c64xx/dev-rtc.c b/arch/arm/mach-s3c64xx/dev-rtc.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-rtc.c
rename to arch/arm/mach-s3c64xx/dev-rtc.c
diff --git a/arch/arm/plat-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
similarity index 99%
rename from arch/arm/plat-s3c64xx/dev-spi.c
rename to arch/arm/mach-s3c64xx/dev-spi.c
index 0c20d27..29c32d0 100644
--- a/arch/arm/plat-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -17,8 +17,8 @@
 #include <mach/map.h>
 #include <mach/gpio.h>
 #include <mach/gpio-bank-c.h>
+#include <mach/spi-clocks.h>
 
-#include <plat/spi-clocks.h>
 #include <plat/s3c64xx-spi.h>
 #include <plat/gpio-cfg.h>
 #include <plat/irqs.h>
diff --git a/arch/arm/plat-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
similarity index 100%
rename from arch/arm/plat-s3c64xx/dev-uart.c
rename to arch/arm/mach-s3c64xx/dev-uart.c
diff --git a/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h b/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
similarity index 89%
rename from arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
rename to arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
index 524bdae..9d0c43b 100644
--- a/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
+++ b/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/spi-clocks.h
  *
  * Copyright (C) 2009 Samsung Electronics Ltd.
  *	Jaswinder Singh <jassi.brar@samsung.com>
diff --git a/arch/arm/plat-s3c64xx/Makefile b/arch/arm/plat-s3c64xx/Makefile
index 3e52dcd..d7852ba 100644
--- a/arch/arm/plat-s3c64xx/Makefile
+++ b/arch/arm/plat-s3c64xx/Makefile
@@ -11,9 +11,6 @@ obj-n				:= dummy.o
 obj-				:=
 
 # Core files
-
-obj-y				+= dev-uart.o
-obj-y				+= dev-rtc.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= gpiolib.o
@@ -33,15 +30,9 @@ obj-$(CONFIG_PM)		+= sleep.o
 
 obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
-# ADC support
-
-obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
-
 # Device setup
 
 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
-obj-$(CONFIG_SND_S3C24XX_SOC) += dev-audio.o
-obj-$(CONFIG_SPI_S3C64XX) += dev-spi.o
-- 
1.6.0.4
