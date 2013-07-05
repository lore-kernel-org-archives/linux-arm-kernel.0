From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 5 Jul 2013 22:59:53 +0200 (CEST)
Subject: [PATCH] clocksource/cadence_ttc: Reuse clocksource as sched_clock
In-Reply-To: <4fab6223-45c5-453e-9972-1c12aa79a312@CO1EHSMHS008.ehs.local>
References: <1372888216-10726-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130704033026.GX4288@tarshish>
 <0030b826-0eb1-4bb8-a0de-1d8dc68bd81a@TX2EHSMHS017.ehs.local>
 <alpine.DEB.2.02.1307052238170.32106@ionos.tec.linutronix.de>
 <4fab6223-45c5-453e-9972-1c12aa79a312@CO1EHSMHS008.ehs.local>
Message-ID: <alpine.DEB.2.02.1307052259090.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, S?ren Brinkmann wrote:
> On Fri, Jul 05, 2013 at 10:42:03PM +0200, Thomas Gleixner wrote:
> > We have a mechanism for that in place, if stuff goes cross trees. One
> > of the trees provides a set of commit for the other tree to pull, so
> > we do not end up with merge dependencies and conflicts.
> > 
> > Why is clocksource stuff going through armsoc unless it contains
> > related modifications in arch/arm/
> We overhauled Zynq's common clock code and migrated all Zynq drivers to
> it - the TTC being one. I'm pretty sure you were on the CC list for that
> change.
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=30e1e28598c2674c133148d8aec6d431d7acd314
> 

That's fine as it has no dependencies on any of the clocksource core
changes AFAICT.

Thanks,

	tglx
