From: yao.yuan@freescale.com (Yao Yuan)
Date: Fri, 4 Apr 2014 15:45:15 +0000
Subject: [PATCH v4 1/2] i2c: add DMA support for freescale i2c driver
In-Reply-To: <201404041628.55471.marex@denx.de>
References: <1396579272-19542-1-git-send-email-yao.yuan@freescale.com>
 <1396579272-19542-2-git-send-email-yao.yuan@freescale.com>,
 <201404041628.55471.marex@denx.de>
Message-ID: <aab78696ac364d9c832993c08915bad3@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 at 22:29:32 PM, Marek Vasut wrote:
> On Friday, April 04, 2014 at 04:41:11 AM, Yuan Yao wrote:
> > Add dma support for i2c. This function depend on DMA driver.
> > You can turn on it by write both the dmas and dma-name properties in dts
> > node.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@freescale.com>

[...]

> Since you will be fixing that superfluous return 0; (I actually wonder, did you
> really test the driver at all before submitting it?) ...

I'm sorry for the leftover. It's a serious bug. The support by DMA will be disabled always.
Thanks for your consideration. But subjective assume may not suitable. Testing is a essential link . 
But the bug can't be found by normal test . The testing may not be  imperfect, it's my 
serious fault, but please don't doubt my work attitude.
The ugly is my work or even the ability but not the attitude, I think.

At last, Thank you for giving me a lot of help, it's very important for me.

> > +static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
> > +                                     struct i2c_msg *msgs)
> > +{
> > +     struct imx_i2c_dma *dma = i2c_imx->dma;
> > +     struct dma_async_tx_descriptor *txdesc;
> > +     struct device *dev = &i2c_imx->adapter.dev;
> +
> +     dma->dma_buf = dma_map_single(dma->chan_using->device->dev, msgs->buf,
[...]

>  Reviewed-by: Marek Vasut <marex@denx.de>
