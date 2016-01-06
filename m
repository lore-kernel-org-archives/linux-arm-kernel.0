From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jan 2016 10:24:49 +0000
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
In-Reply-To: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160106102448.GI6301@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:56:33PM +0000, Mark Rutland wrote:
> Mark Rutland (18):
>   asm-generic: make __set_fixmap_offset a static inline
>   arm64: mm: specialise pagetable allocators
>   arm64: mm: place empty_zero_page in bss
>   arm64: unify idmap removal
>   arm64: unmap idmap earlier
>   arm64: add function to install the idmap
>   arm64: mm: add code to safely replace TTBR1_EL1
>   arm64: kasan: avoid TLB conflicts
>   arm64: mm: move pte_* macros
>   arm64: mm: add functions to walk page tables by PA
>   arm64: mm: avoid redundant __pa(__va(x))
>   arm64: mm: add __{pud,pgd}_populate
>   arm64: mm: add functions to walk tables in fixmap
>   arm64: mm: use fixmap when creating page tables
>   arm64: mm: allocate pagetables anywhere
>   arm64: mm: allow passing a pgdir to alloc_init_*
>   arm64: ensure _stext and _etext are page-aligned
>   arm64: mm: create new fine-grained mappings at boot

The patches look fine (once you fix the issues Laura raised). Thanks for
putting them together.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I'll queue them sometime after -rc1, in the meantime keep you branch up
to date so that Ard and Jeremy can base their patches on top.

(now going to look at the KASLR patches, would make more sense once I
read this series ;))

-- 
Catalin
