From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 18 Mar 2015 13:51:49 +0100
Subject: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
 Exynos3250
Message-ID: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for AFTR idle mode on boards with
Exynos3250 SoC and allows EXYNOS cpuidle driver usage on these
boards.

It has been tested on Samsung Rinato board (Gear 2).

Depends on:
- for-next branch (commit: 77105c882ba6) of linux-samsung.git
  kernel tree

Changes since v2:
- rebased on top of for-next branch (commit: 77105c882ba6) of
  linux-samsung.git kernel tree

Changes since v1:
- rebased on top of for-next branch (commit: ce275c369a0b) of
  linux-samsung.git kernel tree
- fixed lockup on hotplug by using dsb_sev() instead of IPI in
  exynos_boot_secondary() on Exynos3250

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on Exynos3250
  ARM: EXYNOS: add code for setting/clearing boot flag
  ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC

 arch/arm/mach-exynos/common.h   |  6 ++++++
 arch/arm/mach-exynos/exynos.c   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/firmware.c |  8 +++++++-
 arch/arm/mach-exynos/platsmp.c  | 23 ++++++++++++++++++++---
 arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
 arch/arm/mach-exynos/regs-pmu.h |  3 +++
 arch/arm/mach-exynos/smc.h      |  9 +++++++++
 7 files changed, 82 insertions(+), 5 deletions(-)

-- 
1.8.2.3
