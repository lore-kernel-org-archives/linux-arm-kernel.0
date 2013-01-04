From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Jan 2013 14:41:37 +0000
Subject: [RFC 0/3] future of gemini platform
In-Reply-To: <1357310500-19848-1-git-send-email-arnd@arndb.de>
References: <1357310500-19848-1-git-send-email-arnd@arndb.de>
Message-ID: <1357310500-19848-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gemini platform is quite broken at the moment due to bitrot,
here are the two suggested solutions. We should either apply the
first patch or the other two, depending on whether anyone still
uses this.

Ulli was last actively working on this about two years ago,
so I assume that he has moved on, but if he or anyone else
is still interested in keeping Gemini alive, any patches
and testing are very welcome. Without a maintainer however,
I see no point in keeping it.

The fa526 CPU support is currently only used on Gemini,
but Florian had some patches last year for it, so he might
still need it. If there are still plans to get MCS814x
or another fa526 based platform merged into mainline,
we can keep this around, but unless I see a timeline
for this, I would prefer to remove it for now. It should
be trivial to revert that patch and bring it back if
it's needed for a new platform.

Arnd Bergmann (3):
  ARM: gemini: get platform to build again
  ARM: gemini: remove platform support
  ARM: remove fa526 CPU support

 MAINTAINERS                                     |   14 --
 arch/arm/Kconfig                                |   10 +-
 arch/arm/Makefile                               |    2 -
 arch/arm/boot/compressed/head.S                 |   28 ---
 arch/arm/include/asm/barrier.h                  |    6 -
 arch/arm/include/asm/glue-cache.h               |    8 -
 arch/arm/include/asm/glue-proc.h                |    9 -
 arch/arm/include/asm/page.h                     |    8 -
 arch/arm/include/asm/tlbflush.h                 |   19 --
 arch/arm/mach-gemini/Kconfig                    |   40 ----
 arch/arm/mach-gemini/Makefile                   |   13 --
 arch/arm/mach-gemini/Makefile.boot              |    9 -
 arch/arm/mach-gemini/board-nas4220b.c           |  110 ---------
 arch/arm/mach-gemini/board-rut1xx.c             |   94 --------
 arch/arm/mach-gemini/board-wbd111.c             |  137 -----------
 arch/arm/mach-gemini/board-wbd222.c             |  137 -----------
 arch/arm/mach-gemini/common.h                   |   29 ---
 arch/arm/mach-gemini/devices.c                  |  118 ----------
 arch/arm/mach-gemini/gpio.c                     |  230 -------------------
 arch/arm/mach-gemini/idle.c                     |   29 ---
 arch/arm/mach-gemini/include/mach/debug-macro.S |   21 --
 arch/arm/mach-gemini/include/mach/entry-macro.S |   33 ---
 arch/arm/mach-gemini/include/mach/global_reg.h  |  278 -----------------------
 arch/arm/mach-gemini/include/mach/gpio.h        |   20 --
 arch/arm/mach-gemini/include/mach/hardware.h    |   74 ------
 arch/arm/mach-gemini/include/mach/irqs.h        |   53 -----
 arch/arm/mach-gemini/include/mach/system.h      |   23 --
 arch/arm/mach-gemini/include/mach/timex.h       |   13 --
 arch/arm/mach-gemini/include/mach/uncompress.h  |   44 ----
 arch/arm/mach-gemini/irq.c                      |  103 ---------
 arch/arm/mach-gemini/mm.c                       |   82 -------
 arch/arm/mach-gemini/time.c                     |   89 --------
 arch/arm/mm/Kconfig                             |   32 +--
 arch/arm/mm/Makefile                            |    4 -
 arch/arm/mm/cache-fa.S                          |  249 --------------------
 arch/arm/mm/copypage-fa.c                       |   86 -------
 arch/arm/mm/proc-fa526.S                        |  221 ------------------
 arch/arm/mm/tlb-fa.S                            |   69 ------
 38 files changed, 3 insertions(+), 2541 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/Kconfig
 delete mode 100644 arch/arm/mach-gemini/Makefile
 delete mode 100644 arch/arm/mach-gemini/Makefile.boot
 delete mode 100644 arch/arm/mach-gemini/board-nas4220b.c
 delete mode 100644 arch/arm/mach-gemini/board-rut1xx.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd111.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd222.c
 delete mode 100644 arch/arm/mach-gemini/common.h
 delete mode 100644 arch/arm/mach-gemini/devices.c
 delete mode 100644 arch/arm/mach-gemini/gpio.c
 delete mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-gemini/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/global_reg.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/system.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/timex.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-gemini/irq.c
 delete mode 100644 arch/arm/mach-gemini/mm.c
 delete mode 100644 arch/arm/mach-gemini/time.c
 delete mode 100644 arch/arm/mm/cache-fa.S
 delete mode 100644 arch/arm/mm/copypage-fa.c
 delete mode 100644 arch/arm/mm/proc-fa526.S
 delete mode 100644 arch/arm/mm/tlb-fa.S

-- 
1.7.10.4
