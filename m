From: marex@denx.de (Marek Vasut)
Date: Wed, 13 Jun 2012 23:57:34 +0200
Subject: [Patch v5 06/13] usb: chipidea: add imx platform driver
In-Reply-To: <20120613214622.GE30400@pengutronix.de>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-7-git-send-email-richard.zhao@freescale.com>
 <20120613214622.GE30400@pengutronix.de>
Message-ID: <201206132357.35099.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Wed, Jun 13, 2012 at 08:34:16PM +0800, Richard Zhao wrote:
> > This patch supports only the host-mode functionality so far.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Peter Chen <peter.chen@freescale.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> >  .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 +++
> >  drivers/usb/chipidea/Makefile                      |    3 +
> >  drivers/usb/chipidea/ci13xxx_imx.c                 |  189
> >  ++++++++++++++++++++ 3 files changed, 212 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> >  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c
> > 

[...]

> > +
> > +	ci13xxx_imx_platdata.phy = data->phy;
> > +
> > +	if (!pdev->dev.dma_mask) {
> > +		pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> > +				      sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> > +		if (!pdev->dev.dma_mask) {
> > +			ret = -ENOMEM;
> > +			dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
> > +			goto err;
> > +		}
> > +		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
> > +		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
> > +	}
> 
> Do you need this? I assume not.

Ain't this the dma mask crap without which the usb stuff won't work?

> Sascha

Best regards,
Marek Vasut
