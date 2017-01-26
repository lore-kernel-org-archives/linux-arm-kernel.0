From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Jan 2017 17:57:45 +0000
Subject: [PATCH 4/5] arm64: dma-mapping: Only swizzle DMA ops for
 IOMMU_DOMAIN_DMA
In-Reply-To: <91cf771f-af55-f66f-ea24-9582fc83f03a@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-5-git-send-email-will.deacon@arm.com>
 <91cf771f-af55-f66f-ea24-9582fc83f03a@arm.com>
Message-ID: <20170126175745.GQ14167@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 07:00:25PM +0000, Robin Murphy wrote:
> On 19/01/17 18:19, Will Deacon wrote:
> > The arm64 DMA-mapping implementation sets the DMA ops to the IOMMU DMA
> > ops if we detect that an IOMMU is present for the master and the DMA
> > ranges are valid.
> > 
> > In the case when the IOMMU domain for the device is not of type
> > IOMMU_DOMAIN_DMA, then we have no business swizzling the ops, since
> > we're not in control of the underlying address space. This patch leaves
> > the DMA ops alone for masters attached to non-DMA IOMMU domains.
> 
> In fact, I don't think there would be any harm in taking this one
> through arm64 straight away. The DMA ops can't be expected to work
> successfully on any old domain, so it's a reasonable sanity check
> regardless.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Good point; I'll queue this one for 4.11 via arm64.

Will
