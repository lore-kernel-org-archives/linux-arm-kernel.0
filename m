From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 14:15:51 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428102720.GA13402@8bytes.org>
References: <201104212129.17013.arnd@arndb.de>
	<20110428102720.GA13402@8bytes.org>
Message-ID: <201104281415.51183.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Joerg Roedel wrote:
> On Thu, Apr 21, 2011 at 09:29:16PM +0200, Arnd Bergmann wrote:
> > 4. Implement an architecture independent version of dma_map_ops
> >    based on the iommu.h API. As Joerg mentioned, this has been
> >    missing for some time, and it would be better to do it once
> >    than for each IOMMU separately. This is probably a lot of work.
> 
> Yes, thats missing for a long time. It will also need some changes to
> the IOMMU-API but that should be doable. The best would be to extend the
> IOMMU-API so that it also supports GART-like IOMMUs. This way every
> dma_ops implementation on all the architectures providing such an IOMMU
> could be covered with the architecture independent dma_ops
> implementation. This would only leave the low-level hardware access in
> the IOMMU drivers.
> I think this also requires to change the current semantics of the
> existing IOMMU-API implementations. I will prepare a write-up of my
> ideas for discussion.

Ok, thanks!

Please include Marek in this, he said he has already started with an
implementation. Any insight from you will certainly help.

	Arnd
