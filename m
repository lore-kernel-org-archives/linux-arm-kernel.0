From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jul 2012 20:33:22 -0000
Subject: [GIT PULL 07/15] arm-soc: timer updates
In-Reply-To: <1343075561-17446-1-git-send-email-arnd@arndb.de>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
Message-ID: <1343075561-17446-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6 (2012-07-07 17:23:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git next/timer

for you to fetch changes up to 35bf8cc74b2b1dfad18df6d330b271e68ab6e3f5:

  Merge branch 'picoxcell/timer' into next/timer (2012-07-12 17:27:36 +0200)

----------------------------------------------------------------

arm-soc: timer updates

This contains two branches dealing with timers, one for the picoxcell
platform that is now using DT with the platform-independent
dw_apb_timer driver. The other change is for the omap-specific
dmtimer driver.

----------------------------------------------------------------

Arnd Bergmann (3):
      Merge tag 'omap-devel-dmtimer-for-v3.6' of git://git.kernel.org/.../tmlind/linux-omap into next/timer
      Merge branch 'picoxcell/timer' into next/timer
      Merge branch 'next/timer' into for-next

Dinh Nguyen (1):
      clocksource: dw_apb_timer: Add common DTS glue for dw_apb_timer

Jon Hunter (12):
      ARM: OMAP: Remove unnecessary clk structure
      ARM: OMAP2+: Remove unused max number of timers definition
      ARM: OMAP2+: Add dmtimer platform function to reserve systimers
      ARM: OMAP: Add DMTIMER capability variable to represent timer features
      ARM: OMAP2+: HWMOD: Correct timer device attributes
      ARM: OMAP2+: Fix external clock support for dmtimers
      ARM: OMAP: Remove loses_context variable from timer platform data
      ARM: OMAP: Remove timer function pointer for context loss counter
      ARM: OMAP: Add flag to indicate if a timer needs a manual reset
      ARM: OMAP1: Fix dmtimer support
      ARM: OMAP2+: Move dmtimer clock set function to dmtimer driver
      ARM: OMAP2+: Simplify dmtimer clock aliases

 Documentation/devicetree/bindings/rtc/dw-apb.txt   |   25 +++++
 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-omap1/timer.c                        |    3 +-
 arch/arm/mach-omap2/clock2420_data.c               |   39 +------
 arch/arm/mach-omap2/clock2430_data.c               |   39 +------
 arch/arm/mach-omap2/clock3xxx_data.c               |   26 +----
 arch/arm/mach-omap2/clock44xx_data.c               |   34 +++---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    8 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   10 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 --
 arch/arm/mach-omap2/timer.c                        |   82 +--------------
 arch/arm/mach-picoxcell/Makefile                   |    1 -
 arch/arm/mach-picoxcell/common.c                   |    3 +-
 arch/arm/mach-picoxcell/common.h                   |    2 +-
 arch/arm/plat-omap/dmtimer.c                       |  111 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/dmtimer.h          |   22 +---
 drivers/clocksource/Kconfig                        |    3 +
 drivers/clocksource/Makefile                       |    1 +
 .../clocksource/dw_apb_timer_of.c                  |   52 +++++----
 19 files changed, 182 insertions(+), 286 deletions(-)
