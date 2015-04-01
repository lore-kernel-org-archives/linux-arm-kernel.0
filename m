From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 02 Apr 2015 03:17:33 +0900
Subject: [GIT PULL 5/5] Samsung mach updates for v4.1
Message-ID: <551C363D.3040207@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-updates

for you to fetch changes up to bd0d888c4f7f125b7c7168f51039142150d9d1cc:

  ARM: EXYNOS: allow cpuidle driver usage on Exynos3250 SoC (2015-03-27
02:35:52 +0900)

----------------------------------------------------------------
Samsung mach updates for v4.1

- for s3c64xx
  : use fixed IRQ bases to avoid conflicts on Cragganmore

- for exynos3250
  : add cpuidle and AFTR mode support
  : fix CPU1 hotplug

- for exynos SoCs
  : add code for setting/clearing boot flag for cpuidle AFTR
  : remove left over 'extra_save' and constify 'exynos_pm_data' array
  : use static in suspend.c as per compiler suggestions
  : use platform device name as power domain name
  : add support for async-bridge clocks for pm_domains (exynos5420)

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: EXYNOS: add support for async-bridge clocks for pm_domains

Bartlomiej Zolnierkiewicz (4):
      ARM: EXYNOS: fix CPU1 hotplug on Exynos3250
      ARM: EXYNOS: add code for setting/clearing boot flag
      ARM: EXYNOS: add AFTR mode support for Exynos3250
      ARM: EXYNOS: allow cpuidle driver usage on Exynos3250 SoC

Charles Keepax (1):
      ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on Cragganmore

Krzysztof Kozlowski (4):
      ARM: EXYNOS: Use platform device name as power domain name
      ARM: EXYNOS: use static in suspend.c
      ARM: EXYNOS: Constify exynos_pm_data array
      ARM: EXYNOS: Remove left over 'extra_save'

 arch/arm/mach-exynos/common.h         |  6 ++++++
 arch/arm/mach-exynos/exynos.c         |  1 +
 arch/arm/mach-exynos/firmware.c       | 33
++++++++++++++++++++++++++++++++-
 arch/arm/mach-exynos/platsmp.c        | 23 ++++++++++++++++++++---
 arch/arm/mach-exynos/pm.c             | 12 +++++++++++-
 arch/arm/mach-exynos/pm_domains.c     | 29 ++++++++++++++++++++++++-----
 arch/arm/mach-exynos/regs-pmu.h       |  3 +++
 arch/arm/mach-exynos/smc.h            |  9 +++++++++
 arch/arm/mach-exynos/suspend.c        | 22 ++++++----------------
 arch/arm/mach-s3c64xx/crag6410.h      |  1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c |  1 +
 11 files changed, 114 insertions(+), 26 deletions(-)
