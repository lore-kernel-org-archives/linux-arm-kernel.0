From: zpfeffer@codeaurora.org (Zach Pfeffer)
Date: Mon, 12 Jul 2010 22:52:43 -0700
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100710151111.GD10080@8bytes.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	<20100701193850.GB3594@basil.fritz.box>
	<4C2D0FF1.6010206@codeaurora.org>
	<20100701230056.GD3594@basil.fritz.box>
	<4C2D847E.5080602@codeaurora.org>
	<20100710151111.GD10080@8bytes.org>
Message-ID: <4C3BFF2B.40006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg Roedel wrote:
> On Thu, Jul 01, 2010 at 11:17:34PM -0700, Zach Pfeffer wrote:
>> Andi Kleen wrote:
> 
>>> Hmm? dma_map_* does not change any CPU mappings. It only sets up
>>> DMA mapping(s).
>> Sure, but I was saying that iommu_map() doesn't just set up the IOMMU
>> mappings, its sets up both the iommu and kernel buffer mappings.
> 
> What do you mean by kernel buffer mappings?

In-kernel mappings whose addresses can be dereferenced. 

> 
> 
>>> That assumes that all the IOMMUs on the system support the same page table
>>> format, right?
>> Actually no. Since the VCMM abstracts a page-table as a Virtual
>> Contiguous Region (VCM) a VCM can be associated with any device,
>> regardless of their individual page table format.
> 
> The IOMMU-API abstracts a page-table as a domain which can also be
> associated with any device (behind an iommu).

It does, but only by convention. The domain member is just a big
catchall void *. It would be more useful to factor out a VCM
abstraction, with associated ops. As it stands all IOMMU device driver
writters have to re-invent IOMMU virtual address management.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
