From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Oct 2015 18:46:20 +0100
Subject: [PATCH v2 00/10] arm64 switch_mm improvements
Message-ID: <1444153590-24173-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches previously posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/370720.html

Changes since v1 include:

  * More comments
  * Added reviewed-by tags

Cheers,

Will

--->8

Will Deacon (10):
  arm64: mm: remove unused cpu_set_idmap_tcr_t0sz function
  arm64: proc: de-scope TLBI operation during cold boot
  arm64: flush: use local TLB and I-cache invalidation
  arm64: mm: rewrite ASID allocator and MM context-switching code
  arm64: tlbflush: remove redundant ASID casts to (unsigned long)
  arm64: tlbflush: avoid flushing when fullmm == 1
  arm64: switch_mm: simplify mm and CPU checks
  arm64: mm: kill mm_cpumask usage
  arm64: tlb: remove redundant barrier from __flush_tlb_pgtable
  arm64: mm: remove dsb from update_mmu_cache

 arch/arm64/include/asm/cacheflush.h  |   7 ++
 arch/arm64/include/asm/mmu.h         |  15 +--
 arch/arm64/include/asm/mmu_context.h | 113 ++++-------------
 arch/arm64/include/asm/pgtable.h     |   6 +-
 arch/arm64/include/asm/thread_info.h |   1 -
 arch/arm64/include/asm/tlb.h         |  26 ++--
 arch/arm64/include/asm/tlbflush.h    |  18 ++-
 arch/arm64/kernel/asm-offsets.c      |   2 +-
 arch/arm64/kernel/efi.c              |   5 +-
 arch/arm64/kernel/smp.c              |   9 +-
 arch/arm64/kernel/suspend.c          |   2 +-
 arch/arm64/mm/context.c              | 236 +++++++++++++++++++++--------------
 arch/arm64/mm/mmu.c                  |   2 +-
 arch/arm64/mm/proc.S                 |   6 +-
 14 files changed, 222 insertions(+), 226 deletions(-)

-- 
2.1.4
