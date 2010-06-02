From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 02 Jun 2010 18:02:11 +0100
Subject: [PATCH v2 0/8] Patches for 2.6.35
Message-ID: <20100602170039.18569.41823.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a set of patches I'd like to get merged in 2.6.35 (during the
-rc) period.

The first one was posted some time ago but deferred because of other
conflicting patch (the 16-way PL310).

Some of the other patches are necessary fixes plus a few trivial ones.

Thanks.


Catalin Marinas (8):
      ARM: Improve the L2 cache performance when PL310 is used
      ARM: Align machine_desc.phys_io to a 1MB section
      ARM: Avoid the CONSISTENT_DMA_SIZE warning on noMMU builds
      ARM: The v6_dma_inv_range() function must preserve data on SMP
      ARM: Add a config option for the ARM11MPCore DMA cache maintenance workaround
      ARM: Add support for the MOVW/MOVT relocations in Thumb-2
      ARM: Remove dummy loads from the original relocation address
      ARM: Do not compile the Thumb-2 module relocations on an ARM kernel


 arch/arm/include/asm/elf.h |    2 +
 arch/arm/kernel/head.S     |    2 +
 arch/arm/kernel/module.c   |   34 +++++++++++++++++++++++
 arch/arm/mm/Kconfig        |   26 ++++++++++++++++++
 arch/arm/mm/cache-l2x0.c   |   65 ++++++++++++++++++++++++++++++--------------
 arch/arm/mm/cache-v6.S     |   18 +++++++++---
 arch/arm/mm/dma-mapping.c  |    2 +
 7 files changed, 124 insertions(+), 25 deletions(-)

-- 
Catalin
