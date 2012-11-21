From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Nov 2012 11:31:20 +0100
Subject: [GIT PULL] Add hardware I/O coherency support for Armada 370/XP
Message-ID: <50ACAD78.2050600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

here it is (I think) our last git pull for 3.8. This patch set adds
the hardware I/O coherency support for Armada 370/XP. The 1st and 3rd
patch have received an acked-by from Marek Szyprowski.

Thanks

The following changes since commit e09155559cf88116436c82057a40a9bc64d88c81:

  arm: mvebu: Added SMP support for Armada XP (2012-11-20 18:58:28 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-hwiocc-for-3.8

for you to fetch changes up to 8116db9a870d262ac927d3a0441dc99c2bb7ae00:

  arm: mvebu: Add hardware I/O Coherency support (2012-11-21 11:12:39 +0100)

----------------------------------------------------------------
Add hardware I/O coherency support for Armada 370/XP

The purpose of this patch set is to add hardware I/O Coherency support
for Armada 370 and Armada XP. Theses SoCs come with an unit called
coherency fabric. A beginning of the support for this unit have been
introduced with the SMP patch set. This series extend this support:
the coherency fabric unit allows to use the Armada XP and the Armada
370 as nearly coherent architectures.

The third patches enables this new feature and register our own set
of DMA ops, to benefit this hardware enhancement.

The first patches exports a dma operation function needed to register
our own set of dma ops.

The second patch introduces a new flag for the address decoding
configuration in order to be able to set the memory windows as
shared memory.

----------------------------------------------------------------
Gregory CLEMENT (3):
      arm: dma mapping: Export a dma ops function arm_dma_set_mask
      arm: plat-orion: Add coherency attribute when setup mbus target
      arm: mvebu: Add hardware I/O Coherency support

 .../devicetree/bindings/arm/coherency-fabric.txt   |    9 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |    3 +-
 arch/arm/include/asm/dma-mapping.h                 |    2 +
 arch/arm/mach-mvebu/addr-map.c                     |    3 +
 arch/arm/mach-mvebu/coherency.c                    |   73 ++++++++++++++++++++
 arch/arm/mm/dma-mapping.c                          |    4 +-
 arch/arm/plat-orion/addr-map.c                     |    4 ++
 arch/arm/plat-orion/include/plat/addr-map.h        |    1 +
 8 files changed, 93 insertions(+), 6 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
