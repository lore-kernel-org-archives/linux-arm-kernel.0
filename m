From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:37 -0700
Subject: [GIT PULL 6/8] ARM: tegra: add Tegra114 SoC support
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-6-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull request adds initial support for the Tegra114 SoC, which
integrates a quad-core ARM Cortex-A15 CPU. I'm proud to observe that we
posted the initial versions of these patches before the final official
announcement of this chip.

These patches are enough to boot with a UART-based console, support the
Dalmore and Pluto reference/evaluation boards, instantiate the GPIO and
pinctrl drivers, and enable a cpuidle state. As yet, no clocks or
storage devices are supported, but patches for those will follow shortly.

This pull request is based on (most of) the previous pull request with
tag tegra-for-3.9-soc-cpuidle, followed by a merge of the previous pull
request with tag tegra-for-3.9-scu-base-rework.

----------------------------------------------------------------

The following changes since commit ee059485175b21079d3639f167980d354afb3d4b:

  Merge branch 'for-3.9/scu-base-rework' into for-3.9/soc-t114

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-soc-t114

for you to fetch changes up to 031b77afc374cf1b86dbcda5dfa6e1bbb989836c:

  ARM: DT: tegra114: add pinmux DT entry

----------------------------------------------------------------

Hiroshi Doyu (7):
      ARM: tegra: fuse: Add chip ID Tegra114 0x35
      ARM: dt: tegra114: Add new SoC base, Tegra114 SoC
      ARM: dt: tegra114: Add new board, Dalmore
      ARM: dt: tegra114: Add new board, Pluto
      ARM: tegra: Add initial support for Tegra114 SoC.
      ARM: tegra: add AHB entry to Tegra114 DT
      ARM: tegra: Add SMMU entry to Tegra114 DT

Joseph Lo (1):
      ARM: tegra: add Tegra114 ARM_CPUIDLE_WFI_STATE support

Laxman Dewangan (3):
      ARM: tegra114: select PINCTRL for Tegra114 SoC
      ARM: DT: tegra114: add GPIO DT entry
      ARM: DT: tegra114: add pinmux DT entry

 arch/arm/boot/dts/Makefile              |    4 +-
 arch/arm/boot/dts/tegra114-dalmore.dts  |   21 ++++
 arch/arm/boot/dts/tegra114-pluto.dts    |   21 ++++
 arch/arm/boot/dts/tegra114.dtsi         |  153 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/Kconfig             |   12 ++
 arch/arm/mach-tegra/Makefile            |    4 +
 arch/arm/mach-tegra/board-dt-tegra114.c |   48 ++++++++
 arch/arm/mach-tegra/common.c            |    1 +
 arch/arm/mach-tegra/cpuidle-tegra114.c  |   61 ++++++++++
 arch/arm/mach-tegra/cpuidle.c           |    3 +
 arch/arm/mach-tegra/cpuidle.h           |    6 +
 arch/arm/mach-tegra/fuse.h              |    1 +
 12 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/tegra114-dalmore.dts
 create mode 100644 arch/arm/boot/dts/tegra114-pluto.dts
 create mode 100644 arch/arm/boot/dts/tegra114.dtsi
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra114.c
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
