From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 3 Jan 2012 10:34:11 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120103103411.85d160181f361e73f11c401b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-s3c64xx/Makefile between commit b024043b6d0d ("ARM: 7245/1:
S3C64XX: introduce arch/arm/mach-s3c64xx/common.[ch]") from the arm tree
and commits a60879e7ca17 ("ARM: SAMSUNG: Remove SDHCI bus clocks from
platform data"), 875a59374cd1 ("ARM: SAMSUNG: Consolidation of SPI
platform devices to plat-samsung") and 4566c7f7612f ("ARM: S3C64XX:
Modified files for SPI consolidation work") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-s3c64xx/Makefile
index f37016c,d7d9bb5..0000000
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@@ -27,21 -26,21 +27,20 @@@ obj-$(CONFIG_PM)		+= pm.o irq-pm.o slee
  
  obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
  
 -# Device setup
 +# Device support
  
 -obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 -obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 -obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
 -obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
 -obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 -obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
 -obj-$(CONFIG_S3C64XX_SETUP_SPI) += setup-spi.o
 +obj-y				+= dev-uart.o
 +obj-y				+= dev-audio.o
- obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
  
 -# PM
 +# Device setup
  
 -obj-$(CONFIG_PM)		+= pm.o
 -obj-$(CONFIG_PM)		+= sleep.o
 -obj-$(CONFIG_PM)		+= irq-pm.o
 +obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 +obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0.o
 +obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1.o
 +obj-$(CONFIG_S3C64XX_SETUP_IDE)		+= setup-ide.o
 +obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad.o
- obj-$(CONFIG_S3C64XX_SETUP_SDHCI)	+= setup-sdhci.o
 +obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
++obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi.o
  
  # Machine support
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120103/ad73c70e/attachment.sig>
