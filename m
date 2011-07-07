From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 7 Jul 2011 14:09:18 +0200
Subject: [PATCH 3/8] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
In-Reply-To: <201106271519.43581.arnd@arndb.de>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241736.43576.arnd@arndb.de>
	<000601cc34c4$430f91f0$c92eb5d0$%szyprowski@samsung.com>
	<201106271519.43581.arnd@arndb.de>
Message-ID: <20110707120918.GF7810@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 03:19:43PM +0200, Arnd Bergmann wrote:

> > > I suppose for the majority of the cases, the overhead of the indirect
> > > function call is near-zero, compared to the overhead of the cache
> > > management operation, so it would only make a difference for coherent
> > > systems without an IOMMU. Do we care about micro-optimizing those?

FWIW, when I was hacking on ARM access point routing performance some
time ago, turning the L1/L2 cache maintenance operations into inline
functions (inlined into the ethernet driver) gave me a significant and
measurable performance boost.

Such things can remain product-specific hacks, though.


> > Even in coherent case, the overhead caused by additional function call
> > should have really negligible impact on drivers performance.
> 
> What about object code size? I guess since ixp23xx is the only platform
> that announces itself as coherent, we probably don't need to worry about
> it too much either. Lennert?

I don't think so.  ixp23xx isn't a very popular platform anymore either,
having been discontinued some time ago.


thanks,
Lennert
