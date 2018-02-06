From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 6 Feb 2018 18:27:51 +0530
Subject: [PATCH v2 00/15] dra7: mmc: Update mmc dt node
Message-ID: <20180206125806.19350-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous version of the patch series was sent with subject
ARM: dra7/k2g: Use sdhci-omap for MMC/SD controller

This series
  *) Adds missing vqmmc-supply property
  *) Adds pinctrl data (including IOdelay) for dra76
  *) Updates pinctrl data (to select pull down for mmc1_clk) on some of the
     platforms
  *) Uses sdhci-omap programming model (depends on [1])

Changes from v1:
  *) Avoid defining duplicate pinctrl groups.
  *) Remove keystone specific patches
  *) Add vqmmc-supply and remove mm specific pinmux in dra7-evm

"ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node" patch
can be merged only after [1]. Other patches don't have dependency.

The defconfig patches should be merged before
"ARM: dts: dra7: Use sdhci-omap programming model"

[1] -> https://lkml.org/lkml/2018/2/5/230

Kishon Vijay Abraham I (11):
  ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
  ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
  ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra7-evm: Remove mmc specific pinmux
  ARM: dts: dra7-evm: Add "vqmmc-supply" property for mmc2
  ARM: dts: am57xx-idk: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra76-evm: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra71-evm: Select pull down for mmc1_clk line in default
    mode
  ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default
    mode
  ARM: dts: dra7: Use sdhci-omap programming model
  ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node

Ravikumar Kattekola (1):
  ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Sekhar Nori (3):
  ARM: dts: dra76x: Create a common file with MMC/SD IOdelay data
  ARM: dts: dra76-evm: Shift to using common IOdelay data
  ARM: dts: dra76-evm: Add pinctrl data for higher speed MMC/SD modes

 arch/arm/boot/dts/am571x-idk.dts                |   2 +-
 arch/arm/boot/dts/am572x-idk.dts                |   3 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  14 +-
 arch/arm/boot/dts/dra7-evm.dts                  |  29 +--
 arch/arm/boot/dts/dra7.dtsi                     |  25 ++-
 arch/arm/boot/dts/dra71-evm.dts                 |  17 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   2 +-
 arch/arm/boot/dts/dra76-evm.dts                 |  53 +----
 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi       | 285 ++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig             |   1 +
 arch/arm/configs/omap2plus_defconfig            |   3 +
 12 files changed, 350 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi

-- 
2.11.0
