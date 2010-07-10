From: joro@8bytes.org (Joerg Roedel)
Date: Sat, 10 Jul 2010 17:11:11 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C2D847E.5080602@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	<20100701193850.GB3594@basil.fritz.box>
	<4C2D0FF1.6010206@codeaurora.org>
	<20100701230056.GD3594@basil.fritz.box>
	<4C2D847E.5080602@codeaurora.org>
Message-ID: <20100710151111.GD10080@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 11:17:34PM -0700, Zach Pfeffer wrote:
> Andi Kleen wrote:

> > Hmm? dma_map_* does not change any CPU mappings. It only sets up
> > DMA mapping(s).
> 
> Sure, but I was saying that iommu_map() doesn't just set up the IOMMU
> mappings, its sets up both the iommu and kernel buffer mappings.

What do you mean by kernel buffer mappings?


> > That assumes that all the IOMMUs on the system support the same page table
> > format, right?
> 
> Actually no. Since the VCMM abstracts a page-table as a Virtual
> Contiguous Region (VCM) a VCM can be associated with any device,
> regardless of their individual page table format.

The IOMMU-API abstracts a page-table as a domain which can also be
associated with any device (behind an iommu).

	Joerg
