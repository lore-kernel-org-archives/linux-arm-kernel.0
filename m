From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 14 Dec 2017 19:10:40 +0530
Subject: [PATCH 00/14] ARM: dra7/k2g: Use sdhci-omap for MMC/SD controller
Message-ID: <20171214134054.7749-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables sdhci-omap driver in omap2plus_defconfig/
keystone_defconfig/multi_v7_defconfig and also modifies the dts
file to use sdhci-omap. Switching to sdhci-omap is required to
support high speed modes like UHS and HS200.

This series should be merged only after [1]

[1] -> https://lkml.org/lkml/2017/12/14/269

The sdhci-omap patches and the dt patches are also pushed to
https://github.com/kishon/linux-wip.git sdhci_omap_uhs

Kishon Vijay Abraham I (10):
  ARM: multi_v7_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
  ARM: omap2plus_defconfig: Enable CONFIG_MMC_SDHCI_OMAP
  ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
  ARM: dts: am57xx-beagle-x15: Add "vqmmc-supply" property for mmc2
  ARM: dts: am57xx-idk: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra76-evm: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra71-evm: Select pull down for mmc1_clk line in default
    mode
  ARM: dts: am57xx-idk: Select pull down for mmc1_clk line in default
    mode
  ARM: dts: dra7: Use sdhci-omap programming model
  ARM: dts: keystone-k2g: Use sdhci-omap programming model

Ravikumar Kattekola (1):
  ARM: dts: dra71-evm: Correct evm_sd regulator max voltage

Sekhar Nori (3):
  ARM: dts: dra76x: Create a common file with MMC/SD IOdelay data
  ARM: dts: dra76-evm: Shift to using common IOdelay data
  ARM: dts: dra76-evm: Add pinctrl data for higher speed MMC/SD modes

 arch/arm/boot/dts/am571x-idk.dts                |   2 +-
 arch/arm/boot/dts/am572x-idk.dts                |   2 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |   4 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  14 +-
 arch/arm/boot/dts/dra7-evm.dts                  |   1 +
 arch/arm/boot/dts/dra7.dtsi                     |  25 +-
 arch/arm/boot/dts/dra71-evm.dts                 |  17 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   2 +-
 arch/arm/boot/dts/dra76-evm.dts                 |  53 +--
 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi       | 435 ++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi             |  13 +-
 arch/arm/configs/keystone_defconfig             |   3 +
 arch/arm/configs/multi_v7_defconfig             |   1 +
 arch/arm/configs/omap2plus_defconfig            |   3 +
 14 files changed, 505 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi

-- 
2.11.0
