From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri,  5 Mar 2010 10:47:23 +0000
Subject: [PATCH] ARM: S3C64XX: Reintroduce unconditional build of
Message-ID: <1267786043-27064-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks' commit cf9814eb (ARM: S3C64XX: Make audio device code built
unconditionally) made the struct devices for the audio blocks in the
S3C64xx series processors be built unconditionally but this change seems
to have gone AWOL in the various Samsung platform moves this release
cycle, causing link failures with machine drivers that rely on it.

Reintroduce the change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index d1d341a..3758e15 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -57,6 +57,6 @@ obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
 
 obj-y				+= dev-uart.o
 obj-y				+= dev-rtc.o
+obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
-obj-$(CONFIG_SND_S3C24XX_SOC)	+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
-- 
1.7.0
