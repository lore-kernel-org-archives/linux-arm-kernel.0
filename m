From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 May 2012 09:31:58 -0400
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <1338438730.4173.8.camel@hactar>
References: <1338401183.22894.11.camel@hactar>
 <20120531005109.GW24238@titan.lakedaemon.net>
 <1338431047.1822.11.camel@hactar>
 <20120531030931.GX24238@titan.lakedaemon.net>
 <1338438730.4173.8.camel@hactar>
Message-ID: <20120531133158.GY24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 01:32:10AM -0300, Thiago Jung Bauermann wrote:
> On Wed, 2012-05-30 at 23:09 -0400, Jason Cooper wrote:
> > Please try a vanilla v3.4 kernel with CONFIG_ARM_APPENDED_DTB.
> 
> To be honest I don't feel comfortable about doing that. One
> knowledgeable guy on the debian-kernel mailing list said that "the
> Kconfig entry for ARM_APPENDED_DTB is quite scary about enabling it and
> booting without a DTB appended"[1] and indeed it doesn't look very
> encouraging.

Yes, that's to discourage folks from doing that as a routine bootable
system.  The whole advantage of DT is that it goes with the board, and
you then build one kernel for multiple boards.  That advantage is lost
if people get in the habit of appending the DT to the kernel.  But for
testing once, it's fine as long as you remember to append the dtb.

You may want to look at the kwboot patches to u-boot [1].  It's a
utility that allows you to load u-boot with only the serial port
connected.  Many have reported success with it.  This would then allow
you to add DT boot support (and fix a bunch of bugs in the stock
u-boot ;-) ).

> Another message on the thread talks about "concerns about damaging
> other boards"[2] (maybe I am misreading this one?).

Yes, you are mis-reading it.  They are referring to breaking
drivers/board support on orion and mv78xxx.   _Not_ breaking the
*physical* boards.

> [1] http://lists.debian.org/debian-kernel/2012/03/msg00049.html
> [2] http://lists.debian.org/debian-kernel/2012/03/msg00645.html
> 
> Is there a risk of damaging the board if it is accidentally booted with
> the wrong DTB or without one?

There's always a risk at this level.  The statement in the Kconfig is
true.  However, If you aren't willing to upgrade u-boot, you aren't
leaving too many other options.  Knives are dangerous, too.  People
still use them every day.  Just be careful.

> Does it help if I test with only dreamplug-3.4.0.patch (which adds
> CONFIG_MACH_DREAMPLUG) applied?

Sure, see if the problem persists.  That would rule out the other
patches.

hth,

Jason.

[1] http://patchwork.ozlabs.org/patch/160484/
