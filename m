From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 1 Feb 2013 10:32:07 -0500
Subject: [GIT PULL] ARM: LPAE Fixes - Part 1 for v3.9
Message-ID: <510BDFF7.4050405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

   Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

 
git://git.kernel.org/pub/scm/linux/kernel/git/cchemparathy/linux-keystone.git 
upstream/keystone-lpae-v4

for you to fetch changes up to 4dc17a8282221854896a0d6a83c758fde4f9b139:

   ARM: fix type of PHYS_PFN_OFFSET to unsigned long (2013-02-01 
09:37:53 -0500)

----------------------------------------------------------------
Cyril Chemparathy (10):
       ARM: LPAE: use signed arithmetic for mask definitions
       ARM: LPAE: use phys_addr_t in switch_mm()
       ARM: LPAE: use 64-bit accessors for TTBR registers
       ARM: LPAE: define ARCH_LOW_ADDRESS_LIMIT for bootmem
       ARM: LPAE: factor out T1SZ and TTBR1 computations
       ARM: LPAE: accomodate >32-bit addresses for page table base
       ARM: mm: use physical addresses in highmem sanity checks
       ARM: mm: cleanup checks for membank overlap with vmalloc area
       ARM: mm: clean up membank size limit checks
       ARM: fix type of PHYS_PFN_OFFSET to unsigned long

Vitaly Andrianov (3):
       ARM: LPAE: use phys_addr_t in alloc_init_pud()
       ARM: LPAE: use phys_addr_t in free_memmap()
       ARM: LPAE: use phys_addr_t for initrd location

  arch/arm/include/asm/memory.h               |   20 +++++++++-
  arch/arm/include/asm/page.h                 |    2 +-
  arch/arm/include/asm/pgtable-3level-hwdef.h |   20 ++++++++++
  arch/arm/include/asm/pgtable-3level.h       |    6 +--
  arch/arm/include/asm/proc-fns.h             |   26 +++++++++----
  arch/arm/kernel/head.S                      |   10 ++---
  arch/arm/kernel/smp.c                       |   11 +++++-
  arch/arm/mm/context.c                       |    9 +----
  arch/arm/mm/init.c                          |   19 +++++-----
  arch/arm/mm/mmu.c                           |   49 
+++++++++----------------
  arch/arm/mm/proc-v7-3level.S                |   53 
++++++++++++++-------------
  11 files changed, 132 insertions(+), 93 deletions(-)
