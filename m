From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 27 May 2014 10:04:28 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Zynq peripheral drivers
Message-ID: <1401210268-20729-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few drivers for Zynq peripherals made it into mainline recently.
Enable them in the defconfig. The following devices are enabled:
 - Cadence Macb Ethernet controller
 - Cadence I2C controller
 - Arasan SDHCI

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
After quite a while I gave the defonfig a shot again. At first try it
directly booted my Zynq board to a usable login prompt, and with this
patch even some peripherals work out of the box.

	Thanks,
	S?ren
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d4e8a47a2f7c..763054810ccf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -121,6 +121,7 @@ CONFIG_SATA_HIGHBANK=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
+CONFIG_MACB=y
 CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
@@ -175,6 +176,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_MUX_PINCTRL=y
+CONFIG_I2C_CADENCE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
@@ -272,6 +274,7 @@ CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_OF_ARASAN=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_DOVE=y
-- 
1.9.3.1.ga73a6ad
