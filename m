From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:24:52 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Header Cleanup for v3.17
Message-ID: <cover.1403487267.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC header cleanup for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-header-cleanup-for-v3.17

for you to fetch changes up to 62872989bdbf1245d7239b9f4c05a8ee7c775ed5:

  ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case (2014-06-17 17:09:40 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Header Cleanup for v3.17

Move the most common shared header files for mach-shmobile
from <mach/foobar.h> to "foobar.h"

6287298 ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
585c09d ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
6b8b0cb ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
fd44aa5 ARM: shmobile: Move common.h
b6bab12 ARM: shmobile: Move most of irqs.h, keep some for pinctl
ad6ffa0 ARM: shmobile: Move clock.h
74ac0de ARM: shmobile: Move dma-register.h
6200e2c ARM: shmobile: Move intc.h, cleanup sh_intc.h usage

----------------------------------------------------------------
Magnus Damm (8):
      ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
      ARM: shmobile: Move dma-register.h
      ARM: shmobile: Move clock.h
      ARM: shmobile: Move most of irqs.h, keep some for pinctl
      ARM: shmobile: Move common.h
      ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
      ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
      ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case

 arch/arm/mach-shmobile/board-ape6evm-reference.c    |  2 +-
 arch/arm/mach-shmobile/board-ape6evm.c              |  4 ++--
 .../mach-shmobile/board-armadillo800eva-reference.c |  2 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c      |  6 +++---
 arch/arm/mach-shmobile/board-bockw-reference.c      |  2 +-
 arch/arm/mach-shmobile/board-bockw.c                |  4 ++--
 arch/arm/mach-shmobile/board-genmai-reference.c     |  4 ++--
 arch/arm/mach-shmobile/board-genmai.c               |  4 ++--
 arch/arm/mach-shmobile/board-koelsch-reference.c    |  8 ++++----
 arch/arm/mach-shmobile/board-koelsch.c              |  6 +++---
 arch/arm/mach-shmobile/board-kzm9g-reference.c      |  2 +-
 arch/arm/mach-shmobile/board-kzm9g.c                |  4 ++--
 arch/arm/mach-shmobile/board-lager-reference.c      |  8 ++++----
 arch/arm/mach-shmobile/board-lager.c                |  5 +++--
 arch/arm/mach-shmobile/board-mackerel.c             | 10 ++++------
 arch/arm/mach-shmobile/board-marzen-reference.c     |  4 ++--
 arch/arm/mach-shmobile/board-marzen.c               |  4 ++--
 arch/arm/mach-shmobile/clock-r7s72100.c             |  2 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c              |  4 ++--
 arch/arm/mach-shmobile/clock-r8a7740.c              |  4 ++--
 arch/arm/mach-shmobile/clock-r8a7778.c              |  4 ++--
 arch/arm/mach-shmobile/clock-r8a7779.c              |  4 ++--
 arch/arm/mach-shmobile/clock-r8a7790.c              |  5 +++--
 arch/arm/mach-shmobile/clock-r8a7791.c              |  6 +++---
 arch/arm/mach-shmobile/clock-sh7372.c               |  4 ++--
 arch/arm/mach-shmobile/clock-sh73a0.c               |  4 ++--
 arch/arm/mach-shmobile/clock.c                      |  6 +++---
 arch/arm/mach-shmobile/{include/mach => }/clock.h   |  0
 arch/arm/mach-shmobile/{include/mach => }/common.h  |  0
 arch/arm/mach-shmobile/console.c                    |  2 +-
 .../mach-shmobile/{include/mach => }/dma-register.h |  0
 arch/arm/mach-shmobile/include/mach/irqs.h          | 16 +---------------
 arch/arm/mach-shmobile/include/mach/r8a7740.h       |  2 --
 arch/arm/mach-shmobile/include/mach/r8a7779.h       | 12 ------------
 arch/arm/mach-shmobile/include/mach/r8a7790.h       |  2 --
 arch/arm/mach-shmobile/include/mach/sh7372.h        |  4 ----
 arch/arm/mach-shmobile/intc-sh7372.c                |  5 ++---
 arch/arm/mach-shmobile/intc-sh73a0.c                |  5 ++---
 arch/arm/mach-shmobile/{include/mach => }/intc.h    |  0
 arch/arm/mach-shmobile/irqs.h                       | 21 +++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c               |  2 +-
 arch/arm/mach-shmobile/platsmp-scu.c                |  2 +-
 arch/arm/mach-shmobile/platsmp.c                    |  2 +-
 arch/arm/mach-shmobile/pm-r8a7740.c                 |  4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c                 | 15 +++++++++++++--
 arch/arm/mach-shmobile/pm-r8a7790.c                 |  2 +-
 arch/arm/mach-shmobile/pm-rcar.c                    |  2 +-
 arch/arm/mach-shmobile/{include/mach => }/pm-rcar.h |  0
 arch/arm/mach-shmobile/pm-rmobile.c                 |  2 +-
 .../mach-shmobile/{include/mach => }/pm-rmobile.h   |  0
 arch/arm/mach-shmobile/pm-sh7372.c                  |  4 ++--
 arch/arm/mach-shmobile/pm-sh73a0.c                  |  2 +-
 .../mach-shmobile/{include/mach => }/rcar-gen2.h    |  0
 arch/arm/mach-shmobile/setup-emev2.c                |  2 +-
 arch/arm/mach-shmobile/setup-r7s72100.c             |  4 ++--
 arch/arm/mach-shmobile/setup-r8a73a4.c              |  6 +++---
 arch/arm/mach-shmobile/setup-r8a7740.c              |  8 ++++----
 arch/arm/mach-shmobile/setup-r8a7778.c              |  4 ++--
 arch/arm/mach-shmobile/setup-r8a7779.c              |  4 ++--
 arch/arm/mach-shmobile/setup-r8a7790.c              |  7 ++++---
 arch/arm/mach-shmobile/setup-r8a7791.c              |  6 +++---
 arch/arm/mach-shmobile/setup-rcar-gen2.c            |  4 ++--
 arch/arm/mach-shmobile/setup-sh7372.c               |  8 ++++----
 arch/arm/mach-shmobile/setup-sh73a0.c               |  7 +++----
 arch/arm/mach-shmobile/smp-emev2.c                  |  2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c                |  4 ++--
 arch/arm/mach-shmobile/smp-r8a7790.c                |  4 ++--
 arch/arm/mach-shmobile/smp-r8a7791.c                |  4 ++--
 arch/arm/mach-shmobile/smp-sh73a0.c                 |  2 +-
 69 files changed, 150 insertions(+), 154 deletions(-)
 rename arch/arm/mach-shmobile/{include/mach => }/clock.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/common.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/dma-register.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/intc.h (100%)
 create mode 100644 arch/arm/mach-shmobile/irqs.h
 rename arch/arm/mach-shmobile/{include/mach => }/pm-rcar.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/pm-rmobile.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/rcar-gen2.h (100%)
