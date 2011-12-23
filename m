From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 23 Dec 2011 23:05:40 +0530
Subject: [PATCH 04/12] dma: mxs-dma: convert to clk_prepare/clk_unprepare
In-Reply-To: <201112201445.12197.marek.vasut@gmail.com>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-5-git-send-email-shawn.guo@linaro.org>
 <201112201445.12197.marek.vasut@gmail.com>
Message-ID: <1324661740.1633.33.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-20 at 14:45 +0100, Marek Vasut wrote:
> > The patch converts mxs-dma driver to clk_prepare/clk_unprepare by
> > using helper functions clk_prepare_enable/clk_disable_unprepare.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  drivers/dma/mxs-dma.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index b4588bd..fc903c0 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -334,7 +334,7 @@ static int mxs_dma_alloc_chan_resources(struct dma_chan
> > *chan) goto err_irq;
> >  	}
> > 
> > -	ret = clk_enable(mxs_dma->clk);
> > +	ret = clk_prepare_enable(mxs_dma->clk);
> >  	if (ret)
> >  		goto err_clk;
> > 
> > @@ -372,7 +372,7 @@ static void mxs_dma_free_chan_resources(struct dma_chan
> > *chan) dma_free_coherent(mxs_dma->dma_device.dev, PAGE_SIZE,
> >  			mxs_chan->ccw, mxs_chan->ccw_phys);
> > 
> > -	clk_disable(mxs_dma->clk);
> > +	clk_disable_unprepare(mxs_dma->clk);
> >  }
> > 
> >  static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
> > @@ -578,7 +578,7 @@ static int __init mxs_dma_init(struct mxs_dma_engine
> > *mxs_dma) {
> >  	int ret;
> > 
> > -	ret = clk_enable(mxs_dma->clk);
> > +	ret = clk_prepare_enable(mxs_dma->clk);
> >  	if (ret)
> >  		goto err_out;
> > 
> > @@ -604,7 +604,7 @@ static int __init mxs_dma_init(struct mxs_dma_engine
> > *mxs_dma) writel(MXS_DMA_CHANNELS_MASK << MXS_DMA_CHANNELS,
> >  		mxs_dma->base + HW_APBHX_CTRL1 + MXS_SET_ADDR);
> > 
> > -	clk_disable(mxs_dma->clk);
> > +	clk_disable_unprepare(mxs_dma->clk);
> > 
> >  	return 0;
> 
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>


-- 
~Vinod
