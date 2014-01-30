From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Jan 2014 19:06:39 +0100
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <20140128182245.18840.51279@capellas-linux>
References: <20130529081005.GA25561@hal> <51A6399D.4090606@ti.com>
 <20140128141458.GD8713@xo-6d-61-c0.localdomain>
 <20140128182245.18840.51279@capellas-linux>
Message-ID: <20140130180639.GC16503@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > what's the status of suspend-to-disk on ARM? The most recent discussion I
> > > > found is:
> > > > http://lists.linuxfoundation.org/pipermail/linux-pm/2012-November/034997.html
> > > > 
> > > > with no replies at all. Is anyone still working on that? Anyone got it running?
> 
> Hi Pavel, Russ,
> 
> I have been looking and working with Russ' most recent branch based
> on the 3.12 kernel, which includes the big pile of patches for OMAP.
> (https://github.com/russdill/linux/commits/arm-hibernation-am33xx-v3.12)
> 
> He has hibernation mostly working and I have been able to run 1400 or
> so entry/exits overnight there on beaglebone black without issue.
> Combining this with device activity has been tricky.  An active
> network will lose the link on restore.  Active SD traffic will
> eventually hang (Last night ran for about 11 hours before hanging
> after ~350 or so hibernations).  I have not found where this is or
> the cause.

Yeah, but those are driver problems, right? 1400 suspends is very
nice, and it shows that the core is working. That should be enough for
merge; driver problems can be solved later.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
