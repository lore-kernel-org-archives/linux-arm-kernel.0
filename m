From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Jan 2015 17:42:50 +0100
Subject: [GIT PULL] at91: cleanup for 3.20 #1
Message-ID: <1421340170-13241-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Some AT91 cleanup for 3.20, but definitively, more to come soon.

Thanks, best regards,

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup

for you to fetch changes up to bd87373229e3e8b1a2a42b9eeed4c60fd4418ec6:

  ARM: at91: remove useless at91rm9200_set_type() (2015-01-15 15:24:06 +0100)

----------------------------------------------------------------
First batch of cleanup for 3.20:
- Documentation for AT91 SoC
- Config options, files and functions removal to continue the big !DT
  cleanup done in 3.19
- move of debug-macro.S to its usual location

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: at91: remove unused mach/memory.h
      ARM: at91: remove useless config MACH_AT91RM9200_DT
      ARM: at91: remove useless config MACH_AT91SAM9_DT
      ARM: at91: remove useless at91_sysirq_mask_rtx
      ARM: at91: move debug-macro.S into the common space
      ARM: at91: remove useless at91rm9200_dt_initialize()
      ARM: at91: remove useless at91rm9200_set_type()

Boris Brezillon (1):
      ARM: at91: remove useless header file includes

Nicolas Ferre (3):
      ARM: at91/Documentation: add a README for Atmel SoCs
      rtc: at91/Kconfig: remove useless options
      ARM: at91: remove unneeded header file

 Documentation/arm/Atmel/README                     | 124 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 arch/arm/Kconfig.debug                             |   9 +-
 .../mach/debug-macro.S => include/debug/at91.S}    |  19 ++--
 arch/arm/mach-at91/Kconfig                         |   8 --
 arch/arm/mach-at91/Makefile                        |   6 +-
 arch/arm/mach-at91/at91sam9260.c                   |   2 -
 arch/arm/mach-at91/at91sam9261.c                   |   2 -
 arch/arm/mach-at91/at91sam9263.c                   |   3 -
 arch/arm/mach-at91/at91sam9g45.c                   |   4 -
 arch/arm/mach-at91/at91sam9n12.c                   |   6 -
 arch/arm/mach-at91/at91sam9rl.c                    |   4 -
 arch/arm/mach-at91/at91sam9x5.c                    |  10 --
 arch/arm/mach-at91/board-dt-rm9200.c               |   2 +-
 arch/arm/mach-at91/generic.h                       |   6 -
 arch/arm/mach-at91/include/mach/at91_pio.h         |  80 -------------
 arch/arm/mach-at91/include/mach/at91_rtt.h         |  35 ------
 arch/arm/mach-at91/include/mach/memory.h           |  26 -----
 arch/arm/mach-at91/sama5d3.c                       |   6 -
 arch/arm/mach-at91/setup.c                         |  18 ---
 arch/arm/mach-at91/sysirq_mask.c                   |  75 -------------
 drivers/rtc/Kconfig                                |  28 -----
 22 files changed, 147 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/arm/Atmel/README
 rename arch/arm/{mach-at91/include/mach/debug-macro.S => include/debug/at91.S} (68%)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_pio.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_rtt.h
 delete mode 100644 arch/arm/mach-at91/include/mach/memory.h
 delete mode 100644 arch/arm/mach-at91/sysirq_mask.c

-- 
Nicolas Ferre
