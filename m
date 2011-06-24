From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Jun 2011 16:26:12 +0200
Subject: [PATCH/RFC 0/8] ARM: DMA-mapping framework redesign
In-Reply-To: <20110624091807.GC29299@8bytes.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<20110624091807.GC29299@8bytes.org>
Message-ID: <001801cc327a$ab4b75f0$01e261d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, June 24, 2011 11:18 AM Joerg Roedel wrote:

> On Mon, Jun 20, 2011 at 09:50:05AM +0200, Marek Szyprowski wrote:
> > This patch series is a continuation of my works on implementing generic
> > IOMMU support in DMA mapping framework for ARM architecture. Now I
> > focused on the DMA mapping framework itself. It turned out that adding
> > support for common dma_map_ops structure was not that hard as I initally
> > thought. After some modification most of the code fits really well to
> > the generic dma_map_ops methods.
> 
> I appreciate your progress on this generic dma_ops implementation. But
> for now it looks very ARM specific. Do you have plans to extend it to
> non-ARM iommu-api implementations too?

These works are just a first step to create an environment for real iommu 
& dma-mapping integration. It is much easier to work on IOMMU integration
once the dma-mapping operations can be easily changed for particular devices.
dma_map_ops gives such flexibility. It is also a de-facto standard interface
for other architectures so it was really desired to work on iommu
implementation on top of dma_map_ops.

Of course my patches will be ARM-centric, but I hope to isolate ARM-specific
from generic parts, which can be easily reused on other platforms. 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
