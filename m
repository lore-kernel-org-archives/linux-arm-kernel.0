From: will.deacon@arm.com (Will Deacon)
Date: Fri,  2 May 2014 16:24:07 +0100
Subject: [PATCH 0/8] ARM/arm64 Barrier cleanups and fixes for 3.16
Message-ID: <1399044255-20435-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is the current set of barrier cleanups and fixes I plan to queue
for merging in 3.16. Most of the arm64 patches have been posted before,
but there are also a few additions that I wrote recently.

All feedback welcome,

Will

Will Deacon (8):
  ARM: cacheflush: use -st dsb option for ensuring completion
  ARM: cache: remove redundant dsb instruction from
    v7_coherent_user_range
  arm64: barriers: make use of barrier options with explicit barriers
  arm64: barriers: wire up new barrier options
  arm64: barriers: use barrier() instead of smp_mb() when !SMP
  arm64: head: fix cache flushing and barriers in set_cpu_boot_mode_flag
  arm64: kvm: use inner-shareable barriers for inner-shareable
    maintenance
  arm64: mm: use inner-shareable barriers for inner-shareable
    maintenance

 arch/arm/include/asm/cacheflush.h   |  2 +-
 arch/arm/mm/cache-v7.S              | 13 ++++++-------
 arch/arm/mm/mmu.c                   |  2 +-
 arch/arm64/include/asm/barrier.h    | 20 ++++++++++----------
 arch/arm64/include/asm/cacheflush.h |  4 ++--
 arch/arm64/include/asm/pgtable.h    |  4 ++--
 arch/arm64/include/asm/tlbflush.h   | 14 +++++++-------
 arch/arm64/kernel/head.S            |  8 +++-----
 arch/arm64/kernel/process.c         |  2 +-
 arch/arm64/kvm/hyp.S                | 12 +++++++++---
 arch/arm64/kvm/sys_regs.c           |  4 ++--
 arch/arm64/mm/cache.S               |  6 +++---
 arch/arm64/mm/proc.S                |  2 +-
 arch/arm64/mm/tlb.S                 |  8 ++++----
 14 files changed, 52 insertions(+), 49 deletions(-)

-- 
1.9.2
