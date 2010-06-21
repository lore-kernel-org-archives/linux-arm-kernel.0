From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jun 2010 10:13:25 +0100
Subject: [PATCH v3 0/7] Patches/fixes for 2.6.35
Message-ID: <20100621090801.22752.21039.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just reposting these patches as they contain some bug-fixes and should
get in before 2.6.35 is released.

>From my previous posts, I removed the PL310 lock optimisation patch
(there are some discussions on optimising the range operations for large
memory blocks and these would be faster as background All operations).

If there are no further comments to these patches, I'll send them to the
patch system.

Thanks.


Catalin Marinas (7):
      ARM: Align machine_desc.phys_io to a 1MB section
      ARM: Avoid the CONSISTENT_DMA_SIZE warning on noMMU builds
      ARM: The v6_dma_inv_range() function must preserve data on SMP
      ARM: Add a config option for the ARM11MPCore DMA cache maintenance workaround
      ARM: Add support for the MOVW/MOVT relocations in Thumb-2
      ARM: Remove dummy loads from the original relocation address
      ARM: Do not compile the Thumb-2 module relocations on an ARM kernel


 arch/arm/include/asm/elf.h |    2 ++
 arch/arm/kernel/head.S     |    2 ++
 arch/arm/kernel/module.c   |   34 ++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig        |   19 +++++++++++++++++++
 arch/arm/mm/cache-v6.S     |   18 ++++++++++++++----
 arch/arm/mm/dma-mapping.c  |    2 ++
 6 files changed, 73 insertions(+), 4 deletions(-)

-- 
Catalin
