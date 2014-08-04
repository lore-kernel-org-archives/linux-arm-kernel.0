From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 04 Aug 2014 19:45:40 +0200
Subject: [PATCH v4 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Message-ID: <1407174345-31213-1-git-send-email-b.zolnierkie@samsung.com>
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

Depends on:
- next-20140804 branch of linux-next kernel tree
- [PATCH v4][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35192.html)
- [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34282.html)

Changes since v3:
- rebased on top of next-20140804 +
  [PATCH v4][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg35192.html)
  [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34282.html)
- (re-)added patch fixing S5P_CENTRAL_SEQ_OPTION register setup

Changes since v2:
- rebased on top of next-20140708 +
  [PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html)
  [with rejects fixed]
  [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on Exynos4210 and 5250
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32808.html)
  [PATCH 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32991.html)
  [with rejects fixed in patch #2]
- addressed review comments from Tomasz Figa and Daniel Lezcano

Changes since v1:
- synced against next-20140602
- added missing Acked-by-s

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
  ARM: EXYNOS: add AFTR mode support to firmware do_idle method
  ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
  ARM: EXYNOS: PM: fix register setup for AFTR mode code
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs

 arch/arm/include/asm/firmware.h |  2 +-
 arch/arm/mach-exynos/common.h   |  5 ++++
 arch/arm/mach-exynos/exynos.c   |  4 ++-
 arch/arm/mach-exynos/firmware.c | 33 ++++++++++++++++-------
 arch/arm/mach-exynos/pm.c       | 60 ++++++++++++++++++++++++-----------------
 5 files changed, 69 insertions(+), 35 deletions(-)

-- 
1.8.2.3
