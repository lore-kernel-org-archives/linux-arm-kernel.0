From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 18 Nov 2013 16:30:17 +0200
Subject: [PATCHv7] dmaengine: Add support for BCM2835
In-Reply-To: <528A051A.7000703@koalo.de>
References: <5288E327.8050809@koalo.de> <1384768816.14845.186.camel@smile>
 <528A051A.7000703@koalo.de>
Message-ID: <1384785017.14845.214.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-11-18 at 13:16 +0100, Florian Meier wrote:
> Thank you! Few comments below.

See my answers below.

> >> +static enum dma_status bcm2835_dma_tx_status(struct dma_chan *chan,
> >> +	dma_cookie_t cookie, struct dma_tx_state *txstate)
> >> +{
> > 
> > []
> > 
> >> +	} else {
> >> +		txstate->residue = 0;
> > 
> > Useless assignment since dmaengine will do this for you in
> > dma_cookie_status.
> 
> I agree that it is useless, but I think otherwise it might be concealed
> that there is a third case left that uses a residue of 0. Do you think a
> comment is better? E.g.:
> 
> +	} else {
> +		/* residue = 0 per default */

I think like in many other DMA drivers either you have separate function
to get residue, which returns 0, or just not include this case.

> >> +static int bcm2835_dma_probe(struct platform_device *pdev)
> >> +{

> >> +	uint32_t chans_available;
> > 
> > Why uint32_t?
> 
> Because it is a bit mask of fixed length that directly comes from the
> firmware.

Like one already told you in your i2s patch, please, change that to
corresponding u* value, namely u32.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
