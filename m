From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 11 Feb 2010 11:03:19 +0000
Subject: [RFC 0/2] fix dma_map_sg not to do barriers for each buffer
In-Reply-To: <20100211110119.GC9480@n2100.arm.linux.org.uk>
References: <20100210212156.GB30854@n2100.arm.linux.org.uk>
	<1265885102.3389.34.camel@pc1117.cambridge.arm.com>
	<1265885585.3389.38.camel@pc1117.cambridge.arm.com>
	<20100211110119.GC9480@n2100.arm.linux.org.uk>
Message-ID: <1265886199.3389.47.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-02-11 at 11:01 +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 11, 2010 at 10:53:05AM +0000, Catalin Marinas wrote:
> > Actually after L2 maintenance we don't even need the __dma_barrier(), we
> > need an outer_cache.sync() function.
> >
> > I can do the outer cache optimisations together with a few others for
> > PL310 (which does not require the cache_wait() call for line
> > operations).
> 
> I'm in half a mind to say "stop everything for the DMA API and wait
> until the next merge window" - what we have at the moment is a big
> shake up of how the API is implemented, which has had very little
> attributable testing.
> 
> Let's get the current code (which missed the last merge window) tested,
> acked and merged, and only then sort out these kinds of optimizations
> after that.  As it is, these DMA patches have had very little in the
> way of attributable feedback so far.

I agree, I wasn't planning to submit anything for 2.6.34. These
optimisations should probably get in 2.6.35.

-- 
Catalin
