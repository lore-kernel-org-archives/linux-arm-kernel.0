From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Feb 2014 11:10:10 +0530
Subject: [GIT PULL] DaVinci NAND update for v3.15
Message-ID: <530ADB3A.1070302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Can you please pull the following change for v3.15? The mtd
changes are acked by Brian. We agreed to take this through ARM-SoC
because of the number of changes to mach-davinci.

I based this on -rc3 since I saw that ARM-SoC is on -rc3 anyway.

Thanks,
Sekhar

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.15/nand

for you to fetch changes up to 67f5185cad24b3c3d9ab07508dfcab55cdab02de:

  ARM: davinci: aemif: get rid of davinci-nand driver dependency on aemif (2014-02-23 20:33:18 +0530)

----------------------------------------------------------------
A patch to break dependency of DaVinci NAND
driver with mach-davinci. Required for reuse
of driver on other platforms (keystone).

----------------------------------------------------------------
Ivan Khoronzhuk (1):
      ARM: davinci: aemif: get rid of davinci-nand driver dependency on aemif

 arch/arm/mach-davinci/aemif.c                   |  107 ++++++++++++++++++++---
 arch/arm/mach-davinci/board-da830-evm.c         |    3 +
 arch/arm/mach-davinci/board-da850-evm.c         |    3 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |    5 ++
 arch/arm/mach-davinci/board-dm646x-evm.c        |    3 +
 arch/arm/mach-davinci/board-mityomapl138.c      |    4 +
 drivers/mtd/nand/davinci_nand.c                 |   22 -----
 include/linux/platform_data/mtd-davinci-aemif.h |    5 +-
 8 files changed, 117 insertions(+), 35 deletions(-)
