From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 15 Jul 2011 23:53:35 +0200
Subject: [PATCH 3/8] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
In-Reply-To: <20110715092717.GO23270@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241736.43576.arnd@arndb.de>
	<000601cc34c4$430f91f0$c92eb5d0$%szyprowski@samsung.com>
	<201106271519.43581.arnd@arndb.de>
	<20110707120918.GF7810@wantstofly.org>
	<20110707123825.GO8286@n2100.arm.linux.org.uk>
	<20110715001021.GM951@wantstofly.org>
	<20110715092717.GO23270@n2100.arm.linux.org.uk>
Message-ID: <20110715215335.GA23126@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 10:27:17AM +0100, Russell King - ARM Linux wrote:

> > > > > > > I suppose for the majority of the cases, the overhead of the indirect
> > > > > > > function call is near-zero, compared to the overhead of the cache
> > > > > > > management operation, so it would only make a difference for coherent
> > > > > > > systems without an IOMMU. Do we care about micro-optimizing those?
> > > > 
> > > > FWIW, when I was hacking on ARM access point routing performance some
> > > > time ago, turning the L1/L2 cache maintenance operations into inline
> > > > functions (inlined into the ethernet driver) gave me a significant and
> > > > measurable performance boost.
> > > 
> > > On what architecture?  Can you show what you did to gain that?
> > 
> > Patch is attached below.  It's an ugly product-specific hack, not
> > suitable for upstreaming in this form, etc etc, but IIRC it gave me
> > a ~5% improvement on packet routing.
> 
> Do you know how much is contributed from each change - L1, L2, moving
> dma_cache_maint() inline, removing the virt_addr_valid() etc?

Sorry, I'm not sure -- I never tested it to that granularity, and I
don't have access to the hardware anymore now.
