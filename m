From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 13:38:25 +0100
Subject: [PATCH 3/8] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
In-Reply-To: <20110707120918.GF7810@wantstofly.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<201106241736.43576.arnd@arndb.de>
	<000601cc34c4$430f91f0$c92eb5d0$%szyprowski@samsung.com>
	<201106271519.43581.arnd@arndb.de>
	<20110707120918.GF7810@wantstofly.org>
Message-ID: <20110707123825.GO8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 02:09:18PM +0200, Lennert Buytenhek wrote:
> On Mon, Jun 27, 2011 at 03:19:43PM +0200, Arnd Bergmann wrote:
> 
> > > > I suppose for the majority of the cases, the overhead of the indirect
> > > > function call is near-zero, compared to the overhead of the cache
> > > > management operation, so it would only make a difference for coherent
> > > > systems without an IOMMU. Do we care about micro-optimizing those?
> 
> FWIW, when I was hacking on ARM access point routing performance some
> time ago, turning the L1/L2 cache maintenance operations into inline
> functions (inlined into the ethernet driver) gave me a significant and
> measurable performance boost.

On what architecture?  Can you show what you did to gain that?
