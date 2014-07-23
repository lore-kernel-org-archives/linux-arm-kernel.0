From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 23 Jul 2014 11:11:53 +0000
Subject: [PATCH v5 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <20140723114834.411f6bb4@ipc1.ka-ro>
References: <1406103883-3572-1-git-send-email-yao.yuan@freescale.com>
 <1406103883-3572-2-git-send-email-yao.yuan@freescale.com>
 <20140723114834.411f6bb4@ipc1.ka-ro>
Message-ID: <b1778af62e7b42b39381fb2699b34eb1@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your review.

Lothar Wa?mann wrote:
> Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in dts node.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 377
[...]
> > +
> > +fail_rx:
> > +	dma_release_channel(dma->chan_rx);
> > +fail_tx:
> > +	dma_release_channel(dma->chan_tx);
> > +fail_al:
> > +	devm_kfree(dev, dma);
> >
> No need for this one (that's the whole point of using devm_kzalloc())!
> 

When DMA request failed, I2C will switch to PIO mode. So if the failed reason is just like DMA channel request failed. At this time the DMA should free by devm_kfree(). Is it?

[...]
Thanks.
Yuan Yao
