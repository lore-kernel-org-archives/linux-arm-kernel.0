From: marex@denx.de (Marek Vasut)
Date: Fri, 4 Apr 2014 13:49:07 +0200
Subject: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <533E8033.70904@ti.com>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
 <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>
 <533E8033.70904@ti.com>
Message-ID: <201404041349.07721.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 at 11:49:39 AM, sourav wrote:

[...]

> > +/* Functions for DMA support */
> > +static int i2c_imx_dma_request(struct imx_i2c_struct *i2c_imx,
> > +						dma_addr_t phy_addr)
> > +{
> > +	struct imx_i2c_dma *dma;
> > +	struct dma_slave_config dma_sconfig;
> > +	struct device *dev =&i2c_imx->adapter.dev;
> > +	int ret;
> > +
> > +	dma = devm_kzalloc(dev, sizeof(struct imx_i2c_dma), GFP_KERNEL);
> > +	if (!dma) {
> > +		dev_info(dev, "can't allocate DMA struct\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dma->chan_tx = dma_request_slave_channel(dev, "tx");
> > +	return 0;
> 
> ?? Looks to be some leftover?

Nice find.

btw. you might want to trim the email only to the relevant parts when replying 
so it's easier to find your commments in the entire body of text.
 
> > +	if (!dma->chan_tx) {
> > +		dev_info(dev, "DMA tx channel request failed\n");
> > +		ret = -ENODEV;
> > +		goto fail_al;
> > +	}

[...]

Best regards,
Marek Vasut
