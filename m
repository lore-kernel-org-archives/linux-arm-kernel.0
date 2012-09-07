From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 7 Sep 2012 19:26:12 +0200
Subject: [PATCH 8/9] ARM i.MX53: Add pwms to dtsi
In-Reply-To: <20120907132955.GH29340@avionic-0098.mockup.avionic-design.de>
References: <1346154504-5623-1-git-send-email-s.hauer@pengutronix.de>
 <1346154504-5623-9-git-send-email-s.hauer@pengutronix.de>
 <20120830223219.GF3613@r65073-Latitude-D630>
 <20120831130723.GS26594@pengutronix.de>
 <20120907132955.GH29340@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120907172612.GU26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 03:29:55PM +0200, Thierry Reding wrote:
> On Fri, Aug 31, 2012 at 03:07:23PM +0200, Sascha Hauer wrote:
> > On Fri, Aug 31, 2012 at 06:32:20AM +0800, Shawn Guo wrote:
> > > On Tue, Aug 28, 2012 at 01:48:23PM +0200, Sascha Hauer wrote:
> [...]
> > > >  arch/arm/boot/dts/imx53.dtsi        |   14 ++++++++++++++
> > > >  arch/arm/mach-imx/clk-imx51-imx53.c |    4 ++++
> > > >  2 files changed, 18 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> > > > index cd37165..7ec17e4 100644
> > > > --- a/arch/arm/boot/dts/imx53.dtsi
> > > > +++ b/arch/arm/boot/dts/imx53.dtsi
> > > > @@ -189,6 +189,20 @@
> > > >  				status = "disabled";
> > > >  			};
> > > >  
> > > > +			pwm1: pwm at 53fb4000 {
> > > > +				#pwm-cells = <3>;
> > > 
> > > pwm-cells should be 2?
> > 
> > Yes, right. We have a patch internally that allows us to pass a
> > 'inverted' flag to the pwm, hence I accidently have 3 here.
> 
> There are patches in for-next that add support for setting the PWM
> polarity, though there's currently no support for specifying it via a
> third cell in the specifier. Would you mind sharing the patches that add
> this?

Yes, will do. I was afraid this leads to some discussion, so I skipped
them so far.

The basic idea was that the third cell is for flags from which bit0 set
means 'inverted'. We currently implemented this i.MX specific, but if
you think this is acceptable it's propably a good idea to implement this
in a generic manner.

Sascha



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
