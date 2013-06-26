From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Jun 2013 12:13:44 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: cpuidle driver fixes
Message-ID: <1372241627-22695-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset makes ARM EXYNOS cpuidle driver work on EXYNOS4210,
prepares it for the future ARM multiplatform support and finally
moves the driver to drivers/cpuidle/.

Patches are against v3.10-rc6 (they also apply to next-20130624).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  ARM: EXYNOS: remove non-working AFTR mode support
  ARM: EXYNOS: init cpuidle driver in exynos_init_late()
  ARM: EXYNOS: move cpuidle driver to drivers/cpuidle/

 arch/arm/mach-exynos/Makefile    |   1 -
 arch/arm/mach-exynos/common.c    |   8 +-
 arch/arm/mach-exynos/common.h    |   6 ++
 arch/arm/mach-exynos/cpuidle.c   | 225 ---------------------------------------
 drivers/cpuidle/Makefile         |   3 +
 drivers/cpuidle/cpuidle-exynos.c |  92 ++++++++++++++++
 6 files changed, 105 insertions(+), 230 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-exynos.c

-- 
1.8.2.3
