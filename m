From: agross@codeaurora.org (Andy Gross)
Date: Fri, 27 Jun 2014 10:54:22 -0500
Subject: [PATCH] spi: qup: Add DMA capabilities
In-Reply-To: <20140627105057.GF23300@sirena.org.uk>
References: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
 <20140627105057.GF23300@sirena.org.uk>
Message-ID: <20140627155422.GA13621@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 11:50:57AM +0100, Mark Brown wrote:
> On Thu, Jun 26, 2014 at 04:06:21PM -0500, Andy Gross wrote:
> 
> > +	if (xfer->rx_buf) {
> > +		rx_dma = dma_map_single(controller->dev, xfer->rx_buf,
> > +			xfer->len, DMA_FROM_DEVICE);
> 
> It would be better to use the core DMA mapping code rather than open
> coding.  This code won't work for vmalloc()ed addresses, or physically
> non-contiguous addresses unless there's an IOMMU fixing things up.

Ah, ok.  So I just need a to setup the scatter gather page list and then do a
dma_map_sg.  I'll resend once I have this in place.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
