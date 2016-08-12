From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 12 Aug 2016 18:18:04 +0300
Subject: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
 configuration
In-Reply-To: <CAAFQd5BkpHrF=2=UXFA2mPKe0VQAD3J_XSNrZYHP0br5hw=Gsw@mail.gmail.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
 <CAAFQd5BkpHrF=2=UXFA2mPKe0VQAD3J_XSNrZYHP0br5hw=Gsw@mail.gmail.com>
Message-ID: <1651151.fes0RShRSW@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Friday 12 Aug 2016 16:31:47 Tomasz Figa wrote:
> On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > The of_configure_dma() function configures both the DMA masks and ops.
> > Moving DMA ops configuration to probe time would thus also delay
> > configuration of the DMA masks, which might not be safe. To avoid issues
> 
> Do we know any example cases when it might be unsafe? I think we kind
> of rely on the fact that DMA mapping (and so DMA masks as well) is not
> used before probing the device anyway, because we let the IOMMU
> attachment happen at probe time, which essentially makes any earlier
> attempts to use DMA mapping on such device incorrect.

I don't know of any such situation, but (if I remember correctly) when I 
discussed the IOMMU rework with Arnd Bergman and Will Deacon there was a 
concern that someone, somewhere was relying on the mask being set early.

I personally would like to drop this patch, but it might be difficult to 
ensure this wouldn't cause a regression. There should certainly be no DMA 
mapping created before IOMMU attachment, but the DMA mask could possibly be 
used somewhere else.

-- 
Regards,

Laurent Pinchart
