From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jul 2015 13:46:57 +0100
Subject: [PATCH v4 0/4] arm64: IOMMU-backed DMA mapping
In-Reply-To: <55AD2E97.1040901@arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
 <20150720152637.GD10969@8bytes.org> <55AD2E97.1040901@arm.com>
Message-ID: <20150728124657.GK29209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg, Robin,

On Mon, Jul 20, 2015 at 06:23:35PM +0100, Robin Murphy wrote:
> On 20/07/15 16:26, Joerg Roedel wrote:
> > On Thu, Jul 16, 2015 at 07:40:11PM +0100, Robin Murphy wrote:
> >>   arch/arm64/Kconfig                   |   1 +
> >>   arch/arm64/include/asm/dma-mapping.h |  15 +-
> >>   arch/arm64/mm/dma-mapping.c          | 452 +++++++++++++++++++++++++++++
> >
> > What happened to the plan to merge this with the existing iommu-based
> > dma-api implementation for 32 bit ARM?
> 
> The issue currently is that there are a bunch of drivers using the 
> exported arm_iommu_* functions directly. From what I can tell, they seem 
> like they could probably all be converted to using default domains 
> and/or the new domain type abstractions via the core IOMMU API, which 
> would then allow killing off dma_iommu_mapping and rewriting the 
> arch/arm implementation to use the new shared code. I don't currently 
> have any 32-bit platform to test with, so I'm a little dubious of taking 
> that all on myself right now.
> 
> In the meantime on arm64, DMA mapping ops are needed for SMMUv3 platform 
> device support, the Mediatek M4U patches and my own SMMUv2 work, so it 
> would be very useful to get the arm64 and common code in as a first 
> step, then look at cleaning up arch/arm for 4.4 without dangling 
> dependencies.

What's the plan with this? Do we need to port 32-bit ARM before it's a
candidate for merging, or can we push ahead with getting this up and
running for arm64 (which currently can't use an IOMMU for DMA)?

Will
