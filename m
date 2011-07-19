From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 19 Jul 2011 19:14:00 +0530
Subject: [PATCH 1/1] ARM: mxs-dma: reset after disable channel
In-Reply-To: <20110719040215.GF3838@S2100-06.ap.freescale.net>
References: <1311048596-19932-1-git-send-email-b29396@freescale.com>
	<20110719040215.GF3838@S2100-06.ap.freescale.net>
Message-ID: <438BB0150E931F4B9CE701519A4463010871D6C501@bgsmsx502.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 12: 6:02 AM +0100, Shawn Guo wrote:
> > We met some channels in abnormal state after disable.
> > Reset it to get a clean state.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Hi Vinod,
> 
> Please consider to merge it for v3.1.  The mxs audio driver needs the
> fix.
This looks good to me, in my queue now.
I am travelling back home tomorrow, so you should see this get pushed in my 
tree latest by weekend

~Vinod

> 
> Regards,
> Shawn
> 
> >  drivers/dma/mxs-dma.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index 88aad4f..5a24010 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -535,6 +535,7 @@ static int mxs_dma_control(struct dma_chan *chan, enum
> dma_ctrl_cmd cmd,
> >  	switch (cmd) {
> >  	case DMA_TERMINATE_ALL:
> >  		mxs_dma_disable_chan(mxs_chan);
> > +		mxs_dma_reset_chan(mxs_chan);
> >  		break;
> >  	case DMA_PAUSE:
> >  		mxs_dma_pause_chan(mxs_chan);
> > --
> > 1.7.0.4
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
