From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 16 Jan 2010 23:26:09 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <20100116221929.GB8425@elf.ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001162305.56972.rjw@sisk.pl> <20100116221929.GB8425@elf.ucw.cz>
Message-ID: <201001162326.09092.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 January 2010, Pavel Machek wrote:
> On Sat 2010-01-16 23:05:56, Rafael J. Wysocki wrote:
> > On Saturday 16 January 2010, Pavel Machek wrote:
> > > On Sat 2010-01-16 18:00:58, Stanislav Brabec wrote:
> > > > Eric Miao wrote:
> > > > 
> > > > > And the other way we may need to look into what API the current userland
> > > > > apps on zaurus is depending on this 2.4 compatibility and make changes
> > > > > slowly to those apps.
> > > > 
> > > > I guess that 2.4 compatibility is not an issue. Most modern Zaurus
> > > > distributions are even unable to run Sharp ROM compatible binaries.
> > > > 
> > > > Distributions either stay on 2.4 kernel or use modern systems based on
> > > > modern kernel 2.6 API.
> > > > 
> > > > Distributions that decided to migrate to kernel 2.6 are far from
> > > > finished state. Any change that allows to use modern applications using
> > > > standard kernel API is welcome.
> > > 
> > > There is no API involved. It is just ... if you leave zaurus in
> > >  init=/bin/bash mode, it must not kill the battery. Smart and
> > >  currently implemented way to do that is to suspend.
> > 
> > IMHO it should just plain shutdown in that case.  Suspending doesn't really
> > solve the problem, because the battery is going to drain still.  Unless you
> > mean suspend=hibernate, but I guess you don't.
> 
> As I explained before, power consumption on suspend and hibernate and
> poweroff is equivalent on zaurus (7mA in all the cases -- sorry if I
> said uA before). And because it has 1800mAh battery, it means that
> even empty battery is going to last for a while. In practice, it works
> very well.
> 
> (There are other reasons, having to do with internal li-ion resistances
> in aged and cold batteries.)
> 
> > > That's counterexample to rjw, but it does not matter -- reasonable
> > > userland should never ever hit that, in a same way PCs should not hit
> > > emergency power cut...
> > 
> > I don't really understand what you mean.  The user space doesn't know the
> > battery state if the kernel doesn't tell it, AFAICS, so how exactly can it
> > predict the critical battery condition without the kernel notifying it?
> 
> That was not the point I was trying to discuss. Yes, we need
> kernel<->user notification of battery critical. 
> 
> But on zaurus, correct action is to suspend (not hibernate and not
> poweroff) when battery is no longer able to supply enough power to
> keep system alive.

Why not to poweroff (just asking, I don't know that hardware)?

I guess we should at least do our best to keep filesystems in a consistent
state and suspend doesn't really guarantee this if the system remains on
battery power afterwards.

Rafael
