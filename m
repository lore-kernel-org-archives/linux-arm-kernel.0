From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 5 Jul 2013 14:10:04 -0700
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <alpine.DEB.2.02.1307052259090.32106@ionos.tec.linutronix.de>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130704033026.GX4288@tarshish>
 <0030b826-0eb1-4bb8-a0de-1d8dc68bd81a@TX2EHSMHS017.ehs.local>
 <alpine.DEB.2.02.1307052238170.32106@ionos.tec.linutronix.de>
 <4fab6223-45c5-453e-9972-1c12aa79a312@CO1EHSMHS008.ehs.local>
 <alpine.DEB.2.02.1307052259090.32106@ionos.tec.linutronix.de>
Message-ID: <db965b9f-740b-4ea6-9219-09ece1fc9220@CO9EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 10:59:53PM +0200, Thomas Gleixner wrote:
> On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> > On Fri, Jul 05, 2013 at 10:42:03PM +0200, Thomas Gleixner wrote:
> > > We have a mechanism for that in place, if stuff goes cross trees. One
> > > of the trees provides a set of commit for the other tree to pull, so
> > > we do not end up with merge dependencies and conflicts.
> > > 
> > > Why is clocksource stuff going through armsoc unless it contains
> > > related modifications in arch/arm/
> > We overhauled Zynq's common clock code and migrated all Zynq drivers to
> > it - the TTC being one. I'm pretty sure you were on the CC list for that
> > change.
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=30e1e28598c2674c133148d8aec6d431d7acd314
> > 
> 
> That's fine as it has no dependencies on any of the clocksource core
> changes AFAICT.
Right, shouldn't be a big deal. Just for this patch, I currently have the
choice of working with the old TTC but the new clocksource core or the
other way around. But since everything is going to meet in Linus' tree
soon, I just wait a bit until tip/timers is merged.

	S?ren
