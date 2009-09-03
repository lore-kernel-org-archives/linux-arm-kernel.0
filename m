From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Thu, 3 Sep 2009 10:51:42 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902222641.GY32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
	<20090902191026.GO25153@trinity.fluff.org>
	<20090902222641.GY32606@prithivi.gnumonks.org>
Message-ID: <20090903095142.GB3302@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 07:26:41AM +0900, Harald Welte wrote:
> > > > does it support X kdrive 2D accelerate ?
> > > X / kdrive is not part of the linux kernel.  Therefore, it is unrelated
> > > to the Linux kernel code that we are working on.
> > Unfortunately it seems that pretty much no-one uses the fb driver
> > acceleration, I'm not even sure if it has even been exported outside
> > the kernel, so isn't really a lot of use.
> having cursor acceleration and things like bitblit for srolling is a real
> pleasure if you ever happen to work for more than 5 minutes on the framebuffer
> console, especially on a system that already has a quite high load at that time.
> It sort-of is a standard feature, and at least in the x86/PCI/AGP world, I
> am not awaer that any framebuffer driver would not support it.  That's why I
> had it on my todo list.

Simtec produced a set of patches to expose the Linux Kernel FB acceleration
primitives to userland, only to be told that it was unlikely they'd be accepted
due to them having never been exposed before.  (Yes, it was a case of 'We have
always done it this way, why would we want to change?')

Basically the expectation appears to be that userland wishing to use
acceleration features of a framebuffer device (such as the multiple planes,
hardware cursor support, hardware bitblt etc which an SoC or graphics chip
might implement) is expected to do it for itself by knowing which bit of
physical memory to mmap() and fiddle, underneath and behind-the-back-of the
kernel.

If you're interested in the patches we produced then I can try to dig them up
for you.

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
