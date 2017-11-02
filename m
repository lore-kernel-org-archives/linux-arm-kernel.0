From: will.deacon@arm.com (Will Deacon)
Date: Thu, 2 Nov 2017 10:19:33 +0000
Subject: [RFC/RFT PATCH 0/6] Switch GHES ioremap_page_range() to use fixmap
In-Reply-To: <20171031153832.17746-1-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
Message-ID: <20171102101933.GC11881@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 31, 2017 at 03:38:26PM +0000, James Morse wrote:
> GHES is doing ioremap_page_range() in both NMI and irq context, neither
> are safe as it may sleep to allocate intermediate levels of page table.
> 
> Replace the NMI/irq GHES_IOREMAP_PAGES to use a fixmap entry each.
> 
> After this nothing uses ghes_ioremap_area or arch_apei_flush_tlb_one(),
> rip them out.
> 
> RFC as I've only build-tested this on x86. For arm64 I've tested it on a
> software model. Any more testing would be welcome. These patches are based
> on rc7.
> 
> Thanks,
> 
> James Morse (6):
>   arm64: fixmap: Add GHES fixmap entries
>   x86/mm/fixmap: Add GHES fixmap entries
>   ACPI / APEI:  Replace ioremap_page_range() with fixmap
>   ACPI / APEI: Remove ghes_ioremap_area
>   arm64: mm: Remove arch_apei_flush_tlb_one()
>   ACPI / APEI: Remove arch_apei_flush_tlb_one()
> 
>  arch/arm64/include/asm/acpi.h   | 12 ------
>  arch/arm64/include/asm/fixmap.h |  5 +++
>  arch/arm64/mm/mmu.c             |  4 ++

If you need it:

Acked-by: Will Deacon <will.deacon@arm.com>

for the arm64 bits.

Will
