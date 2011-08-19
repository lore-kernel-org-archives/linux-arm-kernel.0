From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Aug 2011 16:36:28 +0200
Subject: [PATCH 1/4 v4] drivers: create a pin control subsystem
In-Reply-To: <CACRpkdZhg_1WM37uqT1PNmpUjWS_groWJmNnR4SBjqJ6LFQQWQ@mail.gmail.com>
References: <1313747630-32258-1-git-send-email-linus.walleij@stericsson.com>
	<20110819104816.GA5030@pulham.picochip.com>
	<CACRpkdZhg_1WM37uqT1PNmpUjWS_groWJmNnR4SBjqJ6LFQQWQ@mail.gmail.com>
Message-ID: <201108191636.29161.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 August 2011, Linus Walleij wrote:
> On Fri, Aug 19, 2011 at 12:48 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> 
> >> +static struct class pinctrl_class = {
> >> +     .name = "pinctrl",
> >> +     .dev_release = pinctrl_dev_release,
> >> +     .dev_attrs = pinctrl_dev_attrs,
> >> +};
> >
> > Greg K-H has mentioned in the past that class is now deprecated for new
> > use and that a bus_type should be used instead.
> 
> Can you provide a reference with some detail?
> The pin control devices are usually aleady on a bus like the
> platform_bus or amba_bus or i2c_bus, then they register a
> class device in this case.
> 
> The kerneldoc documentation says
> "A bus is a channel between the processor and one or more devices."
> 
> This isn't the case here.
> 
> Anyhthing that help me understand this is appreciated, Arnd?

Taking Greg on Cc as well.

The main difference between a normal device and a class device is
that one is linked from /sys/bus/*/devices/* and the other is linked
from /sys/class/*/*. However, they both live in /sys/devices/.../*
as directories.

I always liked the separation between the two, although there are
a few cases where there is a grey area (e.g. /sys/bus/hid or
/sys/class/mmc_host) and the abstraction doesn't really fit.

IIRC Greg would prefer now to never have had the distinction
and wants to make all future uses use a bus_type.

	Arnd
