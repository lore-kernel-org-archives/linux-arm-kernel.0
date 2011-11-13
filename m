From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 13 Nov 2011 11:34:33 +0800
Subject: [PATCH 1/1] net: fec: convert to clk_prepare/clk_unprepare
In-Reply-To: <20111112124939.GJ5011@pengutronix.de>
References: <1320901304-13157-1-git-send-email-richard.zhao@linaro.org>
 <20111112124939.GJ5011@pengutronix.de>
Message-ID: <20111113033427.GC2425@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
On Sat, Nov 12, 2011 at 01:49:39PM +0100, Uwe Kleine-K?nig wrote:
> Hello Richard,
> 
> On Thu, Nov 10, 2011 at 01:01:44PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  drivers/net/ethernet/freescale/fec.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> > index 1124ce0..92e3585 100644
> > --- a/drivers/net/ethernet/freescale/fec.c
> > +++ b/drivers/net/ethernet/freescale/fec.c
> > @@ -1588,6 +1588,7 @@ fec_probe(struct platform_device *pdev)
> >  		ret = PTR_ERR(fep->clk);
> >  		goto failed_clk;
> >  	}
> > +	clk_prepare(fep->clk);
> What about error checking?
The goal of the patch is migrating to the new generic clock framework.
If the original driver has error check of clk_enable, I also added error check of
clk_prepare. And I've sent out new version patch, which use clk_prepare_enable.

Richard
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
