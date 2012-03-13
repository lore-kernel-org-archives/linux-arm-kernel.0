From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 14:33:07 +0000
Subject: Conflict between Versatile Express DT conversion and local timer
 updates
In-Reply-To: <4F5F52A2.3050005@arm.com>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
 <201203131155.16454.arnd@arndb.de> <4F5F52A2.3050005@arm.com>
Message-ID: <201203131433.07214.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 March 2012, Marc Zyngier wrote:
> On 13/03/12 11:55, Arnd Bergmann wrote:
> > On Tuesday 13 March 2012, Marc Zyngier wrote:
> >> On 13/03/12 10:15, Russell King - ARM Linux wrote:

> > d) create a new next/timer branch in arm-soc that has Pawel's     
> >    98ed4ceb "ARM: vexpress: Get rid of MMIO_P2V" (the first patch from
> >    vexpress/dt, your patches and the ux500/timer series. Also put
> >    98ed4ceb into the next/cleanup branch.
> > 
> > Any of those will work for us, my preference would be on #4. I have
> > created the next/timer branch in the arm-soc tree, so you can use
> > that and either rebase your patches on top or merge your tree into
> > it and fix up the merge conflicts.
> 
> Thanks for doing that Arnd.
> 
> I've thus created a new branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> local_timers-for-arm-soc
> 
> which contains the arm-soc next/timers branch as well as my local timers
> series. I'd greatly appreciate if you could pull it for 3.4.
> 

I've updated the next/timer branch with your changes now, but did not
put it into the for-next branch because Olof is currently handling that.

Olof, can you add it to for-next please? The timer branch should have
no dependencies other than rmk/for-armsoc, so it can be fairly close to
the start.

	Arnd
