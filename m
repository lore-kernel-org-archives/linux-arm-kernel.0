From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 18 Oct 2012 16:26:30 +0530
Subject: [PATCH 0/5] ARM: tegra: Enable SLINK controller driver
Message-ID: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series modify the dts file to add the slink addresses,
make entry of slink in clock tables, defines SLINK addressed,
enable slink controller in Tegra30 based platform cardhu.

Laxman Dewangan (5):
  ARM: tegra: Add slink controller base address
  ARM: tegra: dts: add slink controller dt entry
  ARM: tegra: fix clock entry of slink controller
  ARM: tegra: dts: cardhu: enable SLINK4
  ARM: tegra: config: enable spi driver for Tegra SLINK controller

 arch/arm/boot/dts/tegra20.dtsi            |   40 +++++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi     |    5 ++
 arch/arm/boot/dts/tegra30.dtsi            |   60 +++++++++++++++++++++++++++++
 arch/arm/configs/tegra_defconfig          |    2 +-
 arch/arm/mach-tegra/board-dt-tegra20.c    |    8 ++++
 arch/arm/mach-tegra/board-dt-tegra30.c    |   12 ++++++
 arch/arm/mach-tegra/include/mach/iomap.h  |   22 +++++++----
 arch/arm/mach-tegra/tegra20_clocks_data.c |   16 ++++----
 arch/arm/mach-tegra/tegra30_clocks_data.c |   36 +++++++++---------
 9 files changed, 166 insertions(+), 35 deletions(-)
