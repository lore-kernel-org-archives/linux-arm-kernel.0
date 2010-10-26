From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Oct 2010 19:08:43 +0100
Subject: [PATCH] ARM: memblock: set allocation limit for
	MEMBLOCK_ALLOC_ANYWHERE
In-Reply-To: <20101026105638.GA2092@n2100.arm.linux.org.uk>
References: <20101025104800.6961.70715.stgit@e102109-lin.cambridge.arm.com>
	<20101025151513.GB21105@n2100.arm.linux.org.uk>
	<1288047336.6035.12.camel@jazztop>
	<20101026105638.GA2092@n2100.arm.linux.org.uk>
Message-ID: <1288116524.5506.1.camel@jazztop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 2010-10-26 at 11:56 +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 25, 2010 at 11:55:36PM +0100, Will Deacon wrote:
> > Right. I could also move this call out of sanity_check_meminfo
> > and into arm_memblock_init now that we don't need lowmem_end_addr
> > to be initialised. If you're happy with me making that change then
> > I'll post a revised version to the patch system.
> 
> It looks like we're doing a few things out of order.  Yes, it makes
> sense to move that initialization to arm_memblock_init(), but as we're
> not running sanity_check_meminfo(), it could mean there's problems
> with out of order membanks and similar.
> 
We could move the arm_memblock_init() call into paging_init, immediately
after the call to sanity_check_meminfo. I think everything should be
safe then.

> I'll look at that when I'm back.

Great, thanks.

Will
