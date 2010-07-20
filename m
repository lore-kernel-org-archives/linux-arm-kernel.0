From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 20 Jul 2010 19:09:31 +0900
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100719082213.GA7421@n2100.arm.linux.org.uk>
References: <20100715080710T.fujita.tomonori@lab.ntt.co.jp>
	<20100715014148.GC2239@codeaurora.org>
	<20100719082213.GA7421@n2100.arm.linux.org.uk>
Message-ID: <20100720190904N.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jul 2010 09:22:13 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > If I want to share the buffer with another device I have to
> > make a copy of the entire thing then fix up the virtual mappings for
> > the other device I'm sharing with.
> 
> This is something the DMA API doesn't do - probably because there hasn't
> been a requirement for it.
> 
> One of the issues for drivers is that by separating the mapped scatterlist
> from the input buffer scatterlist, it creates something else for them to
> allocate, which causes an additional failure point - and as all users sit
> well with the current API, there's little reason to change especially
> given the number of drivers which would need to be updated.

Agreed. There was the discussion about separating 'dma_addr and dma_len' from
scatterlist struct but I don't think that it's worth doing so.


> I'm just proving that it's not as hard as you seem to be making out.

Agreed again.
