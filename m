From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:39:59 +0800
Subject: [PATCH 1/4] ARM: cfa10036: Add USB0 OTG port
In-Reply-To: <20130614063051.GE20513@S2101-09.ap.freescale.net>
References: <1371131025-12200-1-git-send-email-maxime.ripard@free-electrons.com>
 <1371131025-12200-2-git-send-email-maxime.ripard@free-electrons.com>
 <24013808.T2v7Fa5NMK@wuerfel>
 <20130614063051.GE20513@S2101-09.ap.freescale.net>
Message-ID: <20130614063956.GA13600@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 02:30:53PM +0800, Shawn Guo wrote:
> On Fri, Jun 14, 2013 at 12:06:51AM +0200, Arnd Bergmann wrote:
> > On Thursday 13 June 2013 15:43:42 Maxime Ripard wrote:
> > > +
> > > +       ahb at 80080000 {
> > > +               usb0: usb at 80080000 {
> > > +                       pinctrl-names = "default";
> > > +                       pinctrl-0 = <&usb0_otg_cfa10036>;
> > > +                       status = "okay";
> > >                 };
> > >         };
> > > 
> > 
> > The patches all look good, just one trivial comment about the fragment above:
> > 
> > There is already a "usb0" label in the imx28.dtsi file for the same
> > node. When you refer to the node from a board.dts file, either leave
> > out the redundant label, or use it to simplify the statements above
> > to the brief version:
> > 
> > 	&usb0 {
> > 		pinctrl-names = "default";
> > 		pinctrl-0 = <&usb0_otg_cfa10036>;
> > 		status = "okay";
> > 	};
> 
> Yeah, I moved all imx board level dts files to use this.  But I was told
> by Olof that the change does not gain too much and looks like a churn.
> That's why I haven't made the same move for mxs.  So I will remove the
> redundant label when applying this patch.

I would have the label stay there, because I found it's there like a
comment telling the controller instance.

Shawn
