From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 10:40:23 +0000
Subject: [PATCHv2 14/18] arm64: mm: use fixmap when creating page tables
In-Reply-To: <568AF472.6060901@redhat.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <1451930211-22460-15-git-send-email-mark.rutland@arm.com>
 <568AF472.6060901@redhat.com>
Message-ID: <20160105104022.GA24664@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 04, 2016 at 02:38:42PM -0800, Laura Abbott wrote:
> On 01/04/2016 09:56 AM, Mark Rutland wrote:
> >As a prepratory step to allow us to allocate early page tables form
> "page tables from"

Fixed.

> >-#define pud_fixmap_offset(pgd, addr)	pud_fixmap(pmd_offset_phys(pgd, addr))
> >+#define pud_fixmap_offset(pgd, addr)	pud_fixmap(pud_offset_phys(pgd, addr))
> 
> Was this supposed to be folded into a previous patch?

Yes. I've folded that into the prior patch now.

> >-static void *late_pgtable_alloc(void)
> >+static phys_addr_t late_pgtable_alloc(void)
> >  {
> >  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> >  	BUG_ON(!ptr);
> >-
> >-	/* Ensure the zeroed page is visible to the page table walker */
> >  	dsb(ishst);
> 
> This dropped the comment but not the actual barrier, was that intentional?

I messed that up when rebasing. Restored now.

Thanks for pointing those out!

Mark.
