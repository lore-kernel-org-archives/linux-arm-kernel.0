From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 09:36:34 +0200
Subject: [PATCHv11 0/8] Contiguous Memory Allocator
In-Reply-To: <20110706151112.5c619431.akpm@linux-foundation.org>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107051407.17249.arnd@arndb.de>
	<20110706151112.5c619431.akpm@linux-foundation.org>
Message-ID: <201107070936.34469.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 00:11:12 Andrew Morton wrote:
> I could review it and put it in there on a preliminary basis for some
> runtime testing.  But the question in my mind is how different will the
> code be after the problems which rmk has identified have been fixed?
> 
> If "not very different" then that effort and testing will have been
> worthwhile.
> 
> If "very different" or "unworkable" then it was all for naught.
> 
> So.  Do we have a feeling for the magnitude of the changes which will
> be needed to fix these things up?

As far as I can tell, the changes that we still need are mostly in the 
ARM specific portion of the series. All architectures that have cache
coherent DMA by default (most of the other interesting ones) can just
call dma_alloc_from_contiguous() from their dma_alloc_coherent()
function without having to do extra work.

It's possible that there will be small changes to simplify to the
first six patches in order to simplify the ARM port, but I expect
them to stay basically as they are, unless someone complains about
them.

	Arnd
