From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:37 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC soc-cleanup Updates
 for v3.17
Message-ID: <cover.1404173049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-cleanup-for-v3.17,
which I have already sent a pull-request for.

This conflicts with other changes made to pm-r8a7790.c in the soc branch
of the renesas tree. A resolution can be found in the
renesas-next-v3.16-rc1-20140628 tag of the next branch of that tree.

In short, the resulting includes should be:

#include <linux/kernel.h>
#include <linux/smp.h>
#include <asm/io.h>
#include "common.h"
#include "pm-rcar.h"
#include "r8a7790.h"


The following changes since commit d83fa4c9c27c4d8612e39e99506b5420fa05b58b:

  ARM: shmobile: Remove unused r8a7790_init_early() (2014-06-17 19:50:35 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-cleanup2-for-v3.17

for you to fetch changes up to 113522ee3034427472bcb4b8665833719809b31a:

  ARM: shmobile: Move sh7372.h (2014-06-25 16:50:00 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17

* Move SOC-specific headers out of mach directory.
  This is part of a multi-stage effort to move headers
  out of that directory.

----------------------------------------------------------------
Geert Uytterhoeven (7):
      ARM: shmobile: Move r7s72100.h
      ARM: shmobile: Move r8a73a4.h
      ARM: shmobile: Move r8a7740.h
      ARM: shmobile: Move r8a7778.h
      ARM: shmobile: Move r8a7790.h
      ARM: shmobile: Move sh73a0.h
      ARM: shmobile: Move sh7372.h

 arch/arm/mach-shmobile/board-ape6evm-reference.c         |  4 +++-
 arch/arm/mach-shmobile/board-ape6evm.c                   |  4 +++-
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |  4 +++-
 arch/arm/mach-shmobile/board-armadillo800eva.c           |  4 +++-
 arch/arm/mach-shmobile/board-bockw-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-bockw.c                     |  4 +++-
 arch/arm/mach-shmobile/board-genmai-reference.c          |  4 +++-
 arch/arm/mach-shmobile/board-genmai.c                    |  4 +++-
 arch/arm/mach-shmobile/board-kzm9g-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-kzm9g.c                     |  4 +++-
 arch/arm/mach-shmobile/board-lager-reference.c           |  4 +++-
 arch/arm/mach-shmobile/board-lager.c                     | 14 ++++++++------
 arch/arm/mach-shmobile/board-mackerel.c                  |  4 +++-
 arch/arm/mach-shmobile/clock-r7s72100.c                  |  3 ++-
 arch/arm/mach-shmobile/clock-r8a7740.c                   |  3 ++-
 arch/arm/mach-shmobile/clock-r8a7790.c                   |  3 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c                     |  4 +++-
 arch/arm/mach-shmobile/pm-r8a7790.c                      |  4 +++-
 arch/arm/mach-shmobile/pm-sh7372.c                       |  4 +++-
 arch/arm/mach-shmobile/{include/mach => }/r7s72100.h     |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a73a4.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7740.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7778.h      |  0
 arch/arm/mach-shmobile/{include/mach => }/r8a7790.h      |  0
 arch/arm/mach-shmobile/setup-r7s72100.c                  |  4 +++-
 arch/arm/mach-shmobile/setup-r8a73a4.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7778.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-r8a7790.c                   |  4 +++-
 arch/arm/mach-shmobile/setup-sh7372.c                    |  4 +++-
 arch/arm/mach-shmobile/setup-sh73a0.c                    |  4 +++-
 arch/arm/mach-shmobile/{include/mach => }/sh7372.h       |  0
 arch/arm/mach-shmobile/{include/mach => }/sh73a0.h       |  0
 arch/arm/mach-shmobile/smp-r8a7790.c                     |  4 +++-
 arch/arm/mach-shmobile/smp-sh73a0.c                      |  4 +++-
 35 files changed, 86 insertions(+), 33 deletions(-)
 rename arch/arm/mach-shmobile/{include/mach => }/r7s72100.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a73a4.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7740.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7778.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7790.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/sh7372.h (100%)
 rename arch/arm/mach-shmobile/{include/mach => }/sh73a0.h (100%)
