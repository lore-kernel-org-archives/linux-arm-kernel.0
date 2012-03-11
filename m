From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 11 Mar 2012 00:32:16 -0800
Subject: [GIT PULL v2] Samsung cleanup EXYNOS clock for v3.4
Message-ID: <4F5C6310.5010402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I rebased cleanup-exynos-clock on top of cleanup-use-static as per 
Olof's suggestion.

Please pull it from:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-exynos-clock

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit c15a04338b5a6d4305d107a5b6c0cd43418b7f3e:

   Merge branch 'next/cleanup-use-static' into next/cleanup-exynos-clock 
(2012-03-10 22:21:36 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-exynos-clock

Jaecheol Lee (1):
       ARM: EXYNOS: add clock registers for exynos4x12-cpufreq

Kukjin Kim (4):
       ARM: EXYNOS: replace clock.c for other new EXYNOS SoCs
       ARM: EXYNOS: use static declaration on regarding clock
       ARM: EXYNOS: change the prefix S5P_ to EXYNOS4_ for clock
       PM / devfreq: update the name of EXYNOS clock register

MyungJoo Ham (2):
       PM / devfreq: update the name of EXYNOS clock registers that were 
omitted
       ARM: EXYNOS: Add clock register addresses for EXYNOS4X12 bus 
devfreq driver

  arch/arm/mach-exynos/Makefile                     |    3 +-
  arch/arm/mach-exynos/clock-exynos4.c              | 1563 
++++++++++++++++++++
  arch/arm/mach-exynos/clock-exynos4.h              |   30 +
  arch/arm/mach-exynos/clock-exynos4210.c           |   46 +-
  arch/arm/mach-exynos/clock-exynos4212.c           |   30 +-
  arch/arm/mach-exynos/clock.c                      | 1564 
---------------------
  arch/arm/mach-exynos/common.h                     |    9 +
  arch/arm/mach-exynos/include/mach/exynos4-clock.h |   43 -
  arch/arm/mach-exynos/include/mach/regs-clock.h    |  416 +++---
  arch/arm/mach-exynos/pm.c                         |   40 +-
  drivers/devfreq/exynos4_bus.c                     |  230 ++--
  11 files changed, 2009 insertions(+), 1965 deletions(-)
  create mode 100644 arch/arm/mach-exynos/clock-exynos4.c
  create mode 100644 arch/arm/mach-exynos/clock-exynos4.h
  delete mode 100644 arch/arm/mach-exynos/clock.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/exynos4-clock.h
