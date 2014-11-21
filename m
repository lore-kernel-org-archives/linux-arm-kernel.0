From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 21 Nov 2014 23:16:27 +0900
Subject: [GIT PULL 5/5] Samsung exynos updates for v3.19
Message-ID: <546F493B.50605@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b5d841a2bfce65881d518e3c27437c530460f1c4:

  Merge branch 'v3.19-next/non-critical-fixes' into
v3.19-next/mach-exynos (2014-11-21 22:49:27 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-exynos-v3.19

for you to fetch changes up to c645a598f99768e6cc82129081458dfdd0c273b7:

  ARM: EXYNOS: Call regulator core suspend prepare and finish functions
(2014-11-21 22:49:47 +0900)

----------------------------------------------------------------
Samsung exynos updates in arch/arm/mach-exynos/ for v3.19

- add SOC_EXYNOS4415 config to be used in audio driver
- add support platform driver for exynos PMU
- move PMU specific definitions from common.h to exynos-pmu.h
- for exynos5420, add support PMU and Suspend-to-RAM
  use MCPM call backs and call regulator core suspend prepare
  and finish functions

NOTE:
including v3.19-next/non-critical-fixes, v3.19-next/cleanup-samsung
and v3.19-next/pm-samsung-2 branches

----------------------------------------------------------------
Abhilash Kesavan (2):
      ARM: EXYNOS: Add PMU support for exynos5420
      ARM: EXYNOS: Use MCPM call-backs to support S2R on exynos5420

Chanwoo Choi (1):
      ARM: EXYNOS: Add support for exynos4415 SoC

Javier Martinez Canillas (1):
      ARM: EXYNOS: Call regulator core suspend prepare and finish functions

Pankaj Dubey (2):
      ARM: EXYNOS: Add platform driver support for Exynos PMU
      ARM: EXYNOS: Move PMU specific definitions from common.h

Vikas Sajjan (1):
      ARM: EXYNOS: Add Suspend-to-RAM support for exynos5420

 arch/arm/mach-exynos/Kconfig       |   6 +
 arch/arm/mach-exynos/common.h      |  17 --
 arch/arm/mach-exynos/exynos-pmu.h  |  24 ++
 arch/arm/mach-exynos/exynos.c      |   2 +
 arch/arm/mach-exynos/mcpm-exynos.c |  32 ++-
 arch/arm/mach-exynos/platsmp.c     |  12 +
 arch/arm/mach-exynos/pm.c          |   1 +
 arch/arm/mach-exynos/pmu.c         | 478
+++++++++++++++++++++++++++++++++----
 arch/arm/mach-exynos/regs-pmu.h    | 227 ++++++++++++++++++
 arch/arm/mach-exynos/suspend.c     | 220 ++++++++++++++++-
 10 files changed, 944 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-exynos/exynos-pmu.h
