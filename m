From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 5 Mar 2013 17:42:46 +0100
Subject: [PATCH v4 1/2] dma: imx-dma: Add oftree support
In-Reply-To: <201303022212.38322.arnd@arndb.de>
References: <1362243213-29399-1-git-send-email-mpa@pengutronix.de>
 <1362243213-29399-2-git-send-email-mpa@pengutronix.de>
 <201303022212.38322.arnd@arndb.de>
Message-ID: <20130305164246.GB11656@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 02, 2013 at 10:12:38PM +0000, Arnd Bergmann wrote:
> On Saturday 02 March 2013, Markus Pargmann wrote:
> > Adding devicetree support for imx-dma driver. Use driver name for
> > function 'imx_dma_is_general_purpose' because the devicename for
> > devicetree initialized devices is different.
>  
> Just one small comment this time:
> 
> > @@ -734,8 +757,9 @@ static int imxdma_alloc_chan_resources(struct dma_chan *chan)
> >  	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
> >  	struct imx_dma_data *data = chan->private;
> >  
> > -	if (data != NULL)
> > +	if (data != NULL) {
> >  		imxdmac->dma_request = data->dma_request;
> > +	}
> >  
> >  	while (imxdmac->descs_allocated < IMXDMA_MAX_CHAN_DESCRIPTORS) {
> >  		struct imxdma_desc *desc;
> 
> I assume that this change wasn't meant to be in here.

Yes exactly. I actually saw that before sending and removed it, but
I obviously forgot to create the patch again ;).

Regards

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
