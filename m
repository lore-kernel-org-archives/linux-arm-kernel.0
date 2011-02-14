From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 17:39:47 +0000
Subject: [RFC PATCH 0/2] Support caching of higher page table level entries
Message-ID: <20110214173847.21717.91096.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer processors like Cortex-A15 may cache entries in the higher page
table levels. These cached entries are ASID-tagged and are invalidated
during normal TLB operations.

This causing problems in two areas: context switching and page tables
freeing. The patches in this series contain a more detailed explanation
of the failing scenarios.


Catalin Marinas (2):
      ARMv7: Use a reserved TTB rather than ASID 0 during context switch
      ARMv7: Invalidate the TLB before freeing page tables


 arch/arm/include/asm/tlb.h      |   17 +++++++++++++++--
 arch/arm/include/asm/tlbflush.h |   16 +++++++++++-----
 arch/arm/kernel/head.S          |    3 +++
 arch/arm/kernel/smp_tlb.c       |   11 ++++++-----
 arch/arm/mm/proc-v7.S           |   11 +++++++----
 5 files changed, 42 insertions(+), 16 deletions(-)

-- 
Catalin
