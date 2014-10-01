From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Oct 2014 10:39:17 +0200
Subject: [PATCH 2/9] dmaengine: Make channel allocation callbacks optional
In-Reply-To: <20140928160757.GJ1638@intel.com>
References: <1411808085-27792-1-git-send-email-maxime.ripard@free-electrons.com>
 <1411808085-27792-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140928160757.GJ1638@intel.com>
Message-ID: <20141001083917.GG6884@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Sun, Sep 28, 2014 at 09:37:57PM +0530, Vinod Koul wrote:
> On Sat, Sep 27, 2014 at 10:54:38AM +0200, Maxime Ripard wrote:
> > Nowadays, some drivers don't have anything in there channel allocation
> > callbacks anymore.
> > 
> > Remove the BUG_ON if those callbacks aren't implemented, in order to allow
> > drivers to not implement them.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/dma/dmaengine.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > index d5d30ed863ce..cfcb181b1184 100644
> > --- a/drivers/dma/dmaengine.c
> > +++ b/drivers/dma/dmaengine.c
> > @@ -817,8 +817,6 @@ int dma_async_device_register(struct dma_device *device)
> >  	BUG_ON(dma_has_cap(DMA_INTERLEAVE, device->cap_mask) &&
> >  		!device->device_prep_interleaved_dma);
> >  
> > -	BUG_ON(!device->device_alloc_chan_resources);
> > -	BUG_ON(!device->device_free_chan_resources);
> Dont think we have drivers without free. IIRC cppi one might be only
> instance

It was more a matter of simmetry to be honest, I'm fine dropping it if
you want.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/74b512bf/attachment.sig>
