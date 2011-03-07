From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Mar 2011 16:11:43 +0800
Subject: [PATCH 2/4] ARM: mxs/mx28evk: add framebuffer deviceg
In-Reply-To: <20110307075445.GI29521@pengutronix.de>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
	<1299343222-30670-3-git-send-email-shawn.guo@freescale.com>
	<20110307075445.GI29521@pengutronix.de>
Message-ID: <20110307081142.GB12291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2011 at 08:54:45AM +0100, Sascha Hauer wrote:
> On Sun, Mar 06, 2011 at 12:40:20AM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Kconfig        |    1 +
> >  arch/arm/mach-mxs/clock-mx28.c   |    2 +
> >  arch/arm/mach-mxs/mach-mx28evk.c |   78 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
> > index 4f0b673..cffd860 100644
> > --- a/arch/arm/mach-mxs/Kconfig
> > +++ b/arch/arm/mach-mxs/Kconfig
> > @@ -33,6 +33,7 @@ config MACH_MX28EVK
> >  	select MXS_HAVE_AMBA_DUART
> >  	select MXS_HAVE_PLATFORM_AUART
> >  	select MXS_HAVE_PLATFORM_FEC
> > +	select MXS_HAVE_PLATFORM_MXSFB
> >  	select MXS_OCOTP
> >  	default y
> >  	help
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> > index 8277056..56bd164 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -750,6 +750,8 @@ int __init mx28_clocks_init(void)
> >  	clk_enable(&emi_clk);
> >  	clk_enable(&uart_clk);
> >  
> > +	clk_set_parent(&lcdif_clk, &ref_pix_clk);
> 
> While probably being the right thing to do this should not be in this
> patch.
> 
OK.  Will get a separate patch for this.

-- 
Regards,
Shawn
