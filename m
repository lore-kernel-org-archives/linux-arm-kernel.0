From: tixy@yxit.co.uk (Tixy)
Date: Mon, 22 Aug 2011 17:56:06 +0100
Subject: [GIT PULL] ARM: Remove define CONSISTENT_DMA_SIZE
Message-ID: <1314032166.29940.36.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Please can you pull these patches for inclusion in 3.2?

This removes the constant defined by CONSISTENT_DMA_SIZE and adds a
function to set the value at boot time instead. This is being done a
part of the ongoing work to enable multiple platforms to be supported
within a single kernel binary.

Thanks

-- 
Jon Medhurst (usually known as Tixy)


The following changes since commit 93ee7a9340d64f20295aacc3fb6a22b759323280:

  Linux 3.1-rc2 (2011-08-14 15:09:08 -0700)

are available in the git repository at:
  git://git.yxit.co.uk/linux dma-size

Jon Medhurst (12):
      ARM: Add init_consistent_dma_size()
      ARM: omap: Setup consistent dma size at boot time
      ARM: mach-s3c64xx: Setup consistent dma size at boot time
      ARM: mach-s5p64x0: Setup consistent dma size at boot time
      ARM: mach-s5pv210: Setup consistent dma size at boot time
      ARM: mxc: Remove setting of consistent dma size
      ARM: mach-davinci: Setup consistent dma size at boot time
      ARM: mach-u300: Setup consistent dma size at boot time
      ARM: mach-at91: Setup consistent dma size at boot time
      ARM: mach-bcmring: Setup consistent dma size at boot time
      ARM: mach-shmobile: Setup consistent dma size at boot time
      ARM: Remove support for macro CONSISTENT_DMA_SIZE

 arch/arm/include/asm/dma-mapping.h            |    7 ++++
 arch/arm/include/asm/memory.h                 |    9 -----
 arch/arm/mach-at91/at91sam9g45.c              |    2 +
 arch/arm/mach-at91/include/mach/at91sam9g45.h |    2 -
 arch/arm/mach-bcmring/include/mach/memory.h   |    5 ---
 arch/arm/mach-bcmring/mm.c                    |    3 ++
 arch/arm/mach-davinci/common.c                |    3 ++
 arch/arm/mach-davinci/include/mach/memory.h   |    5 ---
 arch/arm/mach-omap1/io.c                      |    1 +
 arch/arm/mach-omap2/io.c                      |    2 +-
 arch/arm/mach-s3c64xx/cpu.c                   |    2 +
 arch/arm/mach-s3c64xx/include/mach/memory.h   |    2 -
 arch/arm/mach-s5p64x0/cpu.c                   |    3 ++
 arch/arm/mach-s5p64x0/include/mach/memory.h   |    1 -
 arch/arm/mach-s5pv210/cpu.c                   |    2 +
 arch/arm/mach-s5pv210/include/mach/memory.h   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c         |    3 ++
 arch/arm/mach-shmobile/board-ap4evb.c         |    3 ++
 arch/arm/mach-shmobile/board-g3evm.c          |    3 ++
 arch/arm/mach-shmobile/board-g4evm.c          |    3 ++
 arch/arm/mach-shmobile/board-mackerel.c       |    3 ++
 arch/arm/mach-shmobile/include/mach/memory.h  |    3 --
 arch/arm/mach-u300/core.c                     |    3 ++
 arch/arm/mach-u300/include/mach/memory.h      |    5 ---
 arch/arm/mm/dma-mapping.c                     |   45 +++++++++++++++++++------
 arch/arm/mm/init.c                            |    9 -----
 arch/arm/plat-mxc/include/mach/memory.h       |   15 --------
 arch/arm/plat-omap/include/plat/io.h          |    2 +
 arch/arm/plat-omap/include/plat/memory.h      |   13 -------
 arch/arm/plat-omap/io.c                       |    8 ++++
 30 files changed, 86 insertions(+), 82 deletions(-)
