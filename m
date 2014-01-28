From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 28 Jan 2014 15:14:58 +0100
Subject: [linux-pm] ARM hibernation / suspend-to-disk
In-Reply-To: <51A6399D.4090606@ti.com>
References: <20130529081005.GA25561@hal>
 <51A6399D.4090606@ti.com>
Message-ID: <20140128141458.GD8713@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > what's the status of suspend-to-disk on ARM? The most recent discussion I
> > found is:
> > http://lists.linuxfoundation.org/pipermail/linux-pm/2012-November/034997.html
> > 
> > with no replies at all. Is anyone still working on that? Anyone got it running?
> > 
> > I tried the patch above (on top of LTS 3.4) and got stuck forever, the last
> > thing on the console was:
> > 
> > root at omap5:/sys/power# echo disk > state
> > [ 2015.641540] PM: Syncing filesystems ... done.
> > [ 2015.666870] PM: Preallocating image memory... done (allocated 16957 pages)
> > [ 2016.062011] PM: Allocated 67828 kbytes in 0.38 seconds (178.49 MB/s)
> > 
> > Any hint how to debug that?
> 
> Because of the nature of omap5 PM, you'd need omap5 specific support in
> order for this to work. Specifically, there are a number of assumptions
> about certain power domains never losing state. You can take a look at
> the work I did to get this working on am335x here:
> 
> https://github.com/russdill/linux/commits/arm-hibernation-am33xx
> 
> For ARM hibernation support to get merged, there needs to be at least
> one platform that supports it. the am335x code I have is not ready as it
> still relies on PM patchsets that have not yet themselves been merged.

Given that we have chicken-and-egg problem here, I believe it makes sense
to merge generic ARM hibernation support now.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
