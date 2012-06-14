From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 14 Jun 2012 09:21:41 +0800
Subject: [Patch v5 06/13] usb: chipidea: add imx platform driver
In-Reply-To: <20120613220700.GI30400@pengutronix.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-7-git-send-email-richard.zhao@freescale.com>
 <20120613214622.GE30400@pengutronix.de>
 <201206132357.35099.marex@denx.de>
 <20120613220700.GI30400@pengutronix.de>
Message-ID: <20120614012141.GC29684@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 12:07:00AM +0200, Sascha Hauer wrote:
> On Wed, Jun 13, 2012 at 11:57:34PM +0200, Marek Vasut wrote:
> > Dear Sascha Hauer,
> > 
> > > > +
> > > > +	if (!pdev->dev.dma_mask) {
> > > > +		pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> > > > +				      sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> > > > +		if (!pdev->dev.dma_mask) {
> > > > +			ret = -ENOMEM;
> > > > +			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
> > > > +			goto err;
> > > > +		}
> > > > +		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> > > > +		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> > > > +	}
> > > 
> > > Do you need this? I assume not.
> > 
> > Ain't this the dma mask crap without which the usb stuff won't work?
> 
> Yes, the device needs this, but afaik the of platform code will set this
> for you. You only have to do this manually for devices which you
> allocate yourself.
Unfortunately, devices device tree populated don't set dma_mask.
It always hit if (!pdev->dev.dma_mask). I'm not the only one suffer it.

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
