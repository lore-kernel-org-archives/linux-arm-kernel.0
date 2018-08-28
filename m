From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2018 14:12:43 +0100
Subject: [RFC PATCH 09/11] asm-generic/tlb: Track which levels of the
 page tables have been cleared
In-Reply-To: <20180827075341.GY24124@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-10-git-send-email-will.deacon@arm.com>
 <20180827075341.GY24124@hirez.programming.kicks-ass.net>
Message-ID: <20180828131243.GC26727@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 09:53:41AM +0200, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 04:52:44PM +0100, Will Deacon wrote:
> > +static inline unsigned long tlb_get_unmap_granule(struct mmu_gather *tlb)
> > +{
> > +	if (tlb->cleared_ptes)
> > +		return PAGE_SIZE;
> > +	if (tlb->cleared_pmds)
> > +		return PMD_SIZE;
> > +	if (tlb->cleared_puds)
> > +		return PUD_SIZE;
> > +	if (tlb->cleared_p4ds)
> > +		return P4D_SIZE;
> > +
> > +	return PAGE_SIZE;
> > +}
> 
> When doing the x86 patch; I found _SHIFT more useful than _SIZE.

I'll make that change for the next version.

Cheers,

Will
