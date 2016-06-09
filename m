From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Jun 2016 09:10:06 +0200
Subject: [PATCH 00/12]  Add SDHCI Xenon driver
Message-ID: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds support for the SDHCI Xenon controller which can be
found on the Armada 37xx and the Armada 7K/8K.

This series currently only enables the support on the Armada 37xx SoCs
and boards. More tests are needed to enable it on the A7K/A8K.

Following the new trend for the MMC subsystem, instead of introducing
new quirks for this controller we extend the mmc/sdhci framework by
adding callbacks when needed.

Thanks,

Gregory

Gregory CLEMENT (7):
  mmc: sdhci_f_sdh30: restrict voltage_switch() callback to the 1.8V
    case
  mmc: tegra: restrict the voltage_switch() callback to the 1.8V case
  mmc: core: export the alive operation
  dt-bindings: mmc: Add Xenon description
  arm64: dts: marvell: add eMMC support for Armada 37xx
  arm64: dts: marvell: add SDIO support for Armada 37xx
  arm64: defconfig: Add Xenon sdhci

Marcin Wojtas (1):
  mmc: sdhci: add init_card callback to sdhci

Victor Gu (4):
  mmc: sdhci: call voltage_switch callback also for the 3.3V case
  mmc: sdhci: add a pre voltage switch callback function
  mmc: sdhci: add delay adjust feature including phy reset
  mmc: sdhci-xenon: add initial Xenon eMMC driver

 .../devicetree/bindings/mmc/sdhci-xenon.txt        |   27 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   12 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   17 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/mmc/core/core.c                            |    7 +
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci-tegra.c                     |    4 +
 drivers/mmc/host/sdhci-xenon.c                     | 1164 ++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   20 +
 drivers/mmc/host/sdhci.h                           |    3 +
 drivers/mmc/host/sdhci_f_sdh30.c                   |    4 +
 include/linux/mmc/card.h                           |    1 +
 13 files changed, 1271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon.c

-- 
2.5.0
