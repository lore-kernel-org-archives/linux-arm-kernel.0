From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 30 Oct 2012 12:35:22 +0530
Subject: [PATCH V3 0/4] ARM: tegra: Enable SLINK controller driver
Message-ID: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series modify the dts file to add the slink addresses,
make AUXDATA in board dt files, enable slink4 for tegra30-cardhu and 
enable slink controller defconfig.

Changes from V1: 
- Remove changes from clock tables.
- Make the dma req dt property name to nvidia,dma-request-selector.
- change the spi max frequency prop to spi-max-frequency.

Changes from V2:
- make node name to spi.
- get rid of iomap.h.

Laxman Dewangan (4):
  ARM: tegra: dts: add slink controller dt entry
  ARM: tegra: Add OF_DEV_AUXDATA for SLINK driver in board dt
  ARM: tegra: dts: cardhu: enable SLINK4
  ARM: tegra: config: enable spi driver for Tegra SLINK controller

 arch/arm/boot/dts/tegra20.dtsi         |   41 ++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |    5 +++
 arch/arm/boot/dts/tegra30.dtsi         |   60 ++++++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig       |    2 +-
 arch/arm/mach-tegra/board-dt-tegra20.c |    8 ++++
 arch/arm/mach-tegra/board-dt-tegra30.c |   12 ++++++
 6 files changed, 127 insertions(+), 1 deletions(-)
