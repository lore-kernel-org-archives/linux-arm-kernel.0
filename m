From: thiago.bauermann@gmail.com (Thiago Jung Bauermann)
Date: Thu, 31 May 2012 23:17:29 -0300
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <20120531133158.GY24238@titan.lakedaemon.net>
References: <1338401183.22894.11.camel@hactar>
 <20120531005109.GW24238@titan.lakedaemon.net>
 <1338431047.1822.11.camel@hactar>
 <20120531030931.GX24238@titan.lakedaemon.net>
 <1338438730.4173.8.camel@hactar>
 <20120531133158.GY24238@titan.lakedaemon.net>
Message-ID: <1338517049.24549.9.camel@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-31 at 09:31 -0400, Jason Cooper wrote:
> On Thu, May 31, 2012 at 01:32:10AM -0300, Thiago Jung Bauermann wrote:
> You may want to look at the kwboot patches to u-boot [1].  It's a
> utility that allows you to load u-boot with only the serial port
> connected.  Many have reported success with it.  This would then allow
> you to add DT boot support (and fix a bunch of bugs in the stock
> u-boot ;-) ).

Thanks, I'll have a look. The impression I get though is that these
things are still too recent to have settled, so if I flash an u-boot
now, maybe I'll have to flash it again later. Might as well wait a bit
and do it just once.

> > Is there a risk of damaging the board if it is accidentally booted with
> > the wrong DTB or without one?
> 
> There's always a risk at this level.  The statement in the Kconfig is
> true.  However, If you aren't willing to upgrade u-boot, you aren't
> leaving too many other options.  Knives are dangerous, too.  People
> still use them every day.  Just be careful.

If you have an accident with a knife at home, the worst that will happen
is that you'll have to use a band-aid for a few days. On the other hand,
when I go to the butcher I see him wearing a metal chain gauntlet when
cutting meat. If he has an accident with *that* knife, he'll be in
trouble. In both cases you are dealing with knives and in both cases you
have to be careful... My question was, what kind of knife I'm dealing
with here? ;-)

I bought this Dreamplug for personal use and if it breaks, I won't buy
another one. That's a different level of risk tolerance than someone
who's
working professionally on an ARM board, where breaking it is just cost
of
doing business. 

> > Does it help if I test with only dreamplug-3.4.0.patch (which adds
> > CONFIG_MACH_DREAMPLUG) applied?
> 
> Sure, see if the problem persists.  That would rule out the other
> patches.

I built a kernel with just that patch and it got stuck after
uncompressing the kernel. I'll have to build a new one with
CONFIG_ARM_PATCH_PHYS_VIRT disabled and try again tomorrow (I know, a
newer u-boot works around/fixes this).
-- 
[]'s
Thiago Jung Bauermann
