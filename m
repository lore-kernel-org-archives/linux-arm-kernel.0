From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Aug 2013 22:54:35 +0200
Subject: [GIT PULL] ux500 core changes for v3.12
Message-ID: <CACRpkdbRaV9_oCNKXh2O2JR6pyvz6+5c4=pxYCFhT6-KzbqyMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some smallish ux500 core changes for the v3.12
cycle. Basically just three random patches. The big thing is
that we can now restart the ux500 with software.

Please pull these in!

Yours,
Linus Walleij

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-core-for-arm-soc

for you to fetch changes up to 0a429fd15ecb05d7d5fa8eb4adaff69c7a00984b:

  ARM: ux500: set coherent_dma_mask for dma40 (2013-08-19 22:49:25 +0200)

----------------------------------------------------------------
Core ux500 changes for v3.12:
- Add support for restart using the PRCMU
- Move secondary startup out of INIT section
- set coherent_dma_mask for DMA40

----------------------------------------------------------------
Fabio Baltieri (2):
      ARM: ux500: add restart support via prcmu
      ARM: ux500: set coherent_dma_mask for dma40

Srinivas Kandagatla (1):
      ARM: ux500: remove u8500_secondary_startup from INIT section.

 arch/arm/mach-ux500/board-mop500.c   | 5 ++++-
 arch/arm/mach-ux500/cpu-db8500.c     | 2 +-
 arch/arm/mach-ux500/cpu.c            | 8 ++++++++
 arch/arm/mach-ux500/devices-db8500.c | 1 +
 arch/arm/mach-ux500/headsmp.S        | 2 --
 arch/arm/mach-ux500/setup.h          | 3 +++
 6 files changed, 17 insertions(+), 4 deletions(-)
