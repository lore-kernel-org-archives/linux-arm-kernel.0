From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 14 Aug 2015 16:48:39 +0200
Subject: [GIT PULL 8/9] ARM: tegra: Devicetree changes for v4.3-rc1
In-Reply-To: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1439563720-13189-9-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-dt

for you to fetch changes up to 6909c6632fdbea441b5077b4f882c0bf4b71997e:

  ARM: tegra: Add gpio-ranges property (2015-08-13 16:31:53 +0200)

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

Mikko Perttunen (1):
      ARM: tegra: Add CPU regulator to the Jetson TK1 device tree

Nicolas Chauvet (1):
      ARM: tegra: Fix AHB base address on Tegra20, Tegra30 and Tegra114

Thierry Reding (2):
      Merge branch 'for-4.3/pinctrl' into for-4.3/dt
      ARM: tegra: venice2: Add GK20A GPU DT node

Tomeu Vizoso (2):
      pinctrl: tegra: Only set the gpio range if needed
      ARM: tegra: Add gpio-ranges property

Tuomas Tynkkynen (3):
      ARM: tegra: Add the DFLL to Tegra124 device tree
      ARM: tegra: Enable the DFLL on the Jetson TK1
      ARM: tegra: Add entries for cpufreq on Tegra124

 arch/arm/boot/dts/tegra114.dtsi           |  5 ++--
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 25 ++++++++++++++--
 arch/arm/boot/dts/tegra124-venice2.dts    | 10 ++++++-
 arch/arm/boot/dts/tegra124.dtsi           | 50 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi            |  5 ++--
 arch/arm/boot/dts/tegra30.dtsi            |  5 ++--
 drivers/pinctrl/pinctrl-tegra.c           | 19 +++++++++++-
 7 files changed, 109 insertions(+), 10 deletions(-)
