From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 15 Jun 2011 20:09:45 +0100
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
Message-ID: <20110615190945.GA2518@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2011 at 11:57:12AM -0700, Peter Fordham wrote:
> > I've added Wim (watchdog driver maintainer), but I would think that if
> > this change is worth doing then it should be done for all drivers.
> 
> Agreed, but today this may be more work than I'm strictly interested in
> doing. If we do decide it's the right thing then I'll look into converting the
> other drivers later.

So I'm not fully aware of what particular problem this is solving, but 
if it is needed for this driver then it should really be done for all of 
them.  That's probably one for Wim to answer though.  Wim posted a 
series for a generic watchdog framework a while back[1] but this still 
made use of a misc device.

> >> > I believe the sysfs classes are pretty much
> >> > deprecated now in preference of a bus too.
> >>
> >> Can you give me some more info here? I thought the sysfs stuff was the
> >> new right way of doing stuff. The class stuff allows udev to automatically
> >> create the right device node.
> >
> > So here's one that I'm aware of https://lkml.org/lkml/2011/3/25/502. ?So
> > there's nothing wrong with using sysfs and a bus, but certainly a bus is
> > preferred over a class.
> 
> I still don't really get this. If I don't use the class code my /dev node gets
> the name /dev/mpcore_wdt instaed of /dev/watchdog. Is the right thing
> to do to use a udev rule or is there a way to tell udev via sysfs to make
> /dev/watchdog instead of /dev/mpcore_wdt?

If you use a bus then the device creation is slightly more involved than 
with a class - create the bus, allocate the device and assign the 
bus_type then set the name with dev_set_name().  That should be enough 
for udev to work out the name of the device.

Jamie

1. http://www.spinics.net/lists/linux-watchdog/msg00082.html
