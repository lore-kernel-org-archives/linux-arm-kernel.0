From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 23 Jan 2015 18:15:07 +0100
Subject: [GIT PULL] at91: cleanup/soc for 3.20 #3
Message-ID: <1422033307-9702-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a batch of cleanup/soc modifications that you may also stack on top of
your "soc" branch as the previous one. It stabilizes a little bit our cleanup
action before going further.
I also have the feeling that multi-platform would be hard to reach for 3.20...

Thanks, best regards,

The following changes since commit 29ee506d0d56f6d39cc237de2512f9cb5629cbf7:

  ARM: at91: move at91rm9200_idle() to clk/at91/pmc.c (2015-01-16 18:08:42 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup3

for you to fetch changes up to d7b943cd96a1196a7e4f8ae48fc16a086ccc9a6a:

  ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage (2015-01-23 12:35:50 +0100)

----------------------------------------------------------------
Third batch of cleanup/soc for 3.20:
- several fixes and adjustments following the last cleanup batch
- removal of some unused Kconfig options
- slight PM and pm_idle rework to ease future rework
- removal of unneeded mach/system_rev.h

----------------------------------------------------------------
Alexandre Belloni (6):
      ARM: at91: mark const init data with __initconst instead of __initdata
      ARM: at91: fix sam9n12 and sam9x5 arm_pm_idle
      ARM: at91: sam9: set arm_pm_idle from sam9_dt_device_init
      ARM: at91: stop using HAVE_AT91_DBGUx
      ARM: at91: remove unused mach/system_rev.h
      ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage

Nicolas Ferre (3):
      ARM: at91: fix Kconfig.debug by adding DEBUG_AT91_UART option
      ARM: at91: fix PM initialization for newer SoCs
      ARM: at91: fix ordering of SRAM and PM initialization

 arch/arm/Kconfig.debug                       | 13 ++++++-----
 arch/arm/mach-at91/Kconfig                   | 19 ----------------
 arch/arm/mach-at91/at91sam9260.c             |  6 -----
 arch/arm/mach-at91/at91sam9261.c             |  6 -----
 arch/arm/mach-at91/at91sam9263.c             |  6 -----
 arch/arm/mach-at91/at91sam9g45.c             |  5 -----
 arch/arm/mach-at91/at91sam9rl.c              |  6 -----
 arch/arm/mach-at91/board-dt-rm9200.c         |  6 ++---
 arch/arm/mach-at91/board-dt-sam9.c           | 33 +++++++++++++++++++++++++---
 arch/arm/mach-at91/board-dt-sama5.c          |  2 +-
 arch/arm/mach-at91/generic.h                 |  2 ++
 arch/arm/mach-at91/include/mach/system_rev.h | 27 -----------------------
 arch/arm/mach-at91/pm.c                      |  7 ++++++
 arch/arm/mach-at91/pm_slowclock.S            |  9 --------
 14 files changed, 51 insertions(+), 96 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/system_rev.h

-- 
Nicolas Ferre
