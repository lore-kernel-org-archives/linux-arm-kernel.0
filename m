From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 16:05:20 +0200
Subject: [PATCH v2 14/53] dmaengine: dw: Split device_control
In-Reply-To: <1413458248.2396.15.camel@linux.intel.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413454672-27400-15-git-send-email-maxime.ripard@free-electrons.com>
 <1413458248.2396.15.camel@linux.intel.com>
Message-ID: <20141016140520.GL19438@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 02:17:28PM +0300, Andy Shevchenko wrote:
> On Thu, 2014-10-16 at 12:17 +0200, Maxime Ripard wrote:
> > Split the device_control callback of the DesignWare DMA driver to make use
> > of the newly introduced callbacks, that will eventually be used to retrieve
> > slave capabilities.
> 
> I will look at the main patches in the series later, but now I would
> like to comment this one.
> 
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/dma/dw/core.c | 92 +++++++++++++++++++++++++++------------------------
> >  1 file changed, 49 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> > index 1af731b83b3f..a3d3a51387c6 100644
> > --- a/drivers/dma/dw/core.c
> > +++ b/drivers/dma/dw/core.c
> > @@ -955,8 +955,7 @@ static inline void convert_burst(u32 *maxburst)
> >  		*maxburst = 0;
> >  }
> >  
> > -static int
> > -set_runtime_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
> > +static int dwc_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
> 
> 
> >  {
> >  	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> >  
> > @@ -977,29 +976,54 @@ set_runtime_config(struct dma_chan *chan, struct dma_slave_config *sconfig)
> >  	return 0;
> >  }
> >  
> > -static inline void dwc_chan_pause(struct dw_dma_chan *dwc)
> > +static inline void dwc_chan_resume(struct dw_dma_chan *dwc)
> 
> Could we keep the order of functions as previous?

Sure, I'll change that in the next version.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/370910c6/attachment-0001.sig>
