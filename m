From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 10:11:54 +0900
Subject: [GIT PULL 5/5] Samsung Exynos MCPM support for 3.16
Message-ID: <014801cf73c8$7d1f9930$775ecb90$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d7067f1c5fa0232001502569c6878d22308da268:

  devicetree: bindings: document SYSRAM binding (2014-05-15 03:30:29 +0900)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/exynos-mcpm

for you to fetch changes up to ccf5511797cd4b48d20a85fa1778f5608eac9fd7:

  ARM: EXYNOS: Add MCPM call-back functions (2014-05-16 04:26:30 +0900)

----------------------------------------------------------------
Exynos MCPM support for v3.16

- adding MCPM backend support for SMP secondary boot and core switching
on Samsung's Exynos5420.

Tested on exynos5420-smdk5420 and exynos5420 based chromebook (peach-pit)
using the "/dev/b.L_switcher" user interface. Secondary core boot-up has
also been tested on both the boards.

----------------------------------------------------------------
Abhilash Kesavan (2):
      ARM: EXYNOS: Add generic cluster power control functions
      ARM: EXYNOS: Add MCPM call-back functions

Andrew Bresticker (1):
      ARM: dts: add CCI node for exynos5420

Leela Krishna Amudala (2):
      ARM: EXYNOS: Add generic cpu power control functions for exynos SoCs
      ARM: EXYNOS: use generic exynos cpu power control functions

 arch/arm/boot/dts/exynos5420.dtsi  |   27 +++
 arch/arm/mach-exynos/Kconfig       |    8 +
 arch/arm/mach-exynos/Makefile      |    2 +
 arch/arm/mach-exynos/common.h      |    6 +
 arch/arm/mach-exynos/hotplug.c     |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c |  351
++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c     |    9 +-
 arch/arm/mach-exynos/pm.c          |   66 +++++++
 arch/arm/mach-exynos/regs-pmu.h    |   16 +-
 9 files changed, 478 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c
