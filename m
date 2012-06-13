From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Jun 2012 00:07:00 +0200
Subject: [Patch v5 06/13] usb: chipidea: add imx platform driver
In-Reply-To: <201206132357.35099.marex@denx.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-7-git-send-email-richard.zhao@freescale.com>
 <20120613214622.GE30400@pengutronix.de>
 <201206132357.35099.marex@denx.de>
Message-ID: <20120613220700.GI30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 11:57:34PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > > +
> > > +	if (!pdev->dev.dma_mask) {
> > > +		pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> > > +				      sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> > > +		if (!pdev->dev.dma_mask) {
> > > +			ret = -ENOMEM;
> > > +			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
> > > +			goto err;
> > > +		}
> > > +		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> > > +		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> > > +	}
> > 
> > Do you need this? I assume not.
> 
> Ain't this the dma mask crap without which the usb stuff won't work?

Yes, the device needs this, but afaik the of platform code will set this
for you. You only have to do this manually for devices which you
allocate yourself.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
