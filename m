From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 30 Aug 2018 19:11:47 +0200
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180830171147.GP24082@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 05:15:34PM +0100, Will Deacon wrote:
> Peter Zijlstra (1):
>   asm-generic/tlb: Track freeing of page-table directories in struct
>     mmu_gather
> 
> Will Deacon (11):
>   arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
>   arm64: tlb: Add DSB ISHST prior to TLBI in
>     __flush_tlb_[kernel_]pgtable()
>   arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
>   arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
>   arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
>   arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
>   asm-generic/tlb: Guard with #ifdef CONFIG_MMU
>   asm-generic/tlb: Track which levels of the page tables have been
>     cleared
>   arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
>   arm64: tlb: Avoid synchronous TLBIs when freeing page tables
>   arm64: tlb: Rewrite stale comment in asm/tlbflush.h
> 
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/pgtable.h  |  10 +++-
>  arch/arm64/include/asm/tlb.h      |  34 +++++-------
>  arch/arm64/include/asm/tlbflush.h | 112 ++++++++++++++++++++++++--------------
>  include/asm-generic/tlb.h         |  85 +++++++++++++++++++++++++----
>  mm/memory.c                       |   4 +-
>  6 files changed, 168 insertions(+), 78 deletions(-)

These patches look good to me, thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
