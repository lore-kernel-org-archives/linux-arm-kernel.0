From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 May 2011 11:34:17 +0800
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <20110519190841.GJ5109@ponder.secretlab.ca>
References: <20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
	<BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
	<20110504061905.GD27860@atomide.com>
	<BANLkTikiUB4=y0sZtUSedcPveMsBSLJgpQ@mail.gmail.com>
	<87mxiscl0w.fsf@ti.com> <20110519190841.GJ5109@ponder.secretlab.ca>
Message-ID: <20110520033416.GC27251@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 01:08:41PM -0600, Grant Likely wrote:
> On Thu, May 12, 2011 at 11:42:39AM +0200, Kevin Hilman wrote:
> > Linus Walleij <linus.walleij@linaro.org> writes:
> > 
> > [...]
> > 
> > > For TI I guess this currently means you simply cannot work
> > > on GPIO stuff until you know where to go with it unless you
> > > allow the OMAP GPIO authors to keep churning in arch/arm/*...
> > >
> > > That's unless Grant is OK with us moving stuff into
> > > drivers/gpio that does *not* use gpiolib and utilize singletons to
> > > get at the gpio_chip addresses (i.e. current form) and keep it
> > > churning like that until it can be refactored.
> > 
> > The churn will happen one way or another.  the only question is whether
> > it happens in drivers/gpio or arch/arm/*.
> > 
> > Grant, what's your feeling here.  How much ugliness are you willing to
> > tolerate in a bulk move to drivers/gpio.  At least for OMAP, I am
> > personally be working on the cleanup/move so I can work either way,
> > although I know Tony has an obvious preference for moving it to
> > drivers/gpio. :)
> > 
> > The OMAP driver is already using gpiolib.  The main ugliness in the OMAP
> > driver is the awful ifdeffery used to handle the differences across the
> > various SoCs in the OMAP family.  I've already got most of that cleaned
> > up[1].
> 
> Go ahead and move stuff.  I may as well have the junk in my tree.
> 
> I request however to have at least some semblance of organization.
> I'd like each driver filename to be named something like gpio_*.c, and

Just confirm that you really mean gpio_*.c than *_gpio.c, because I
see there have been several *_gpio.c but none gpio_*.c under
drivers/gpio.

> put things into the Makefile/Kconfig in alphabetical order as much as
> possible.
> 

-- 
Regards,
Shawn
