From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jun 2014 18:53:00 +0200
Subject: [PATCH 0/9] ARM: shmobile: Move SoC-specific header files
Message-ID: <1403283189-21688-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's Friday afternoon, hence the ideal time for a no-brainer patch
series to move the shmobile SoC-specific header files, so they can be
included as "<soc>.h" instead of the old style <mach/<soc>.h>.

All build-tested. Multi-platform shmobile also boot-tested on
r8a7791/koelsch.

  [1/9] ARM: shmobile: Move r7s72100.h
  [2/9] ARM: shmobile: Move r8a73a4.h
  [3/9] ARM: shmobile: Move r8a7740.h
  [4/9] ARM: shmobile: Move r8a7778.h
  [5/9] ARM: shmobile: Move r8a7779.h
  [6/9] ARM: shmobile: Move r8a7790.h
  [7/9] ARM: shmobile: Move r8a7791.h
  [8/9] ARM: shmobile: Move sh7372.h
  [9/9] ARM: shmobile: Move sh73a0.h

 arch/arm/mach-shmobile/board-ape6evm-reference.c         |  4 +++-
 arch/arm/mach-shmobile/board-ape6evm.c                   |  4 +++-
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |  4 +++-
 arch/arm/mach-shmobile/board-armadillo800eva.c           |  4 +++-
 arch/arm/mach-shmobile/board-bockw-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-bockw.c                     |  4 +++-
 arch/arm/mach-shmobile/board-genmai-reference.c          |  4 +++-
 arch/arm/mach-shmobile/board-genmai.c                    |  4 +++-
 arch/arm/mach-shmobile/board-koelsch-reference.c         |  4 +++-
 arch/arm/mach-shmobile/board-koelsch.c                   |  4 +++-
 arch/arm/mach-shmobile/board-kzm9g-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-kzm9g.c                     |  4 +++-
 arch/arm/mach-shmobile/board-lager-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-lager.c                     | 14 ++++++++------
 arch/arm/mach-shmobile/board-mackerel.c                  |  4 +++-
 arch/arm/mach-shmobile/board-marzen-reference.c          |  4 +++-
 arch/arm/mach-shmobile/board-marzen.c                    |  4 +++-
 arch/arm/mach-shmobile/clock-r7s72100.c                  |  3 ++-
 arch/arm/mach-shmobile/clock-r8a7740.c                   |  3 ++-
 arch/arm/mach-shmobile/clock-r8a7779.c                   |  3 ++-
 arch/arm/mach-shmobile/clock-r8a7790.c                   |  3 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c                     |  4 +++-
 arch/arm/mach-shmobile/pm-r8a7779.c                      |  4 +++-
 arch/arm/mach-shmobile/pm-r8a7790.c                      |  4 +++-
 arch/arm/mach-shmobile/pm-r8a7791.c                      |  6 ++++--
 arch/arm/mach-shmobile/pm-sh7372.c                       |  4 +++-
 arch/arm/mach-shmobile/{include/mach => }/r7s72100.h     |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a73a4.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7740.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7778.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7779.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7790.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7791.h      |  0
 arch/arm/mach-shmobile/setup-r7s72100.c                  |  4 +++-
 arch/arm/mach-shmobile/setup-r8a73a4.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7778.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7779.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7790.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7791.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-sh7372.c                    |  4 +++-
 arch/arm/mach-shmobile/setup-sh73a0.c                    |  4 +++-
 arch/arm/mach-shmobile/{include/mach => }/sh7372.h       |  0
 arch/arm/mach-shmobile/{include/mach => }/sh73a0.h       |  0
 arch/arm/mach-shmobile/smp-r8a7779.c                     |  4 +++-
 arch/arm/mach-shmobile/smp-r8a7790.c                     |  4 +++-
 arch/arm/mach-shmobile/smp-r8a7791.c                     |  4 +++-
 arch/arm/mach-shmobile/smp-sh73a0.c                      |  4 +++-
 48 files changed, 119 insertions(+), 45 deletions(-)
 rename arch/arm/mach-shmobile/{include/mach => }/r7s72100.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a73a4.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7740.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7778.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7779.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7790.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7791.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/sh7372.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/sh73a0.h (100%)

Have a nice weekend!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
