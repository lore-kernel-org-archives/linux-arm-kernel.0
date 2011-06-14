From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 14 Jun 2011 15:55:20 +0200
Subject: [PATCH v2 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
	write_protect support for mx5
In-Reply-To: <20110614130610.GH30295@S2100-06.ap.freescale.net>
References: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
	<1308034059-4014-1-git-send-email-shawn.guo@linaro.org>
	<20110614095129.GD5043@pengutronix.de>
	<20110614130610.GH30295@S2100-06.ap.freescale.net>
Message-ID: <20110614135520.GH5043@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> important issue needs to be fixed in the release.  Please find some
> time to do a full review, if possible.  We need your ack to know if
> the patch stands :)  

Huh, my ack is needed for the linaro-kernel? :) Isn't it possible to
replace a V1 patch with a V2 patch in later kernels?

> > > diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
> > > index 86003f4..fced348 100644
> > > --- a/arch/arm/plat-mxc/include/mach/esdhc.h
> > > +++ b/arch/arm/plat-mxc/include/mach/esdhc.h
> > > @@ -10,17 +10,32 @@
> > >  #ifndef __ASM_ARCH_IMX_ESDHC_H
> > >  #define __ASM_ARCH_IMX_ESDHC_H
> > >  
> > > +enum wp_types {
> > > +	ESDHC_WP_NONE,		/* no WP, neither signal nor gpio */
> > > +	ESDHC_WP_SIGNAL,	/* mmc internal WP signal */
> > 
> > I think SIGNAL is not descriptive enough. Maybe
> > 
> We have the document telling it's internal.
> 
> > ESDHC_WP_INTERNAL		/* WP routed directly to mmc controller */
> > 
> I thought about that.  If we use ESDHC_WP_INTERNAL, ESDHC_WP_GPIO
> should probably be the ESDHC_WP_EXTERNAL for the couple naming.  But
> I like ESDHC_WP_GPIO over ESDHC_WP_EXTERNAL, so chose the couple
> naming of ESDHC_WP_GPIO vs. ESDHC_WP_SIGNAL.

ESDHC_WP_CONTROLLER? Or ESDHC_WP_CORE?

> > ? It should be mentioned on which SoCs this is not available?
> > 
> From SoC/controller POV, it's all available.  It's really a board
> design choice to connect card CD/WP to the pads or not, which the
> controller CD/WP signal/function is available on.

For mx25/35, I tried to find muxer settings but couldn't find them. It
seemed to me, GPIO is the only option there (I think I even asked
Richard). Can you route them on mx25/35, too?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110614/08c5168d/attachment.sig>
