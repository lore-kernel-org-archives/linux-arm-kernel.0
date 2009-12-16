From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 16 Dec 2009 23:53:28 +0100
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <20091214121247.GB22388@rakim.wolfsonmicro.main>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>
	<20091204104930.GA28625@sirena.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>
	<20091207114825.GA26965@rakim.wolfsonmicro.main>
	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>
	<20091207165628.GA24981@rakim.wolfsonmicro.main>
	<20091213132413.GB1437@ucw.cz>
	<20091214121247.GB22388@rakim.wolfsonmicro.main>
Message-ID: <20091216225328.GG21102@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-12-14 12:12:47, Mark Brown wrote:
> On Sun, Dec 13, 2009 at 02:24:14PM +0100, Pavel Machek wrote:
> 
> > > actual charger hardware.  My main concern here is that battery
> > > performance monitoring has no pressing need to be in kernel and that
> > > pushing it into the kernel creates a barrier to implementing more
> > > advanced schemes in userspace, which is especially serious given how
> > > involved this needs to be in order to be accurate.  
> 
> > Well, kernel provides /proc/apm emulation and many systems still rely
> > on it. So it would be nice to provide something halfway-decent there.
> 
> Unfortunately that's really painful in kernel since you really need to
> do state tracking over reboots, and even if you do that it's really
> not trivial.

No, I do not want to get _that_ advanced. But I'd really like to get
beyond "battery %age is linear function of measured battery voltage".

> > Plus you need to shutdown/suspend machine on battery critical. That
> > has to be in kernel and already needs those tricky parts.
> 
> Power failure detection based on voltage drop is much more reasonable
> but it's a very different thing to general battery capacity
> estimation.

Not sure...

> Normally you'd want to do the power failure detection separately anyway,
> monitoring the system supply voltage rather than the battery voltage.

Well, that way you'll discharge batteries too much and kill them
rather quickly, no? What is "system supply voltage" for PDA class
system, anyway? I don't think zaurus has ADCs on anything else than
thermistor, AC in voltage, battery voltage...

> Something like "Measure Battery Capacity Precisely in Medical Design"
> by Bernd Krafthoefer in Power Electronics Technology Jan 2005 might be
> useful here.

Thanks, it looks interesting. I'm not sure if it will be possible to
apply on zaurus, but... (While measuring voltage my underestimate the
old battery, I'm afraid they may overestimate it in bad conditions;
energy left is battery is useless if battery can't supply enough
current to keep CPU happy, because its too cold).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
