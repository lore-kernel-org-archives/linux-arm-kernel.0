From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:30:15 +0900
Subject: [GIT 00/22] Renesas ARM based SoC cleanups for v3.12
Message-ID: <cover.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following cleanups for v3.12.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.12

for you to fetch changes up to ebd9616f439a8a46b9dca9a272b342f34c5f3614:

  ARM: shmobile: Remove unused mach/dma.h (2013-07-17 10:02:30 +0900)

----------------------------------------------------------------
renesas-cleanup-for-v3.12 Renesas ARM based SoC cleanups for v3.12

* remove mach/dma.h, it is not used
* r8a7778 SoC: Removed unused r8a7778_init_irq
* emev2 SoC: Use less verbose resource declarations
* emev2 SoC: Correct typo in comment
* r8a7790 SoC: Remove redundant init_machine callback
* emev2, r8a7740, r8a7778, r8a7779, sh7372 and sh73a0 SoCs: Remove auxdata
* emev2, r8a73a4, ape6evm, r8a7790 and sh73a0 SoCs, and
  lager and kzm9g boards: remove init_irq declaration in machine description
* sh73a0 SoC: pinmux platform device cleanup
* r8a7778 SoC: add __initdata on resource and device data
* armadillo800eva board: Remove unused commend and define

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: armadillo800eva: remove left-overs

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: add __initdata on resource and device data
      ARM: shmobile: r8a7778: remove r8a7778_init_irq()

Magnus Damm (15):
      ARM: shmobile: sh73a0 pinmux platform device cleanup
      ARM: shmobile: ape6evm: Remove init_irq declaration in machine description
      ARM: shmobile: lager: Remove init_irq declaration in machine description
      ARM: shmobile: kzm9g: Remove init_irq declaration in machine description
      ARM: shmobile: Remove unused EMEV2 auxdata and callback
      ARM: shmobile: Remove unused r8a7740 auxdata table
      ARM: shmobile: Remove unused r8a7778 auxdata and callback
      ARM: shmobile: Remove unused r8a7779 auxdata table
      ARM: shmobile: Remove unused sh7372 auxdata table
      ARM: shmobile: Remove unused sh73a0 auxdata table
      ARM: shmobile: Remove redundant r8a7790 callback
      ARM: shmobile: Remove unused EMEV2/KZM9D early console
      ARM: shmobile: Make EMEV2 platform devices more compact
      ARM: shmobile: Fix EMEV2 clock comment typo
      ARM: shmobile: Remove unused mach/dma.h

Maxime Ripard (4):
      ARM: shmobile: emev2: Remove init_irq declaration in machine description
      ARM: shmobile: r8a73a4: Remove init_irq declaration in machine description
      ARM: shmobile: r8a7790: Remove init_irq declaration in machine description
      ARM: shmobile: sh73a0: Remove init_irq declaration in machine description

 arch/arm/mach-shmobile/board-ape6evm.c         |    2 -
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 -
 arch/arm/mach-shmobile/board-kzm9d.c           |    2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 -
 arch/arm/mach-shmobile/board-lager.c           |    2 -
 arch/arm/mach-shmobile/clock-emev2.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/dma.h      |    1 -
 arch/arm/mach-shmobile/include/mach/emev2.h    |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 -
 arch/arm/mach-shmobile/setup-emev2.c           |  353 +++++-------------------
 arch/arm/mach-shmobile/setup-r8a73a4.c         |    2 -
 arch/arm/mach-shmobile/setup-r8a7740.c         |   16 +-
 arch/arm/mach-shmobile/setup-r8a7778.c         |   72 ++---
 arch/arm/mach-shmobile/setup-r8a7779.c         |    7 +-
 arch/arm/mach-shmobile/setup-r8a7790.c         |    7 -
 arch/arm/mach-shmobile/setup-sh7372.c          |    7 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |   34 +--
 17 files changed, 106 insertions(+), 415 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/dma.h
