From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 6 Aug 2014 02:26:07 +0000
Subject: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <53E0C498.6070608@gmail.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <53E0C498.6070608@gmail.com>
Message-ID: <30487e0abf4b4564af296d17f5cebf49@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review.

Varka Bhadram wrote:
> On 08/05/2014 03:26 PM, Yuan Yao wrote:
> 
> (...)
> > +fail_rx:
> > +	dma_release_channel(dma->chan_rx);
> > +fail_tx:
> > +	dma_release_channel(dma->chan_tx);
> > +fail_al:
> > +	devm_kfree(dev, dma);
> 
> no need to use devm_kfree() if we use devm_kzalloc()...
> 
We have discussed it before.
As Lothar Wa?mann said:
"The devm_kfree() is not in the failure path of the driver's probe() function, but in the function that tries to initialize the optional DMA support."
So It seems need to use devm_kfree().
Do you have some other opinions?

> > +	dev_info(dev, "can't use DMA\n");
> > +
> > +	return ret;
> > +}

(...)

> > +static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> > +					struct i2c_msg *msgs)
> 
> static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
> 			     struct i2c_msg *msgs)
> 
> run checkpatch.pl on this patch...

Sorry for my code style. I will match open parenthesis in this case.

I had run this script before, just one warning.


> --
> Regards,
> Varka Bhadram.
