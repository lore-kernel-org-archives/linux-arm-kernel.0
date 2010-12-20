From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 20 Dec 2010 18:17:10 +0800
Subject: [PATCH v7 13/15] ARM: mxs: Add initial mx23evk support
In-Reply-To: <20101220094801.GU1940@pengutronix.de>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
	<1292679575-2635-9-git-send-email-shawn.guo@freescale.com>
	<20101220094801.GU1940@pengutronix.de>
Message-ID: <20101220101709.GA16497@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Dec 20, 2010 at 10:48:01AM +0100, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Sat, Dec 18, 2010 at 09:39:34PM +0800, Shawn Guo wrote:
> > Add initial mx23evk support with duart.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v7:
> >  - Define mx23evk pads using naked pad "OR" mA/vol/pull configurations
> > 
> > Changes for v3:
> >  - Remove inclusion of hardware.h
> >  - Add __initconst for mx23evk_pads[]
> > 
> > Changes for v2:
> >  - Remove boot_params
> > 
> >  arch/arm/mach-mxs/mach-mx23evk.c |   59 ++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 59 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
> > 
> > diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> > new file mode 100644
> > index 0000000..2aa77cc
> > --- /dev/null
> > +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> > @@ -0,0 +1,59 @@
> > [...]
> > +static const iomux_cfg_t mx23evk_pads[] __initconst = {
> > +	/* duart */
> > +	MX23_PAD_PWM0__DUART_RX |
> > +		MXS_PAD_4MA,
> > +	MX23_PAD_PWM1__DUART_TX |
> > +		MXS_PAD_4MA,
> > +};
> I would keep these on a single line.  YMMV, so for me no need for a v8.
> 
> I will test this series later on hardware, and if no show stoppers
> appear I'd say this is ready to be merged.  The (maybe) remaining issues
> can then be resolved in follow up patches.
> 
My intension was to keep the pad configuration on different line from
the naked pad.  I will keep this comment and that extra space one
in mind, and address them later.

Thanks for the review and test effort. 

-- 
Regards,
Shawn
