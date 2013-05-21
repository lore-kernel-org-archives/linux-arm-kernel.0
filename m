From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 17:07:26 +0100
Subject: [PATCH v3 0/7] ARM: KVM: various mmu related fixes for 3.10
In-Reply-To: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130521160725.GP27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:11:33PM +0100, Marc Zyngier wrote:
> This patch series fixes a number of of KVM/ARM issues that have either
> been spotted during the review of the arm64 code, or while reworking
> related code.
> 
> Only the first patch fixes a potential (if unlikely) problem, the
> others are either cosmetic or performance related.
> 
> Tested on TC-2, based on 3.10-rc1.
> 
> * From v2:
>   - [1/7] Drop the unnecessary "TLB invalidate all", as we already do
>   it on a page-per-page level.
>   - [3/7] Add a cache cleaning primitive, move the cleaning outside of
>   kvm_set_pte(), and clean a range as large as possible when inserting
>   PTEs.
>   - [4,5,7/7] New patches
> 
> Marc Zyngier (7):
>   ARM: KVM: be more thorough when invalidating TLBs
>   ARM: KVM: remove dead prototype for __kvm_tlb_flush_vmid
>   ARM: KVM: relax cache maintainance when building page tables
>   ARM: KVM: use phys_addr_t instead of unsigned long long for HYP PGDs
>   ARM: KVM: don't special case PC when doing an MMIO
>   ARM: KVM: get rid of S2_PGD_SIZE
>   ARM: KVM: drop use of PAGE_S2_DEVICE

This series looks good to me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
