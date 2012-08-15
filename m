From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 15 Aug 2012 17:22:28 +0800
Subject: [PATCH V2 0/6] ARM: tegra: add CPU hotplug support
Message-ID: <1345022554-26292-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds CPU hotplug support for Tegra20 and Tegra30 SoCs.

The first 3 patches make the CPU clock and reset control be a module and
the abstraction APIs for TegraXX SoCs. And clean up some codes for later
usage. Then add CPU hotplug support for Tegra20 and Tegra30.

Verified on Seaboard(Tegra20) and Cardhu(Tegra30)

V2:
* add one more patch for enable HOTPLUG_CPU [6/6]
* move all the SoC specific CPU shutdown code into platform_cpu_die [4/6]

Joseph Lo (6):
  ARM: tegra: introduce tegra_cpu_car_ops structures
  ARM: tegra: replace the CPU CAR access code by tegra_cpu_car_ops
  ARM: tegra: clean up the common assembly macros into sleep.h
  ARM: tegra30: add CPU hotplug support
  ARM: tegra20: add CPU hotplug support
  ARM: tegra: defconfig: enable HOTPLUG_CPU

 arch/arm/configs/tegra_defconfig          |    1 +
 arch/arm/mach-tegra/Makefile              |    2 +
 arch/arm/mach-tegra/clock.c               |    4 +
 arch/arm/mach-tegra/common.c              |    3 +
 arch/arm/mach-tegra/headsmp.S             |    6 +-
 arch/arm/mach-tegra/hotplug.c             |  118 ++++++++---------------------
 arch/arm/mach-tegra/platsmp.c             |   29 +------
 arch/arm/mach-tegra/sleep-t20.S           |   82 ++++++++++++++++++++
 arch/arm/mach-tegra/sleep-t30.S           |  107 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S               |   33 +--------
 arch/arm/mach-tegra/sleep.h               |   80 +++++++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks.c      |   70 +++++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks_data.c |    2 +
 arch/arm/mach-tegra/tegra30_clocks.c      |   72 +++++++++++++++++
 arch/arm/mach-tegra/tegra30_clocks_data.c |    3 +
 arch/arm/mach-tegra/tegra_cpu_car.h       |   87 +++++++++++++++++++++
 16 files changed, 552 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/mach-tegra/sleep-t20.S
 create mode 100644 arch/arm/mach-tegra/sleep-t30.S
 create mode 100644 arch/arm/mach-tegra/sleep.h
 create mode 100644 arch/arm/mach-tegra/tegra_cpu_car.h
