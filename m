From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Dec 2011 15:41:18 +0000
Subject: [GIT PULL] arm-soc fixes for 3.2, part 4
Message-ID: <201112161541.18525.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is the current set of fixes for v3.2. The majority of these are
i.mx platform fixes that came slightly too late for the previous round.

	Arnd
---
The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes

Amit Daniel Kachhap (1):
      ARM: EXYNOS: Fix for stall in case of cpu hotplug or sleep

Arnd Bergmann (1):
      Merge branch 'imx-fixes-for-arnd' of git://git.pengutronix.de/git/imx/linux-2.6 into fixes

Dong Aisheng (1):
      ARM: mx5: add __initconst for fec pdata

Felipe Contreras (1):
      ARM: OMAP: rx51: fix USB

Jarkko Nikula (1):
      ARM: OMAP: mcbsp: Fix possible memory corruption

Jason Chen (1):
      MXC PWM: should active during DOZE/WAIT/DBG mode

Jingoo Han (2):
      ARM: SAMSUNG: remove duplicated header include
      ARM: S5PV210: Set 1000ns as PWM backlight period on SMDKV210

Kukjin Kim (1):
      ARM: EXYNOS: Fix build error without CONFIG_LOCAL_TIMERS

Olof Johansson (2):
      Merge branch 'fixes' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge branch 'samsung-fixes-3' of git://git.kernel.org/.../kgene/linux-samsung into fixes

Richard Zhao (1):
      ARM: imx: fix cpufreq build errors

Shawn Guo (1):
      arm/imx: fix power button on imx51 babbage board

 arch/arm/mach-exynos/mct.c                   |   13 ++++++++++---
 arch/arm/mach-mx5/board-mx51_babbage.c       |    2 +-
 arch/arm/mach-mx5/board-mx53_evk.c           |    2 +-
 arch/arm/mach-mx5/board-mx53_loco.c          |    2 +-
 arch/arm/mach-mx5/board-mx53_smd.c           |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/mcbsp.c                  |    6 +++---
 arch/arm/mach-s5pv210/mach-smdkv210.c        |    1 +
 arch/arm/plat-mxc/cpufreq.c                  |    1 +
 arch/arm/plat-mxc/pwm.c                      |    7 ++++++-
 arch/arm/plat-samsung/dev-backlight.c        |    1 -
 11 files changed, 26 insertions(+), 13 deletions(-)
