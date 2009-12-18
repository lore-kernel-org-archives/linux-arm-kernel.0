From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Dec 2009 14:50:22 -0500 (EST)
Subject: "Flush the D-cache during copy_user_highpage" breaks compile for
	v7 on -rc1
In-Reply-To: <20091218081851.GB28704@n2100.arm.linux.org.uk>
References: <20091218031923.GA4575@atomide.com>
	<20091218081851.GB28704@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.0912181448120.28241@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Dec 2009, Russell King - ARM Linux wrote:

> On Thu, Dec 17, 2009 at 07:19:24PM -0800, Tony Lindgren wrote:
> > Hi Catalin,
> > 
> > You may have already run into this, but if not, looks like commit
> > 115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:
> > 
> > arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> > arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> > 
> > Undoing that makes it work again.
> 
> It's a combination of changes - my initial changes for fixing the ARMv7
> DMA support went in last night, but were based on a tree older than
> Catalin's changes, which had already been committed.
> 
> My test build didn't catch any of these - it's the usual problem that
> there is no way to adequately build-test the ARM kernel in a reasonable
> time anymore.

This is why we have a community of people reporting such issues, and a 
long -rc period to fix them.


Nicolas
