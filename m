From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Sep 2012 14:39:25 -0500
Subject: [PATCH] ARM: add v7 multi-platform defconfig
Message-ID: <1348774765-9420-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a v7 defconfig enabling highbank, socfpga, mvebu, and vexpress
platforms and their drivers. Most other options are left to the default.

The existing individual platform defconfigs are kept for now as they are
a bit different. In some cases, the choices look pretty arbitrary and
just copied from other defconfigs.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Dinh Nguyen <dinguyen@altera.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---

I'm not sure I have all needed drivers enabled for all platforms, so please
test and give feedback on other drivers that should be enabled.

There's a couple of fixes needed to build. The branch is available here:

git://sources.calxeda.com/kernel/linux.git defconfig

Rob

 arch/arm/configs/multi_v7_defconfig |   57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 arch/arm/configs/multi_v7_defconfig

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
new file mode 100644
index 0000000..159f75f
--- /dev/null
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -0,0 +1,57 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_ARCH_MVEBU=y
+CONFIG_MACH_ARMADA_370=y
+CONFIG_MACH_ARMADA_XP=y
+CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARCH_SOCFPGA=y
+# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_SMP=y
+CONFIG_ARM_ARCH_TIMER=y
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_HIGHPTE=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_ATA=y
+CONFIG_SATA_HIGHBANK=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_SMSC911X=y
+CONFIG_STMMAC_ETH=y
+CONFIG_SERIO_AMBAKMI=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_SI=y
+CONFIG_I2C=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI=y
+CONFIG_SPI_PL022=y
+CONFIG_GPIOLIB=y
+CONFIG_FB=y
+CONFIG_FB_ARMCLCD=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_USB=y
+CONFIG_USB_ISP1760_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_ARMMMCI=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_HIGHBANK_MC=y
+CONFIG_EDAC_HIGHBANK_L2=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PL031=y
+CONFIG_DMADEVICES=y
+CONFIG_PL330_DMA=y
-- 
1.7.9.5
