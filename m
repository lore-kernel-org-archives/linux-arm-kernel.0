From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 21 Aug 2015 18:52:19 +0200
Subject: [GIT PULL 8/9] ARM: tegra: Devicetree changes for v4.3-rc1 (updated)
In-Reply-To: <1439563720-13189-9-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-9-git-send-email-thierry.reding@gmail.com>
Message-ID: <1440175939-13663-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-dt

for you to fetch changes up to 17cdddf0fb684f5456c1af3aa2c10aca3b68b8de:

  ARM: tegra: Add gpio-ranges property (2015-08-21 18:44:28 +0200)

This updated version of the pull request includes the for-4.3/clk branch
which is a build-time dependency for for-4.3/dt.

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Devicetree changes for v4.3-rc1

Enables CPU frequency scaling on Jetson TK1 and enables the GK20A GPU on
Venice2 and Jetson TK1. This also enables support for the PMU hardware
found on Tegra124, which among other things, can be used for performance
measurements.

----------------------------------------------------------------
Alexandre Courbot (2):
      ARM: tegra: Add IOMMU node to GK20A
      ARM: tegra: jetson-tk1: Add GK20A GPU DT node

Kyle Huey (1):
      ARM: tegra: Add Tegra124 PMU support

Mikko Perttunen (2):
      clk: tegra: Introduce ability for SoC-specific reset control callbacks
      ARM: tegra: Add CPU regulator to the Jetson TK1 device tree

Nicolas Chauvet (1):
      ARM: tegra: Fix AHB base address on Tegra20, Tegra30 and Tegra114

Paul Walmsley (1):
      clk: tegra: Add DFLL DVCO reset control for Tegra124

Thierry Reding (3):
      Merge branch 'for-4.3/pinctrl' into for-4.3/dt
      Merge branch 'for-4.3/clk' into for-4.3/dt
      ARM: tegra: venice2: Add GK20A GPU DT node

Tomeu Vizoso (2):
      pinctrl: tegra: Only set the gpio range if needed
      ARM: tegra: Add gpio-ranges property

Tuomas Tynkkynen (10):
      clk: tegra: Add binding for the Tegra124 DFLL clocksource
      clk: tegra: Add library for the DFLL clock source (open-loop mode)
      clk: tegra: Add closed loop support for the DFLL
      clk: tegra: Add functions for parsing CVB tables
      clk: tegra: Add Tegra124 DFLL clocksource platform driver
      clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
      clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
      ARM: tegra: Add the DFLL to Tegra124 device tree
      ARM: tegra: Enable the DFLL on the Jetson TK1
      ARM: tegra: Add entries for cpufreq on Tegra124

 .../bindings/clock/nvidia,tegra124-dfll.txt        |   79 +
 arch/arm/boot/dts/tegra114.dtsi                    |    5 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   25 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |   10 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   50 +
 arch/arm/boot/dts/tegra20.dtsi                     |    5 +-
 arch/arm/boot/dts/tegra30.dtsi                     |    5 +-
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/clk/tegra/Makefile                         |    3 +
 drivers/clk/tegra/clk-dfll.c                       | 1755 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   54 +
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  166 ++
 drivers/clk/tegra/clk-tegra124.c                   |   82 +
 drivers/clk/tegra/clk.c                            |   39 +-
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/clk/tegra/cvb.c                            |  140 ++
 drivers/clk/tegra/cvb.h                            |   67 +
 drivers/pinctrl/pinctrl-tegra.c                    |   19 +-
 include/dt-bindings/reset/tegra124-car.h           |   12 +
 20 files changed, 2505 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 include/dt-bindings/reset/tegra124-car.h
