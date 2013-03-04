From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:39:28 +0800
Subject: [PATCH 00/10] ARM: tegra: add platform suspend support
Message-ID: <1362397168-5345-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces a basic functionality for Tegra to support the
platform suspend and resume.

Verified on Seaboard and Cardhu.

Joseph Lo (10):
  gpio: tegra: add gpio wakeup source handling
  ARM: tegra: irq: add wake up handling
  ARM: tegra: get power management configurations for PMC from DT
  ARM: tegra: pm: add platform suspend support
  ARM: dt: tegra: add bindings of power management configurations for
    PMC
  ARM: dts: tegra: add the PM configurations of PMC
  ARM: dts: tegra: add power gpio keys to DT
  ARM: dts: tegra: whistler: add wakeup source for KBC
  ARM: dts: tegra: add non-removable and keep-power-in-suspend property
    for MMC
  ARM: tegra: config: defconfig update

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  45 +++++++-
 arch/arm/boot/dts/tegra20-harmony.dts              |  17 +++
 arch/arm/boot/dts/tegra20-paz00.dts                |   8 ++
 arch/arm/boot/dts/tegra20-seaboard.dts             |   8 ++
 arch/arm/boot/dts/tegra20-trimslice.dts            |  20 ++++
 arch/arm/boot/dts/tegra20-ventana.dts              |  19 +++
 arch/arm/boot/dts/tegra20-whistler.dts             |  10 ++
 arch/arm/boot/dts/tegra30-beaver.dts               |   8 ++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts           |   1 +
 arch/arm/boot/dts/tegra30-cardhu-a04.dts           |   1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   8 ++
 arch/arm/configs/tegra_defconfig                   |   1 +
 arch/arm/mach-tegra/common.c                       |   3 +
 arch/arm/mach-tegra/irq.c                          |  95 ++++++++++++++-
 arch/arm/mach-tegra/irq.h                          |   6 +
 arch/arm/mach-tegra/pm.c                           |  75 ++++++++++++
 arch/arm/mach-tegra/pm.h                           |   2 +
 arch/arm/mach-tegra/pmc.c                          | 128 +++++++++++++++++++++
 arch/arm/mach-tegra/pmc.h                          |  16 +++
 drivers/gpio/gpio-tegra.c                          |  21 +++-
 20 files changed, 488 insertions(+), 4 deletions(-)

-- 
1.8.1.1
