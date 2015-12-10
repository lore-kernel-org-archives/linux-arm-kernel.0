From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Dec 2015 14:23:45 +0000
Subject: [RFC PATCH 04/20] arm64: mm: assume PAGE SIZE for page table
 allocator
In-Reply-To: <20151210140840.GE21134@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
 <1449665095-20774-5-git-send-email-mark.rutland@arm.com>
 <20151210140840.GE21134@arm.com>
Message-ID: <20151210142344.GA495@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 02:08:40PM +0000, Will Deacon wrote:
> On Wed, Dec 09, 2015 at 12:44:39PM +0000, Mark Rutland wrote:
> > We pass a size parameter to early_alloc and late_alloc, but these are
> > only ever used to allocate single pages. In late_alloc we always
> > allocate a single page.
> > 
> > Remove the redundant size parameter.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Laura Abbott <labbott@fedoraproject.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/mm/mmu.c | 27 ++++++++++++---------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> Looks sensible to me. Cosmetic nit, but we could we rename these to
> early_page_alloc/late_page_alloc instead, please?

Sure. I'll also s/alloc/page_alloc/ for the function pointer. Luckily
this doesn't clash with the usual alloc_page function.

I'll also fix up the zero page init, as I forgot to remove the PAGE_SIZE
parameter in that early_alloc() call there.

Thanks,
Mark.
