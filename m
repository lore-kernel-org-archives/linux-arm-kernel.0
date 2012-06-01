From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Jun 2012 06:50:22 -0400
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <1338517049.24549.9.camel@hactar>
References: <1338401183.22894.11.camel@hactar>
 <20120531005109.GW24238@titan.lakedaemon.net>
 <1338431047.1822.11.camel@hactar>
 <20120531030931.GX24238@titan.lakedaemon.net>
 <1338438730.4173.8.camel@hactar>
 <20120531133158.GY24238@titan.lakedaemon.net>
 <1338517049.24549.9.camel@hactar>
Message-ID: <20120601105022.GA24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 11:17:29PM -0300, Thiago Jung Bauermann wrote:
> On Thu, 2012-05-31 at 09:31 -0400, Jason Cooper wrote:
> > On Thu, May 31, 2012 at 01:32:10AM -0300, Thiago Jung Bauermann wrote:
> > You may want to look at the kwboot patches to u-boot [1].  It's a
> > utility that allows you to load u-boot with only the serial port
> > connected.  Many have reported success with it.  This would then allow
> > you to add DT boot support (and fix a bunch of bugs in the stock
> > u-boot ;-) ).
> 
> Thanks, I'll have a look. The impression I get though is that these
> things are still too recent to have settled, so if I flash an u-boot
> now, maybe I'll have to flash it again later. Might as well wait a bit
> and do it just once.

The dreamplug code in u-boot is done.  As long as you make sure
CONFIG_OF_LIBFDT if defined in include/configs/dreamplug.h, you'll only
need to do it once.  Latest git has this, so 2012.06 will have it.

As the dtb grows, you just tftp it to the dreamplug, and write it in
like a kernel update (or, optionally, you can update it via Linux
userspace via the exposed spi flash block devices).

And honestly, 2012.04.01 is fine, with the exception of adding
CONFIG_OF_LIBFDT.  Which really should be handled by a Kconfig-type
infrastructure.  I can't tell you how tired I am of seeing "U-boot
YYYY.MM-dirty" when it boots just because I want an extra feature.

> > > Is there a risk of damaging the board if it is accidentally booted with
> > > the wrong DTB or without one?
> > 
> > There's always a risk at this level.  The statement in the Kconfig is
> > true.  However, If you aren't willing to upgrade u-boot, you aren't
> > leaving too many other options.  Knives are dangerous, too.  People
> > still use them every day.  Just be careful.
> 
> If you have an accident with a knife at home, the worst that will happen
> is that you'll have to use a band-aid for a few days. On the other hand,
> when I go to the butcher I see him wearing a metal chain gauntlet when
> cutting meat. If he has an accident with *that* knife, he'll be in
> trouble. In both cases you are dealing with knives and in both cases you
> have to be careful... My question was, what kind of knife I'm dealing
> with here? ;-)
> 
> I bought this Dreamplug for personal use and if it breaks, I won't buy
> another one. That's a different level of risk tolerance than someone
> who's working professionally on an ARM board, where breaking it is
> just cost of doing business. 

This isn't my day job either, but point taken.  Having and using the
jtag really increases one's comfort level in this area.  They aren't
that expensive.  There's the guruplug one [1], the flyswatter2 [2], and
I believe the busblaster [3] has firmware that will make it work as a
jtag as well.  Each of those is well under US$100.  And they aren't
restricted to the *plug series.

And, of course, openocd [4] is free and opensource.

hth,

Jason.

[1] http://www.globalscaletechnologies.com/p-28-jtag.aspx
[2] http://www.tincantools.com/product.php?productid=16153&cat=0&page=1
[3]
http://www.seeedstudio.com/depot/bus-blaster-v2-jtag-debugger-p-807.html
[4] http://openocd.sourceforge.net/
