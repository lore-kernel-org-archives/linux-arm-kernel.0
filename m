From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 09 Jul 2014 19:17:50 +0200
Subject: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Message-ID: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for AFTR idle mode on boards with
secure firmware enabled and allows EXYNOS cpuidle driver usage on
Exynos4x12 SoCs.

It has been tested on Trats2 board (using Exynos4412 SoC with secure
firmware enabled) on which AFTR mode reduces power consumption by ~12%
when EXYNOS cpuidle driver is enabled (in both cases the default
exynos_defconfig config is used and CPU1-3 are offlined).

v3:
- rebased on top of next-20140708 +
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html
  (with rejects fixed)
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32808.html
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32991.html
  (with rejects fixed in patch #2)
- addressed review comments from Tomasz Figa and Daniel Lezcano

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
  ARM: EXYNOS: add AFTR mode support to firmware do_idle method
  ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs

 arch/arm/include/asm/firmware.h  |  2 +-
 arch/arm/mach-exynos/common.h    |  7 ++++++-
 arch/arm/mach-exynos/exynos.c    |  3 ++-
 arch/arm/mach-exynos/firmware.c  | 36 ++++++++++++++++++++++++++----------
 arch/arm/mach-exynos/pm.c        | 39 +++++++++++++++++++++++++++++----------
 drivers/cpuidle/cpuidle-exynos.c |  6 +++---
 6 files changed, 67 insertions(+), 26 deletions(-)

-- 
1.8.2.3
