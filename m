From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 09 Apr 2013 17:19:51 +0200
Subject: [PATCH v2 2/4] imx-drm: parallel-display: Make IPU KMS parse
 display-timings
In-Reply-To: <1365519948.4023.49.camel@pizza.hi.pengutronix.de>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-2-git-send-email-rogerio.pimentel@freescale.com>
 <1365519948.4023.49.camel@pizza.hi.pengutronix.de>
Message-ID: <1365520791.4023.55.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 09.04.2013, 17:05 +0200 schrieb Philipp Zabel:
> Am Dienstag, den 09.04.2013, 11:07 -0300 schrieb Rogerio Pimentel:
> > This patch adds support for parsing of the DT display-timings prop
> > to IPU KMS driver.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
> > ---
> > Changes since v1:
> > Moved the function of_get_drm_display_mode from 
> > imx_pd_connector_get_modes function to probe function
> >  drivers/staging/imx-drm/parallel-display.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
> > index 49c90c3..adc011d 100644
> > --- a/drivers/staging/imx-drm/parallel-display.c
> > +++ b/drivers/staging/imx-drm/parallel-display.c
> > @@ -232,6 +232,8 @@ static int imx_pd_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, imxpd);
> >  
> > +	of_get_drm_display_mode(np, &imxpd->mode, 0);
> > +
> 
> I'd prefer something like
> 
> 	ret = of_get_drm_display_mode(np, &imxpd->mode, 0);

Also, DRM_IMX_PARALLEL_DISPLAY needs to select OF_VIDEOMODE in 
drivers/staging/imx-drm/Kconfig to use of_get_drm_display_mode.

> 	if (!ret)
> 		imxpd->mode_valid = 1;
> 
> here.

regards
Philipp
