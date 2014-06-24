From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 15:57:09 +0200
Subject: [PATCH 0/6] Various Samsung fixes for v3.16-rc3
Message-ID: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series inteds to fix various issues spotted while testing v3.16-rc2.
The patches should be reasonably independent from each other and so could be
picked to respective trees. See descriptions of individual patches for more
information.

Tested on Exynos4412-based Trats2 and Exynos4210-based Trats boards.

AFAIK there is no need to backport those fixes to stable.

Tomasz Figa (6):
  mmc: sdhci-s3c: Fix local I/O clock gating
  ARM: EXYNOS: Fix core ID used by platsmp and hotplug code
  clk: samsung: exynos4: Remove SRC_MASK_ISP gates
  ARM: SAMSUNG: Restore Samsung PM Debug functionality
  ARM: EXYNOS: Fix suspend/resume sequencies
  ARM: EXYNOS: Register cpuidle device only on Exynos4210 and 5250

 arch/arm/mach-exynos/exynos.c     |  6 ++----
 arch/arm/mach-exynos/hotplug.c    | 10 ++++++----
 arch/arm/mach-exynos/platsmp.c    | 34 +++++++++++++++++++---------------
 arch/arm/mach-exynos/pm.c         | 20 ++++----------------
 arch/arm/plat-samsung/Kconfig     |  8 +++++++-
 arch/arm/plat-samsung/pm-debug.c  |  1 +
 drivers/clk/samsung/clk-exynos4.c | 16 ++++------------
 drivers/mmc/host/sdhci-s3c.c      | 17 ++++++++++-------
 8 files changed, 53 insertions(+), 59 deletions(-)

-- 
1.9.3
