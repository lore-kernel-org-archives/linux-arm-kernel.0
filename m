From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Sep 2013 09:14:11 +0800
Subject: pinctrl-mxs fails to parse function definitions from different
 .dts files
In-Reply-To: <20130903075050.GL24802@pengutronix.de>
References: <20130830092725.GG24802@pengutronix.de>
 <20130830115127.GP18729@S2101-09.ap.freescale.net>
 <20130903075050.GL24802@pengutronix.de>
Message-ID: <20130904011409.GG17900@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 09:50:50AM +0200, Uwe Kleine-K?nig wrote:
> Hello Shawn,
> 
> On Fri, Aug 30, 2013 at 07:51:29PM +0800, Shawn Guo wrote:
> > On Fri, Aug 30, 2013 at 11:27:25AM +0200, Uwe Kleine-K?nig wrote:
> > > while when I move the definition of i2c1 at 1 into imx28.dtsi after i2c1 at 0
> > > i2c1 probes just fine and also the pinmux-functions look right:
> > > 	
> > > 	# grep i2c1 /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-functions
> > > 	function: i2c1, groups = [ i2c1.0 i2c1.1 ]
> > > 
> > > This is not intended, is it?
> > 
> > Sorry.  I should have documented it somewhere, but this is intended.
> > The driver requires all the pin groups for given function be sorted
> > together in 'reg'.
> The groups for the function i2c1 are sorted, i.e. i2c1.0 comes before
> i2c1.1 :-) But honestly, it's very unconvenient to require this
> grouping. It makes it impossible to define i2c1.1 in myimx28machine.dts
> and so a nice advantage of being able to just include the vanilla
> imx28.dtsi in my external dts file goes away :-(
> 
> So I would prefer a patch that gets rid of this restriction instead of a
> patch that documents it.

Yeah, patch for the driver is welcomed.

Shawn
