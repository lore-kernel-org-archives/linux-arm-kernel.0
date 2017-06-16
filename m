From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 10:37:00 +0200
Subject: [PATCH 06/44] iommu/dma: don't rely on DMA_ERROR_CODE
In-Reply-To: <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-7-hch@lst.de>
 <0bfb0841-f054-78de-628d-a0955336bcb4@arm.com>
Message-ID: <20170616083700.GA10582@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 02:59:07PM +0100, Robin Murphy wrote:
> Hi Christoph,
> 
> On 08/06/17 14:25, Christoph Hellwig wrote:
> > DMA_ERROR_CODE is not a public API and will go away soon.  dma dma-iommu
> > driver already implements a proper ->mapping_error method, so it's only
> > using the value internally.  Add a new local define using the value
> > that arm64 which is the only current user of dma-iommu.
> 
> It would be fine to just use 0, since dma-iommu already makes sure that
> that will never be allocated for a valid DMA address.

I'll change it to 0.

> Otherwise, looks good!

Can you give me a formal ACK or Reviewed-by: ?
