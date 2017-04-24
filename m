From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 24 Apr 2017 10:57:32 +0200
Subject: [PATCH v3 2/3] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <8ff65d6a5e5e4d388d3c5a384e4f5fd6@IL-EXCH01.marvell.com>
References: <20170424075407.19730-1-antoine.tenart@free-electrons.com>
 <20170424075407.19730-3-antoine.tenart@free-electrons.com>
 <8ff65d6a5e5e4d388d3c5a384e4f5fd6@IL-EXCH01.marvell.com>
Message-ID: <20170424085731.wbg53t5lcler4mng@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igal,

On Mon, Apr 24, 2017 at 08:50:32AM +0000, Igal Liberman wrote:
> [...]
> 
> > +	priv->clk = of_clk_get(dev->of_node, 0);
> > +	if (!IS_ERR(priv->clk)) {
> > +		ret = clk_prepare_enable(priv->clk);
> > +		if (ret) {
> > +			dev_err(dev, "unable to enable clk (%d)\n", ret);
> > +			return ret;
> > +		}
> > +	} else {
> > +		/* The clock isn't mandatory */
> > +		if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +	}
> > +
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> 
> The correct address width of the engine in Marvell SoCs is 40bit.

Oops. I'll update.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/4f99b7e5/attachment.sig>
