From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:20 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.18
Message-ID: <cover.1408671240.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.18

for you to fetch changes up to 5ac9e7f35db00e630c9f95a1f73ac329371cdbbf:

  ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization (2014-08-20 09:09:24 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v3.18

* Remove unnecessary nr_irqs initialisation on sh73a0, sh7372,
  and r8a7779 SoCs
* Use defines hardcoded numbers for DMA
* Rework multiplatform include workaround
* Correctly use shmobile_init_late on a wider range of SoCs

----------------------------------------------------------------
Geert Uytterhoeven (4):
      ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()
      ARM: shmobile: dma: Use defines instead of hardcoded numbers
      ARM: shmobile: sh7372: Remove unneeded nr_irqs initialization
      ARM: shmobile: sh73a0: Remove unneeded nr_irqs initialization

Magnus Damm (7):
      ARM: shmobile: sh73a0: Add shmobile_init_late()
      ARM: shmobile: r8a7779: Fix shmobile_init_late()
      ARM: shmobile: r8a7778: Fix shmobile_init_late()
      ARM: shmobile: r8a73a4: Add shmobile_init_late()
      ARM: shmobile: r7s72100: Add shmobile_init_late()
      ARM: shmobile: Rework multiplatform include workaround
      ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY

 arch/arm/mach-shmobile/Makefile         | 2 --
 arch/arm/mach-shmobile/dma-register.h   | 4 ++--
 arch/arm/mach-shmobile/irqs.h           | 2 +-
 arch/arm/mach-shmobile/setup-r7s72100.c | 1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c  | 1 +
 arch/arm/mach-shmobile/setup-r8a7778.c  | 3 ++-
 arch/arm/mach-shmobile/setup-r8a7779.c  | 3 +--
 arch/arm/mach-shmobile/setup-sh7372.c   | 1 -
 arch/arm/mach-shmobile/setup-sh73a0.c   | 2 +-
 9 files changed, 9 insertions(+), 10 deletions(-)
