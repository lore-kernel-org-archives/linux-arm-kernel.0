From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 11:29:29 +0100
Subject: [PATCH v4 0/8] Patches/fixes for 2.6.35
Message-ID: <20100621102639.9353.37648.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates from version 3 of these series:

- noMMU warning patch changed by moving the CONSISTENT_* definitions to
  the CONFIG_MMU section
- .phys_io alignment patch replaced by two patches that enforce the
  alignment in the machine_desc structures for VExpress and RealView
- commit log added to the T2 module relocations patch


Catalin Marinas (8):
      ARM: Avoid the CONSISTENT_DMA_SIZE warning on noMMU builds
      ARM: The v6_dma_inv_range() function must preserve data on SMP
      ARM: Add a config option for the ARM11MPCore DMA cache maintenance workaround
      ARM: Add support for the MOVW/MOVT relocations in Thumb-2
      ARM: Remove dummy loads from the original relocation address
      ARM: Do not compile the Thumb-2 module relocations on an ARM kernel
      ARM: VExpress: Align the machine_desc.phys_io to 1MB section
      ARM: RealView: Align the machine_desc.phys_io to 1MB section


 arch/arm/include/asm/elf.h               |    2 ++
 arch/arm/kernel/module.c                 |   34 ++++++++++++++++++++++++++++++
 arch/arm/mach-realview/realview_eb.c     |    3 ++-
 arch/arm/mach-realview/realview_pb1176.c |    3 ++-
 arch/arm/mach-realview/realview_pb11mp.c |    3 ++-
 arch/arm/mach-realview/realview_pba8.c   |    3 ++-
 arch/arm/mach-realview/realview_pbx.c    |    3 ++-
 arch/arm/mach-vexpress/ct-ca9x4.c        |    3 ++-
 arch/arm/mm/Kconfig                      |   19 +++++++++++++++++
 arch/arm/mm/cache-v6.S                   |   18 ++++++++++++----
 arch/arm/mm/dma-mapping.c                |   18 ++++++++--------
 11 files changed, 90 insertions(+), 19 deletions(-)

-- 
Catalin
