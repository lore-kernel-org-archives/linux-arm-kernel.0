From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Thu, 3 Sep 2009 11:40:21 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903103421.GA9507@n2100.arm.linux.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<19987914.1168001251884594226.JavaMail.coremail@bj126app54.126.com>
	<20090902120159.GT32606@prithivi.gnumonks.org>
	<20090902191026.GO25153@trinity.fluff.org>
	<20090902222641.GY32606@prithivi.gnumonks.org>
	<20090903095142.GB3302@digital-scurf.org>
	<20090903103421.GA9507@n2100.arm.linux.org.uk>
Message-ID: <20090903104021.GC3302@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2009 at 11:34:21AM +0100, Russell King - ARM Linux wrote:
> There is protection built in here to prevent userspace having access to
> the hardware registers while the kernel wants to access them - you can
> only mmap the MMIO registers provided var.accel_flags is zero (in other
> words, you've asked the kernel _not_ to use any hardware acceleration.)
> To put it another way, your driver must not use hardware acceleration
> for the FB console if var.accel_flags is zero.

Aah, I see.

> So, really, there's no "fiddling behind the back of the kernel" if things
> are done correctly, and there's no need to know where the registers
> actually appear in the physical space - which was required in the old
> days of mapping them via /dev/mem.

Right. I must have misunderstood my colleague who was talking about this.  I
shall withdraw that particular part of my complaint then :-)

> Yes, it's unfortunate that the acceleration functions themselves are not
> available to userspace, but I don't think the situation is as bad as
> you're making it out to be.

However, each app wishing to have accelerated access to a framebuffer needs to
reimplement the acceleration functions.  Admittedly there's things like
libdirectfb which abstracts that for most users.  However that's still two
implementations (one userland, one kernel) for the same feature.  I can see the
attraction of making userland able to take over acceleration because that way
the kernel doesn't have to have "generic" acceleration primitives for every
last odd feature a graphics controller might implement -- but by the same
token, when the features are already there and all that a program wants, it's a
pity it can't just use the kernel.  Still, this isn't really the right forum
for this discussion so I'll stop now.

Thanks for the clarification.

D.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
