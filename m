From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 13:40:56 +0800
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <201206082032.22940.marex@denx.de>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <20120606081726.GG2667@S2101-09.ap.freescale.net>
 <201206082032.22940.marex@denx.de>
Message-ID: <20120611054053.GA2552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 08:32:22PM +0200, Marek Vasut wrote:
> Ok, I see ... FSL patches get merged with priority?
> 
If I'm not mistaken, Huang's patches hit list earlier than yours.
That's the only reason I applied his patches with priority.  Anything
wrong with this approach?

> I see ... so if I need to configure two set of pins, how do I do that? Or it's 
> not possible with DT too?
> 
It's possible.  You already did that with ethernet pins, one set of
mac function pins and another phy reset gpio, didn't you?

> > > +
> > > +				auart0_pins_m28: auart0 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <0x3000 0x3010>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > > +
> > > +				auart3_pins_m28: auart3 at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <0x30c0 0x30d0
> > > +							  0x30e0 0x30f0>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > 
> > Should be defined in imx28.dtsi, so that other boards can refer to
> > them too.
> 
> It's specific to our platform, why would it?
> 
Which pins can be mux-ed on auart function is never specific to your
platform, it's determined by SoC design.  Different platforms may need
different pad configuration though.  That's can be done by defining
config node in <board>.dts.

> > > +
> > > +				mac_pin_reset: mac at 0 {
> > > +					reg = <0>;
> > > +					fsl,pinmux-ids = <0x30b3>;
> > > +					fsl,drive-strength = <2>;
> > > +					fsl,voltage = <1>;
> > > +					fsl,pull-up = <0>;
> > > +				};
> > 
> > gpio, let's wait for pinctrl core support.
> 
> Hm, how long do you intend to block all possible platforms from mainline other 
> than FSL EVK ones?

Would you mind giving an example that I block your platform support
for some reason while give it pass on FSL EVK?

> I consider having stuff in mainline much better, as it helps 
> testing it, but it seems you don't share this opinion.
> 
I do share this opinion.  I was thinking that the gpio range support
in pinctrl is close to get it.  Now, it seems not the case and more
importantly I just found one problem with that, the pad configuration
for gpio is not covered by gpio range support.  So we may not be able
to use that support anyway, so go ahead with your approach.

-- 
Regards,
Shawn
