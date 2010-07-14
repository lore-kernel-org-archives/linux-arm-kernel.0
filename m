From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Wed, 14 Jul 2010 10:59:38 +0900
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <20100713121420.GB4263@codeaurora.org>
References: <4C3C0032.5020702@codeaurora.org>
	<20100713150311B.fujita.tomonori@lab.ntt.co.jp>
	<20100713121420.GB4263@codeaurora.org>
Message-ID: <20100714104353B.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010 05:14:21 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> > You mean that you want to specify this alignment attribute every time
> > you create an IOMMU mapping? Then you can set segment_boundary_mask
> > every time you create an IOMMU mapping. It's odd but it should work.
> 
> Kinda. I want to forget about IOMMUs, devices and CPUs. I just want to
> create a mapping that has the alignment I specify, regardless of the
> mapper. The mapping is created on a VCM and the VCM is associated with
> a mapper: a CPU, an IOMMU'd device or a direct mapped device.

Sounds like you can do the above with the combination of the current
APIs, create a virtual address and then an I/O address.

The above can't be a reason to add a new infrastructure includes more
than 3,000 lines.
 

> > Another possible solution is extending struct dma_attrs. We could add
> > the alignment attribute to it.
> 
> That may be useful, but in the current DMA-API may be seen as
> redundant info.

If there is real requirement, we can extend the DMA-API.
