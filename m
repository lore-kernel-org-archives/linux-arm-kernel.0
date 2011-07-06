From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 6 Jul 2011 15:11:12 -0700
Subject: [PATCHv11 0/8] Contiguous Memory Allocator
In-Reply-To: <201107051407.17249.arnd@arndb.de>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107051407.17249.arnd@arndb.de>
Message-ID: <20110706151112.5c619431.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Jul 2011 14:07:17 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 05 July 2011, Marek Szyprowski wrote:
> > This is yet another round of Contiguous Memory Allocator patches. I hope
> > that I've managed to resolve all the items discussed during the Memory
> > Management summit at Linaro Meeting in Budapest and pointed later on
> > mailing lists. The goal is to integrate it as tight as possible with
> > other kernel subsystems (like memory management and dma-mapping) and
> > finally merge to mainline.
> 
> You have certainly addressed all of my concerns, this looks really good now!
> 
> Andrew, can you add this to your -mm tree? What's your opinion on the
> current state, do you think this is ready for merging in 3.1 or would
> you want to have more reviews from core memory management people?
> 
> My reviews were mostly on the driver and platform API side, and I think
> we're fine there now, but I don't really understand the impacts this has
> in mm.

I could review it and put it in there on a preliminary basis for some
runtime testing.  But the question in my mind is how different will the
code be after the problems which rmk has identified have been fixed?

If "not very different" then that effort and testing will have been
worthwhile.

If "very different" or "unworkable" then it was all for naught.

So.  Do we have a feeling for the magnitude of the changes which will
be needed to fix these things up?
