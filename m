From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 15:28:17 +0000
Subject: [PATCH v2 0/5] Generic PHY Framework
In-Reply-To: <20130219150500.GG4390@arwen.pp.htv.fi>
References: <1361253198-7401-1-git-send-email-kishon@ti.com>
 <201302191434.40495.arnd@arndb.de> <20130219150500.GG4390@arwen.pp.htv.fi>
Message-ID: <201302191528.17698.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013, Felipe Balbi wrote:
> On Tue, Feb 19, 2013 at 02:34:40PM +0000, Arnd Bergmann wrote:
> > On Tuesday 19 February 2013, Felipe Balbi wrote:
> > > On Tue, Feb 19, 2013 at 12:33:54PM +0000, Arnd Bergmann wrote:
> > It's a fine line, but I think a phy is something that resembles a device
> > more than an LED does. When I read patch 1, I also noticed and commented
> > on the fact that it does use a 'class'. Now, according to Greg, we should
> > use 'bus_type' instead of 'class' in new code. I originally disagreed with
> > that concept, but he's the boss here and it's good if he has a vision
> > how things should be lined out.
> > 
> > In practice, there is little difference between a 'bus_type' and a 'class',
> > so just replace any instance of the former with the latter in your head
> > when reading the code ;-)
> 
> it's not so simple :-) if we must use bus_type we need to introduce all
> the device/driver matching mechanism which isn't necessary with a class.

I think the idea is to use a bus_type that has devices but no drivers
associated with it, but I might be misremembering things.

> > I understand that there is not a real common bus here, and the bus_type
> > infrastructure would basically be used as a way to represent each PHY
> > in sysfs and provide a way to enumerate and look them up inside of the
> > kernel.
> 
> right, but maybe we need another mechanism. If, in the long run we must
> use bus_type, then eventually pwm, led, regulators, etc will all be
> converted to bus_type. It will look quite weird IMHO.

Yes, it would be a bit unusual, I agree.

> Greg, can you pitch your suggestion here ? It would be great to hear
> your rationale behind dropping class infrastructure, couldn't find
> anything through Google and since feature-removal-schedule.txt has been
> removed (without adding it to feature-removal-schedule.txt, I must add
> :-) I don't know what's the idea behind removing classes.

I believe for now, the idea is to not add any new classes, but keep
the existing ones for compatibility. 'struct class_device' however
was already removed and got turned into 'struct device'.

	Arnd
