From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Feb 2013 15:24:28 +0800
Subject: [PATCH 03/12] dma: mxs-dma: move to generic device tree binding
In-Reply-To: <201302272050.14338.arnd@arndb.de>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
 <1361978748-25281-4-git-send-email-shawn.guo@linaro.org>
 <201302272050.14338.arnd@arndb.de>
Message-ID: <20130228072426.GE26106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 08:50:14PM +0000, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Shawn Guo wrote:
> > @@ -139,6 +140,9 @@ struct mxs_dma_engine {
> >  	struct dma_device		dma_device;
> >  	struct device_dma_parameters	dma_parms;
> >  	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
> > +	struct platform_device		*pdev;
> > +	struct of_dma_filter_info	filter_info;
> > +	unsigned int			nr_channels;
> >  };
> 
> I don't think using of_dma_filter_info makes sense when we are not
> using the generic xlate function:
...
> > +static bool mxs_dma_filter_fn(struct dma_chan *chan, void *fn_param)
> 
> You already know the value of info->filter_fn, it's always &mxs_dma_filter_fn,
> so if you reorder these two functions, you can pass it directly into
> dma_request_channel.

Yeah, you're right.  I was blindly following the generic xlate example.
Thanks for spotting this.  Will fix it.

Shawn
