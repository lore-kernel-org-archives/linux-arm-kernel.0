From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Jul 2013 18:18:58 +0200
Subject: Location for a kind of GPIO bus driver
In-Reply-To: <20130726085623.GM9916@kw.sim.vm.gnt>
References: <20130723151834.GJ9916@kw.sim.vm.gnt>
 <20130725160324.GJ23879@titan.lakedaemon.net>
 <20130726085623.GM9916@kw.sim.vm.gnt>
Message-ID: <201307261818.59002.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 July 2013, Simon Guinot wrote:
> On Thu, Jul 25, 2013 at 12:03:24PM -0400, Jason Cooper wrote:
> > On Thu, Jul 25, 2013 at 05:49:32PM +0200, Simon Guinot wrote:

> > > > I would try drivers/gpio.  If there are complaints, it should be trivial
> > > > to move it in a new version of the series.
> > > 
> > > Why not, as long it is clear that the resulting driver will not provide
> > > a GPIO chip but rather functions as a library.
> > 
> > right, but the end result of what the library would do is expose a
> > series of LEDs and PM 'virtual gpios'.  So, even though it's not a gpio
> > expander per-se, it's still filling that role.  Or am I still missing
> > something?
> 
> The library could expose a function allowing to set the address and data
> registers: gpio_ext_set_value(int addr, int value).
> 
> Actually, it is how it works inside leds-netxbig. Simply this function
> would be also accessible by other drivers.

With that prototype it still sounds like a regular gpiochip driver would
fit that role well, since the function you describe is just like
gpio_set_value().

Maybe you can post the driver to let others understand what you are
trying to do if it's not just a gpio expander.

	Arnd
