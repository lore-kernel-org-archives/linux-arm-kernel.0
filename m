From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 Jan 2014 18:20:21 +0000
Subject: [PATCH V2 2/2] ARM: multi_v7_defconfig: add mvebu drivers
In-Reply-To: <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
References: <1390871129-4838-1-git-send-email-jason@lakedaemon.net>
 <14397edee7978df1d80e048d7cd02c826a91af56.1390932990.git.jason@lakedaemon.net>
Message-ID: <efc85572ea408242a605d4181498b7267f52320a.1390932990.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent boot farm testing has highlighted some issues with mvebu and
multiplatform kernels.  Increase the test coverage so we can discover
these issues earlier.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
v1 -> v2:
 - updating the defconfig is a separate patch from this.

 arch/arm/configs/multi_v7_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1e37e862baea..37133d9c960b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -44,6 +44,9 @@ CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_MVEBU=y
 CONFIG_SMP=y
 CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
@@ -64,9 +67,11 @@ CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_SUN4I_EMAC=y
 CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_MVNETA=y
 CONFIG_KS8851=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
+CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
@@ -89,10 +94,12 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
 CONFIG_SPI=y
 CONFIG_SPI_OMAP24XX=y
+CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_SIRF=y
 CONFIG_SPI_TEGRA114=y
@@ -100,6 +107,8 @@ CONFIG_SPI_TEGRA20_SLINK=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_TWL4030=y
+CONFIG_THERMAL=y
+CONFIG_ARMADA_THERMAL=y
 CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_TPS51632=y
@@ -136,6 +145,7 @@ CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_SPEAR=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_MVSDIO=y
 CONFIG_EDAC=y
 CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
@@ -144,9 +154,11 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_VT8500=y
+CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
+CONFIG_MV_XOR=y
 CONFIG_TEGRA20_APB_DMA=y
 CONFIG_STE_DMA40=y
 CONFIG_SIRF_DMA=y
@@ -155,6 +167,7 @@ CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
 CONFIG_MXS_DMA=y
 CONFIG_DMA_OMAP=y
+CONFIG_MEMORY=y
 CONFIG_PWM=y
 CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
-- 
1.8.5.3
