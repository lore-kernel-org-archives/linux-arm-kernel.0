From: B47053@freescale.com (Xiubo Li-B47053)
Date: Tue, 22 Oct 2013 02:20:29 +0000
Subject: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio
 Interface driver.
In-Reply-To: <526021B0.6050206@metafoo.de>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
 <526021B0.6050206@metafoo.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F82866F8C@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +static int fsl_sai_probe(struct platform_device *pdev) {
> [...]
> > +
> > +	sai->dma_params_rx.addr = res->start + SAI_RDR;
> > +	sai->dma_params_rx.maxburst = 6;
> > +	index = of_property_match_string(np, "dma-names", "rx");
> > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_rx.slave_id = dma_args.args[1];
> > +
> > +	sai->dma_params_tx.addr = res->start + SAI_TDR;
> > +	sai->dma_params_tx.maxburst = 6;
> > +	index = of_property_match_string(np, "dma-names", "tx");
> > +	ret = of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
> > +				&dma_args);
> > +	if (ret)
> > +		return ret;
> > +	sai->dma_params_tx.slave_id = dma_args.args[1];
> 
> The driver should not have to manually parse the dma devicetree
> properties, this is something that should be handled by the dma engine
> driver.
> 

Yes, the dma engine interface has already parsed the slave_id while
the dma customer requesting one dma channel.

Though this also could be a way to pass the slave_id to dma driver, but the 
dma driver uses the way while requesting dma channels.

So I'll drop this code later.
