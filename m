From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Oct 2011 16:24:45 +0200
Subject: [PATCHv16 0/9] Contiguous Memory Allocator
In-Reply-To: <20111014161951.5b4bb327.akpm@linux-foundation.org>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<201110111552.04615.arnd@arndb.de>
	<20111014161951.5b4bb327.akpm@linux-foundation.org>
Message-ID: <201110151624.47336.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 October 2011, Andrew Morton wrote:
> 
> On Tue, 11 Oct 2011 15:52:04 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> > What I would really want to hear from you is your opinion on
> > the architecture independent stuff. Obviously, ARM is the
> > most important consumer of the patch set, but I think the
> > code has its merit on other architectures as well and most of
> > them (maybe not parisc) should be about as simple as the x86
> > one that Marek posted now with v16.
> 
> Having an x86 implementation is good.  It would also be good to get
> some x86 drivers using CMA asap, so the thing gets some runtime testing
> from the masses.  Can we think of anything we can do here?

With the current implementation, all drivers that use dma_alloc_coherent
automatically use CMA, there is no need to modify any driver. On
the other hand, nothing on x86 currently actually requires this feature
(otherwise it would be broken already), making it hard to test the
actual migration path.

The best test I can think of would be a network benchmark under memory
pressure, preferrably one that use large jumbo frames (64KB).

	Arnd
