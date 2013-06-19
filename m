From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jun 2013 09:52:02 +0100
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
In-Reply-To: <51C16DAF.1090205@samsung.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-4-git-send-email-will.deacon@arm.com>
 <51C16DAF.1090205@samsung.com>
Message-ID: <20130619085202.GC20351@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 09:37:03AM +0100, Marek Szyprowski wrote:
> Hello,

Hi Marek,

> On 6/10/2013 8:34 PM, Will Deacon wrote:
> > IOMMU mappings take a prot parameter, identifying the protection bits
> > to enforce on the newly created mapping (READ or WRITE). The ARM
> > dma-mapping framework currently just passes 0 as the prot argument,
> > resulting in faulting mappings.
> >
> > This patch infers the protection attributes based on the direction of
> > the DMA transfer.
> >
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks for fixing this issue. Could I take this patch to my dma-mapping tree
> with other dma-mapping changes I've collected recently or do you want my ack
> and push it via other tree?

Please, feel free to take it via the dma-mapping tree! That's probably the
best route for it and there's nothing that really depends on it anyway.

Cheers,

Will
