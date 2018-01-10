From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Jan 2018 16:55:05 +0530
Subject: [GIT PULL] TI DaVinci SoC updates for v4.16 (part 2)
Message-ID: <20180110112505.13633-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 23bbeaef90ab7607d03428bbb708efe44f43c761:

  ARM: davinci: constify gpio_led (2018-01-05 19:28:41 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.16/soc-p2

for you to fetch changes up to 0808d3260456aaba061fe06ead31d578c8bdc936:

  ARM: davinci: remove watchdog reset (2018-01-10 14:38:07 +0530)

----------------------------------------------------------------
A patch to shift to using watchdog timer for DaVinci restart functionality.
The driver support is present in linux-next as 71d1f058844d "watchdog:
davinci_wdt: add restart function"

----------------------------------------------------------------
David Lechner (1):
      ARM: davinci: remove watchdog reset

 arch/arm/mach-davinci/board-da830-evm.c     |  1 -
 arch/arm/mach-davinci/board-da850-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm355-leopard.c |  1 -
 arch/arm/mach-davinci/board-dm365-evm.c     |  1 -
 arch/arm/mach-davinci/board-dm644x-evm.c    |  1 -
 arch/arm/mach-davinci/board-dm646x-evm.c    |  2 -
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 -
 arch/arm/mach-davinci/board-neuros-osd2.c   |  1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |  1 -
 arch/arm/mach-davinci/board-sffsdr.c        |  1 -
 arch/arm/mach-davinci/clock.h               |  3 --
 arch/arm/mach-davinci/da8xx-dt.c            |  1 -
 arch/arm/mach-davinci/devices-da8xx.c       | 13 -------
 arch/arm/mach-davinci/devices.c             |  7 +---
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 -
 arch/arm/mach-davinci/time.c                | 57 -----------------------------
 18 files changed, 1 insertion(+), 94 deletions(-)
