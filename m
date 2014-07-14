From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Jul 2014 16:43:58 +0200
Subject: [PATCH 0/2] ARM: EXYNOS: Fix builds with PM_SLEEP=n
Message-ID: <1405349040-5265-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series fixes builds with CONFIG_PM_SLEEP config option
disabled.

They are on top of:
- next-20140714 +
- "[PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies" +
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html)
- "[PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n"
  (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34007.html)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

Bartlomiej Zolnierkiewicz (2):
  ARM: EXYNOS: Fix build with PM_SLEEP=n part #2
  ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y

 arch/arm/mach-exynos/Kconfig   |   5 +
 arch/arm/mach-exynos/Makefile  |   3 +-
 arch/arm/mach-exynos/common.h  |   7 ++
 arch/arm/mach-exynos/exynos.c  |   2 +
 arch/arm/mach-exynos/pm.c      | 178 +-----------------------------------
 arch/arm/mach-exynos/suspend.c | 203 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/Makefile |   1 +
 7 files changed, 224 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm/mach-exynos/suspend.c

-- 
1.8.2.3
