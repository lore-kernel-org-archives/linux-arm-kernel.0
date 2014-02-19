From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 19 Feb 2014 10:18:46 -0500
Subject: [GIT PULL] irqchip: dove: drivers for v3.14
In-Reply-To: <alpine.DEB.2.02.1402182124480.4468@ionos.tec.linutronix.de>
References: <20131201172914.GV2879@titan.lakedaemon.net>
 <20131211175037.GY10053@titan.lakedaemon.net>
 <20140110183430.GO19878@titan.lakedaemon.net>
 <20140128173531.GT29184@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402041959110.24986@ionos.tec.linutronix.de>
 <20140204211219.GK8533@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402042230230.24986@ionos.tec.linutronix.de>
 <20140207180836.GE8533@titan.lakedaemon.net>
 <20140217193230.GW7862@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402182124480.4468@ionos.tec.linutronix.de>
Message-ID: <20140219151846.GH7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas!  Hi!

On Tue, Feb 18, 2014 at 09:51:31PM +0100, Thomas Gleixner wrote:
> On Mon, 17 Feb 2014, Jason Cooper wrote:
> > On Fri, Feb 07, 2014 at 01:08:36PM -0500, Jason Cooper wrote:
> > > On Tue, Feb 04, 2014 at 10:30:53PM +0100, Thomas Gleixner wrote:
> > > > On Tue, 4 Feb 2014, Jason Cooper wrote:
> > > > 
> > > > > On Tue, Feb 04, 2014 at 07:59:58PM +0100, Thomas Gleixner wrote:
> > > > > > On Tue, 28 Jan 2014, Jason Cooper wrote:
> > > > > > > I see you pulled in mvebu/irqchip-fixes.  Thanks for that.  It's getting
> > > > > > > near to the end of the merge window and there's been no activity on this
> > > > > > > pull request.
> > > > > > > 
> > > > > > > Please let us know if there's anything we can do to assist.
> > > > > > 
> > > > > > Nah. I simply forgot about it. About to send a pull request to Linus.
> > > > > 
> > > > > hmmm.  I see the pull request contains the patches from
> > > > > mvebu/irqchip-fixes (armada), but not the patches from mvebu/irqchip
> > > > > (dove):
> > > > > 
> > > > >   40b367d95fb3 irqchip: irq-dove: Add PMU interrupt controller.
> > > > > 
> > > > > which is what this thread was originally a pull request for.
> > > > > 
> > > > > 
> > > > > Are you planning to send a second pull request to Linus?
> > > > 
> > > > Duh. I'll pick that up tomorrow
> > > 
> > > Ping?
> > 
> > I think it's safe to say that the Dove PMU interrupt controller isn't
> > going to make it in to v3.14.  I've posted a patch to remove the DT node
> > for v3.14.
> 
> Yes, sorry. I messed that one up.

No problem, I just wasn't sure how hard to push and didn't want to be a
d*ck.

> > If you don't mind, I'll go ahead and take this pull request through the
> > mvebu tree for v3.15.  So that way it's off your plate and you don't
> > have to worry about it.
> 
> I pushed it out to tip/irq/core now.

Ok, great!

> > There's more mvebu irqchip stuff on the way :)
> 
> You have an entry in my mail filter rules now, so you'll end up in the
> priority queue with your pull requests :)

Ahhh... That's the magic sauce. :)

> Btw, I just looked at that dove driver and if you look at the other
> drivers/irqchip variants which use the generic irq domain/chip stuff,
> then the code in the init functions +/- some minimalistic fixes is
> just the same boiler plate except for quirks or a few register writes.

Yes, thanks for not insisting on this cleanup/consolidation right now.
:)  In this window we're currently adding three new SoCs to mach-mvebu
(Armada 375, 380, and 385), the associated drivers, and we're finally
migrating the DT enabled kirkwood from mach-kirkwood into mach-mvebu.
And it looks like mach-dove might be ready to migrate in as well this
window.

Once the dust settles next window, I'll keep this consolidation on our
radar.  We've already done the same for other drivers (watchdog jumps
out).

thx,

Jason.
