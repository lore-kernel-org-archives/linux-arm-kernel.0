From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Jan 2011 15:04:02 +0800
Subject: [PATCH v5] ARM: mx28: add the second fec device registration
In-Reply-To: <20110113144900.GT24920@pengutronix.de>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
	<1294747764-4499-1-git-send-email-shawn.guo@freescale.com>
	<20110113144900.GT24920@pengutronix.de>
Message-ID: <20110114070401.GC14491@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Jan 13, 2011 at 03:49:00PM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Jan 11, 2011 at 08:09:24PM +0800, Shawn Guo wrote:
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v5:
> >  - Do not use CONFIG_FEC2 which is a fec driver configration
> > 
> >  arch/arm/mach-mxs/mach-mx28evk.c |   26 +++++++++++++++++++++++---
> >  1 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> > index d162e95..8e2c597 100644
> > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > @@ -57,6 +57,19 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
> >  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> >  	MX28_PAD_ENET_CLK__CLKCTRL_ENET |
> >  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	/* fec1 */
> > +	MX28_PAD_ENET0_CRS__ENET1_RX_EN |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX28_PAD_ENET0_RXD2__ENET1_RXD0 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX28_PAD_ENET0_RXD3__ENET1_RXD1 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX28_PAD_ENET0_COL__ENET1_TX_EN |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX28_PAD_ENET0_TXD2__ENET1_TXD0 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> > +	MX28_PAD_ENET0_TXD3__ENET1_TXD1 |
> > +		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> >  	/* phy power line */
> >  	MX28_PAD_SSP1_DATA3__GPIO_2_15 |
> >  		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
> > @@ -106,8 +119,14 @@ static void __init mx28evk_fec_reset(void)
> >  	gpio_set_value(MX28EVK_FEC_PHY_RESET, 1);
> >  }
> >  
> > -static const struct fec_platform_data mx28_fec_pdata __initconst = {
> > -	.phy = PHY_INTERFACE_MODE_RMII,
> > +static struct fec_platform_data mx28_fec_pdata[] = {
> this can still be initdata, doesn't it?
> 
Sascha has merged the patch.  This one line change may not deserve
a separate patch, so I will take care of it when updating the file
with new version of ocotp patch.

-- 
Regards,
Shawn
