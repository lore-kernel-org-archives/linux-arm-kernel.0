From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 18 Jul 2011 16:09:03 -0400 (EDT)
Subject: Git pull request: removal of ARM_DMA_ZONE_SIZE
Message-ID: <alpine.LFD.2.00.1107181551440.21187@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

	http://git.linaro.org/git/people/nico/linux.git dma

This is rebased on the following commit from your repository on which 
this depends:

	022ae537 ARM: dma: replace ISA_DMA_THRESHOLD with a variable

All posted comments have been addressed and fixes folded in.

Nicolas Pitre (10):
      ARM: change ARM_DMA_ZONE_SIZE into a variable
      ARM: add dma_zone_size to the machine_desc structure
      ARM: mach-davinci: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-h720x: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-ixp4xx: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-pxa: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-realview: move from ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-sa1100: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: mach-shark: move ARM_DMA_ZONE_SIZE to mdesc->dma_zone_size
      ARM: ARM_DMA_ZONE_SIZE is no more

 arch/arm/include/asm/dma.h                   |   11 ++++++-----
 arch/arm/include/asm/mach/arch.h             |    4 ++++
 arch/arm/kernel/setup.c                      |    6 ++++++
 arch/arm/mach-davinci/board-da830-evm.c      |    1 +
 arch/arm/mach-davinci/board-da850-evm.c      |    1 +
 arch/arm/mach-davinci/board-dm355-evm.c      |    1 +
 arch/arm/mach-davinci/board-dm355-leopard.c  |    1 +
 arch/arm/mach-davinci/board-dm365-evm.c      |    1 +
 arch/arm/mach-davinci/board-dm644x-evm.c     |    1 +
 arch/arm/mach-davinci/board-dm646x-evm.c     |    2 ++
 arch/arm/mach-davinci/board-mityomapl138.c   |    1 +
 arch/arm/mach-davinci/board-neuros-osd2.c    |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c  |    1 +
 arch/arm/mach-davinci/board-sffsdr.c         |    1 +
 arch/arm/mach-davinci/board-tnetv107x-evm.c  |    1 +
 arch/arm/mach-davinci/include/mach/memory.h  |    7 -------
 arch/arm/mach-h720x/h7201-eval.c             |    1 +
 arch/arm/mach-h720x/h7202-eval.c             |    1 +
 arch/arm/mach-h720x/include/mach/memory.h    |    7 -------
 arch/arm/mach-ixp4xx/avila-setup.c           |    6 ++++++
 arch/arm/mach-ixp4xx/coyote-setup.c          |    3 +++
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |    3 +++
 arch/arm/mach-ixp4xx/fsg-setup.c             |    3 +++
 arch/arm/mach-ixp4xx/gateway7001-setup.c     |    3 +++
 arch/arm/mach-ixp4xx/goramo_mlr.c            |    3 +++
 arch/arm/mach-ixp4xx/gtwx5715-setup.c        |    3 +++
 arch/arm/mach-ixp4xx/include/mach/memory.h   |    4 ----
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |   12 ++++++++++++
 arch/arm/mach-ixp4xx/nas100d-setup.c         |    3 +++
 arch/arm/mach-ixp4xx/nslu2-setup.c           |    3 +++
 arch/arm/mach-ixp4xx/vulcan-setup.c          |    3 +++
 arch/arm/mach-ixp4xx/wg302v2-setup.c         |    3 +++
 arch/arm/mach-pxa/cm-x2xx.c                  |    3 +++
 arch/arm/mach-pxa/include/mach/memory.h      |    4 ----
 arch/arm/mach-realview/include/mach/memory.h |    4 ----
 arch/arm/mach-realview/realview_eb.c         |    3 +++
 arch/arm/mach-realview/realview_pb1176.c     |    3 +++
 arch/arm/mach-realview/realview_pb11mp.c     |    3 +++
 arch/arm/mach-realview/realview_pba8.c       |    3 +++
 arch/arm/mach-realview/realview_pbx.c        |    3 +++
 arch/arm/mach-sa1100/assabet.c               |    3 +++
 arch/arm/mach-sa1100/badge4.c                |    3 +++
 arch/arm/mach-sa1100/include/mach/memory.h   |    4 ----
 arch/arm/mach-sa1100/jornada720.c            |    3 +++
 arch/arm/mach-shark/core.c                   |    1 +
 arch/arm/mach-shark/include/mach/memory.h    |    2 --
 arch/arm/mm/init.c                           |   20 +++++++++++---------
 47 files changed, 118 insertions(+), 46 deletions(-)


Nicolas
