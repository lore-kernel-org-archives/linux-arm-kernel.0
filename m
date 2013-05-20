From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 15:51:35 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 2)
Message-ID: <20130520195135.GH31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 00ed4a0bd964555fe9276f2299564c384d50ae7d:

  ARM: mvebu: Add a ranges entry to translate devbus childs (2013-05-13 16:23:47 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-2

for you to fetch changes up to 489e138eec96f529c5e8d4cd3ea45882ecdbf5ca:

  ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node (2013-05-20 17:44:54 +0000)

----------------------------------------------------------------
mvebu fixes for v3.10 (round 2)

 - mvebu (and orion SoCs)
    - remove init_dma_coherent_pool_size()

 - mvebu
    - fix ranges DT property
    - fix DT reg value for L2 cache
    - select ARCH_REQUIRE_GPIOLIB

 - orion legacy
    - fix num_resources and id for ge10 and ge11

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Orion: Remove redundant init_dma_coherent_pool_size()

Ezequiel Garcia (1):
      ARM: mvebu: Fix ranges entry on XP GP board

Gregory CLEMENT (3):
      ARM: mvebu: select ARCH_REQUIRE_GPIOLIB for mvebu platform
      ARM: plat-orion: Fix num_resources and id for ge10 and ge11
      ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node

Thomas Petazzoni (1):
      arm: mvebu: fix the 'ranges' property to handle PCIe

 arch/arm/boot/dts/armada-370-xp.dtsi |  3 ++-
 arch/arm/boot/dts/armada-370.dtsi    |  5 +++--
 arch/arm/boot/dts/armada-xp-gp.dts   |  3 +++
 arch/arm/mach-kirkwood/common.c      |  6 ------
 arch/arm/mach-mvebu/Kconfig          |  1 +
 arch/arm/mach-mvebu/armada-370-xp.c  |  7 -------
 arch/arm/mach-orion5x/common.c       |  7 -------
 arch/arm/plat-orion/common.c         | 12 ++++++------
 8 files changed, 15 insertions(+), 29 deletions(-)
