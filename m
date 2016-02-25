From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Feb 2016 09:16:19 +1100
Subject: linux-next: manual merge of the sunxi tree with Linus' and the
 arm-soc trees
Message-ID: <20160226091619.4568bc31@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Today's linux-next merge of the sunxi tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  531d3067314f ("arm64: defconfig: updates for 4.5")

from Linus' tree, commit:

  efdda175c07f ("arm64: defconfig: add spmi and usb related configs")

from the arm-soc tree and commit:

  22b0898e831b ("arm64: add defconfig options for Allwinner SoCs")

from the sunxi tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 894898f60925,7acadce74d4d..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -30,9 -31,10 +30,10 @@@ CONFIG_MODULES=
  CONFIG_MODULE_UNLOAD=y
  # CONFIG_BLK_DEV_BSG is not set
  # CONFIG_IOSCHED_DEADLINE is not set
+ CONFIG_ARCH_SUNXI=y
  CONFIG_ARCH_BCM_IPROC=y
  CONFIG_ARCH_BERLIN=y
 -CONFIG_ARCH_EXYNOS7=y
 +CONFIG_ARCH_EXYNOS=y
  CONFIG_ARCH_LAYERSCAPE=y
  CONFIG_ARCH_HISI=y
  CONFIG_ARCH_MEDIATEK=y
@@@ -134,22 -127,24 +135,25 @@@ CONFIG_SERIAL_TEGRA=
  CONFIG_SERIAL_SH_SCI=y
  CONFIG_SERIAL_SH_SCI_NR_UARTS=11
  CONFIG_SERIAL_SH_SCI_CONSOLE=y
 -CONFIG_SERIAL_TEGRA=y
  CONFIG_SERIAL_MSM=y
  CONFIG_SERIAL_MSM_CONSOLE=y
 -CONFIG_SERIAL_OF_PLATFORM=y
  CONFIG_SERIAL_XILINX_PS_UART=y
  CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 +CONFIG_SERIAL_MVEBU_UART=y
  CONFIG_VIRTIO_CONSOLE=y
  # CONFIG_HW_RANDOM is not set
 -CONFIG_I2C=y
+ CONFIG_I2C_CHARDEV=y
+ CONFIG_I2C_MV64XXX=y
  CONFIG_I2C_QUP=y
 +CONFIG_I2C_UNIPHIER_F=y
  CONFIG_I2C_RCAR=y
  CONFIG_SPI=y
  CONFIG_SPI_PL022=y
  CONFIG_SPI_QUP=y
 +CONFIG_SPMI=y
  CONFIG_PINCTRL_MSM8916=y
 +CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+ CONFIG_GPIO_SYSFS=y
  CONFIG_GPIO_PL061=y
  CONFIG_GPIO_RCAR=y
  CONFIG_GPIO_XGENE=y
@@@ -196,8 -179,12 +200,10 @@@ CONFIG_MMC_SDHCI=
  CONFIG_MMC_SDHCI_PLTFM=y
  CONFIG_MMC_SDHCI_TEGRA=y
  CONFIG_MMC_SPI=y
+ CONFIG_MMC_SUNXI=y
  CONFIG_MMC_DW=y
 -CONFIG_MMC_DW_IDMAC=y
 -CONFIG_MMC_DW_PLTFM=y
  CONFIG_MMC_DW_EXYNOS=y
+ CONFIG_MMC_BLOCK_MINORS=16
  CONFIG_NEW_LEDS=y
  CONFIG_LEDS_CLASS=y
  CONFIG_LEDS_SYSCON=y
@@@ -206,14 -193,12 +212,15 @@@ CONFIG_LEDS_TRIGGER_HEARTBEAT=
  CONFIG_LEDS_TRIGGER_CPU=y
  CONFIG_RTC_CLASS=y
  CONFIG_RTC_DRV_EFI=y
 +CONFIG_RTC_DRV_PL031=y
+ CONFIG_RTC_DRV_SUN6I=y
  CONFIG_RTC_DRV_XGENE=y
  CONFIG_DMADEVICES=y
 -CONFIG_RCAR_DMAC=y
  CONFIG_QCOM_BAM_DMA=y
  CONFIG_TEGRA20_APB_DMA=y
 +CONFIG_RCAR_DMAC=y
 +CONFIG_VFIO=y
 +CONFIG_VFIO_PCI=y
  CONFIG_VIRTIO_PCI=y
  CONFIG_VIRTIO_BALLOON=y
  CONFIG_VIRTIO_MMIO=y
