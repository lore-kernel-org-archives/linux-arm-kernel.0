From: ynvich@gmail.com (Sergei Ianovich)
Date: Sat, 19 Dec 2015 10:53:03 +0300
Subject: [PATCH] arm: pxa: create a unified defconfig for PXA27X-DT
In-Reply-To: <1450196875-6739-1-git-send-email-ynvich@gmail.com>
References: <1450196875-6739-1-git-send-email-ynvich@gmail.com>
Message-ID: <1450511594-12009-1-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of one defconfig file per board, pxa27x-dt_defconfig
is expected to provide a configuration for kernel which can test any
PXA27X-DT compatible board

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Robert Jarzmik <robert.jarzmik@free.fr>
CC: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/arm/pxa/pxa27x_defconfig.txt |   7 ++
 arch/arm/configs/pxa27x-dt_defconfig       | 102 +++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/arm/pxa/pxa27x_defconfig.txt
 create mode 100644 arch/arm/configs/pxa27x-dt_defconfig

diff --git a/Documentation/arm/pxa/pxa27x_defconfig.txt b/Documentation/arm/pxa/pxa27x_defconfig.txt
new file mode 100644
index 0000000..fc4e164
--- /dev/null
+++ b/Documentation/arm/pxa/pxa27x_defconfig.txt
@@ -0,0 +1,7 @@
+If you are reading this, because you are adding support for a new
+PXA27X board, please note that you should not create an additional
+defconfig in arch/arm/configs.
+
+Instead, please update arch/arm/configs/pxa27x-dt_defconfig so that
+a kernel built with this config after `make olddefconfig` boots your
+board.
diff --git a/arch/arm/configs/pxa27x-dt_defconfig b/arch/arm/configs/pxa27x-dt_defconfig
new file mode 100644
index 0000000..003be48
--- /dev/null
+++ b/arch/arm/configs/pxa27x-dt_defconfig
@@ -0,0 +1,102 @@
+## Kernel built with this config should boot any supported PXA27X-DT board
+## Please see Documentation/arm/pxa/pxa27x_defconfig.txt for details
+##
+CONFIG_ARM=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EMBEDDED=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_BLK_CMDLINE_PARSER=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARCH_PXA=y
+CONFIG_MACH_PXA27X_DT=y
+CONFIG_PXA_SYSTEMS_CPLDS=y
+CONFIG_PXA_SSP=y
+CONFIG_CPU_FREQ=y
+CONFIG_ARM_PXA2xx_CPUFREQ=y
+CONFIG_NET=y
+CONFIG_IRDA=y
+CONFIG_PXA_FICP=y
+CONFIG_MTD=y
+CONFIG_MTD_OF_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PXA2XX=y
+CONFIG_OF=y
+CONFIG_OF_FLATTREE=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_PMP=y
+CONFIG_ATA_SFF=y
+CONFIG_ATA_BMDMA=y
+CONFIG_PATA_PXA=y
+CONFIG_NETDEVICES=y
+CONFIG_DM9000=y
+CONFIG_INPUT=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_PXA27x=y
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_NAVPOINT_PXA27x=y
+CONFIG_TTY=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=40
+CONFIG_SERIAL_8250_RUNTIME_UARTS=40
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_PXA=y
+CONFIG_I2C=y
+CONFIG_I2C_GPIO=y
+CONFIG_I2C_PXA=y
+CONFIG_SPI=y
+CONFIG_SPI_PXA2XX=y
+CONFIG_WATCHDOG=y
+CONFIG_SA1100_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_VIDEO_DEV=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_VIDEO_PXA27x=y
+CONFIG_FB=y
+CONFIG_FB_PXA=y
+CONFIG_FB_PXA_OVERLAY=y
+CONFIG_FB_PXA_SMARTPANEL=y
+CONFIG_FB_PXA_PARAMETERS=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_ARM=y
+CONFIG_SND_PXA2XX_AC97=y
+CONFIG_SND_SOC=y
+CONFIG_SND_PXA2XX_SOC=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PXA27X=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_SERIAL=y
+CONFIG_MMC=y
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_PXA=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PXA=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_OF=y
+CONFIG_PXA_DMA=y
+CONFIG_PWM=y
+CONFIG_PWM_PXA=y
+CONFIG_EXT4_FS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
-- 
2.6.3
