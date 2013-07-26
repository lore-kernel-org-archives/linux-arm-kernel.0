From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 26 Jul 2013 08:01:53 -0400
Subject: Location for a kind of GPIO bus driver
In-Reply-To: <20130725221615.GA30881@kroah.com>
References: <20130723151834.GJ9916@kw.sim.vm.gnt>
 <CACRpkdZWQQUCeHvgPPLmxL3O1sw55pc_KbzbnqTSFJx+0_QanQ@mail.gmail.com>
 <20130725221615.GA30881@kroah.com>
Message-ID: <20130726120153.GE29916@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:16:15PM -0700, Greg KH wrote:
> On Thu, Jul 25, 2013 at 11:46:42PM +0200, Linus Walleij wrote:
> > On Tue, Jul 23, 2013 at 5:18 PM, Simon Guinot <simon.guinot@sequanux.org> wrote:
> > 
> > > (...)  I am
> > > thinking about moving the GPIO extension bus support into a separate
> > > driver. The problem is that I can't find a proper location for a such
> > > driver. AFAIK, it doesn't fit with anything existing supported by Linux.
> > > Maybe I should consider drivers/bus ? Or even drivers/misc ?
> > 
> > This is a question to Greg, the device core maintainer.
> > AFAICT they go into drivers/base/foo-bus.c
> 
> No, specific bus code does not go in drivers/base/ it goes where the
> rest of the subsystem lives.

We were thinking drivers/bus since it is addressable and has multiple
devices hanging off of it (leds, power management).

However, since each device is essentially an external gpio, drivers/gpio
might be more appropriate.  It's not a gpio expander, more of an
enhanced gpio controller (led 1, brightness 7)

> > In this case I would first consider using MFD though,
> > please make a case for why this is not simply a multi
> > function device with a few cells (== platform devices).
> 
> I agree with this as well.

To quote Simon from a different response:
> I will definitively have a closer look at mfd. But as I understand,
> mfd is more oriented platform device and resources. Here, the device
> don't expose some memory regions but rather methods to configure a
> CPLD through GPIOs. I am not sure how it can work with the mfd
> framework.

thx,

Jason.
