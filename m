From: agross@codeaurora.org (Andy Gross)
Date: Fri, 27 Jun 2014 13:58:30 -0500
Subject: [PATCH] spi: qup: Add DMA capabilities
In-Reply-To: <20140627162411.GO32514@n2100.arm.linux.org.uk>
References: <1403816781-31008-1-git-send-email-agross@codeaurora.org>
 <20140627105057.GF23300@sirena.org.uk>
 <20140627155422.GA13621@qualcomm.com>
 <20140627162411.GO32514@n2100.arm.linux.org.uk>
Message-ID: <20140627185830.GB13621@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 05:24:11PM +0100, Russell King - ARM Linux wrote:

<snip>

> > > It would be better to use the core DMA mapping code rather than open
> > > coding.  This code won't work for vmalloc()ed addresses, or physically
> > > non-contiguous addresses unless there's an IOMMU fixing things up.
> > 
> > Ah, ok.  So I just need a to setup the scatter gather page list and then do a
> > dma_map_sg.  I'll resend once I have this in place.
> 
> Note that DMA from vmalloc'd memory is non-coherent on some platforms,
> even if you use the DMA API.

Thankfully, that isn't the case on this platform.  As as the QUP controller is
only on Qualcomm chipsets, we don't have to worry about it being used on other
platforms.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
