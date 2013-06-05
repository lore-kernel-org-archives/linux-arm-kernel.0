From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jun 2013 17:37:18 +0100
Subject: [GIT PULL] LPAE fixes for 3.11
Message-ID: <20130605163718.GI11402@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull these miscellaneous LPAE fixes I've been collecting for a while
now for 3.11. They've been tested and reviewed by quite a few people, and most
of the patches are pretty trivial.

Cheers,

Will

--->8

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-rmk/lpae

for you to fetch changes up to a469abd0f868c902b75532579bf87553dcf1b360:

  ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions (2013-05-30 16:02:34 +0100)

----------------------------------------------------------------
Cyril Chemparathy (9):
      ARM: LPAE: use signed arithmetic for mask definitions
      ARM: LPAE: use phys_addr_t in switch_mm()
      ARM: LPAE: use 64-bit accessors for TTBR registers
      ARM: LPAE: factor out T1SZ and TTBR1 computations
      ARM: LPAE: accomodate >32-bit addresses for page table base
      ARM: mm: use physical addresses in highmem sanity checks
      ARM: fix type of PHYS_PFN_OFFSET to unsigned long
      ARM: mm: cleanup checks for membank overlap with vmalloc area
      ARM: mm: clean up membank size limit checks

Vitaly Andrianov (3):
      ARM: LPAE: use phys_addr_t in alloc_init_pud()
      ARM: LPAE: use phys_addr_t in free_memmap()
      ARM: LPAE: use phys_addr_t for initrd location

Will Deacon (2):
      ARM: lpae: fix definition of PTE_HWTABLE_PTRS
      ARM: elf: add new hwcap for identifying atomic ldrd/strd instructions

 arch/arm/include/asm/memory.h               | 18 +++++++++++++++++-
 arch/arm/include/asm/page.h                 |  2 +-
 arch/arm/include/asm/pgtable-3level-hwdef.h | 20 ++++++++++++++++++++
 arch/arm/include/asm/pgtable-3level.h       |  8 ++++----
 arch/arm/include/asm/proc-fns.h             | 26 +++++++++++++++++++-------
 arch/arm/include/uapi/asm/hwcap.h           |  2 +-
 arch/arm/kernel/head.S                      | 10 ++++------
 arch/arm/kernel/setup.c                     |  8 +++++++-
 arch/arm/kernel/smp.c                       | 11 +++++++++--
 arch/arm/mm/context.c                       |  9 ++-------
 arch/arm/mm/init.c                          | 19 ++++++++++---------
 arch/arm/mm/mmu.c                           | 49 +++++++++++++++++--------------------------------
 arch/arm/mm/proc-v7-3level.S                | 53 ++++++++++++++++++++++++++++-------------------------
 13 files changed, 139 insertions(+), 96 deletions(-)
