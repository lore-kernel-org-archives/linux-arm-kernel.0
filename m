From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 17:24:50 +0100
Subject: [PATCH 0/2] Consolidate zone adjustment
Message-ID: <20110511162450.GF5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch mini-series consolidates the adjustment to system zones
which some of our platforms require.  Rather than having each
platform/machine class specify ISA_DMA_THRESHOLD, MAX_DMA_ADDRESS
and an arch_adjust_zones function, they really only need to provide
a single sizing definition, which in this series will be called
ARM_DMA_ZONE_SIZE.

 arch/arm/common/sa1111.c                     |    8 -------
 arch/arm/include/asm/dma.h                   |    4 ++-
 arch/arm/include/asm/memory.h                |   10 ++------
 arch/arm/mach-davinci/include/mach/memory.h  |   18 +----------------
 arch/arm/mach-h720x/include/mach/memory.h    |    3 +-
 arch/arm/mach-ixp4xx/common-pci.c            |   23 ----------------------
 arch/arm/mach-ixp4xx/include/mach/memory.h   |   12 +---------
 arch/arm/mach-pxa/cm-x2xx-pci.c              |   27 --------------------------
 arch/arm/mach-pxa/include/mach/memory.h      |   10 +-------
 arch/arm/mach-realview/core.c                |   19 ------------------
 arch/arm/mach-realview/include/mach/memory.h |    9 +------
 arch/arm/mach-sa1100/include/mach/memory.h   |   12 +----------
 arch/arm/mach-shark/include/mach/memory.h    |   20 +------------------
 arch/arm/mm/init.c                           |   23 +++++++++++++++++++++-
 14 files changed, 38 insertions(+), 160 deletions(-)
