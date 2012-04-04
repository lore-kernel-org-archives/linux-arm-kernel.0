From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Apr 2012 16:13:46 +0100
Subject: [CPUFREQ] Fix exposure of ARM_EXYNOS4210_CPUFREQ
In-Reply-To: <20120404150730.GC24211@n2100.arm.linux.org.uk>
References: <20120213094940.GA15338@n2100.arm.linux.org.uk>
 <4F3CF3DA.7000806@samsung.com>
 <20120216160250.GP13673@n2100.arm.linux.org.uk>
 <00aa01ccf084$93c98a70$bb5c9f50$%kim@samsung.com>
 <20120327074931.GK5611@n2100.arm.linux.org.uk> <4F73B3E1.4080807@samsung.com>
 <20120404145204.GA24211@n2100.arm.linux.org.uk>
 <20120404145917.GB1929@redhat.com>
 <20120404150353.GB24211@n2100.arm.linux.org.uk>
 <20120404150730.GC24211@n2100.arm.linux.org.uk>
Message-ID: <20120404151346.GD24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2012 at 04:07:30PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 04, 2012 at 04:03:53PM +0100, Russell King - ARM Linux wrote:
> > On Wed, Apr 04, 2012 at 10:59:17AM -0400, 'Dave Jones' wrote:
> > > On Wed, Apr 04, 2012 at 03:52:04PM +0100, Russell King - ARM Linux wrote:
> > >  > On Wed, Mar 28, 2012 at 05:59:13PM -0700, Kukjin Kim wrote:
> > >  > > Russell King wrote:
> > >  > >> As predicted, this is breaking other ARM platforms.  Please fix this
> > >  > >> yourself before your crappy code gets pushed into mainline.  Thanks.
> > >  > >>
> > >  > > I fixed it.
> > >  > 
> > >  > When will we see patches or the fix in mainline?
> > > 
> > > Just send it to Linus directly.
> > 
> > 'it'... well, that implies that someone already has a patch.  I've asked
> > Kukjin to fix the problem which he introduced because exynos is getting
> > rather complicated, and he'll know what the dependencies should be.  So
> > far I've yet to see any kind of patch fixing this stuff.
> > 
> > Meanwhile I'm seeing failing randconfig builds for non-exynos ARM for
> > about a week due to the lack of dependencies.
> 
> Actually, given that this has been known about since Feb 13th, I'm now
> going to ask for the exynos cpufreq updates to be reverted because
> there's clearly no motivation to fix this crap Kconfig shite.  Having
> it tossed out of mainline will provide the necessary motivation to get
> people to fix their own fuckups.

In case it's not clear - the problem applies to _all_ exynos stuff not
just the one which I had previously sent a patch for and you appear to
have applied.  Just look at the crap which was spat out today:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=546
