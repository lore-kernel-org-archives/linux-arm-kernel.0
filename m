From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Dec 2014 15:30:21 -0500
Subject: [PATCH 08/27] ARM: mvebu: armada-370-xp: Relicense the device
 tree under GPLv2+/X11
In-Reply-To: <20141216184456.GR11285@n2100.arm.linux.org.uk>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <1418657915-22775-9-git-send-email-gregory.clement@free-electrons.com>
 <20141215232221.GD19261@kw.sim.vm.gnt>
 <20141216130331.GJ967@titan.lakedaemon.net>
 <20141216133719.GE19261@kw.sim.vm.gnt>
 <20141216144533.GL967@titan.lakedaemon.net>
 <20141216184456.GR11285@n2100.arm.linux.org.uk>
Message-ID: <20141216203021.GS967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 06:44:56PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 16, 2014 at 09:45:33AM -0500, Jason Cooper wrote:
> > Ok, fair enough.  I just needed to know if the NAK was against the
> > GPLv2+ part or the X11 part.  Clearly, it's the X11 part.
> 
> Yes, it's rather sad that Simon has said no to this - because the whole
> reason for this is to promote sharing these files with other projects
> and allowing them to re-use this data.
> 
> > Options:
> > 
> > - Ask Simon to find an OSI-compatible license to replace X11 that:
> >    - *BSD can use
> >    - meets the intent of himself and other like-minded authors
> 
> I don't think that's on - we really don't want to ask those who have
> already transitioned to include X11 to re-think their licensing for
> another time.
> 
> > - Leave licensing as is, but make a statement that *using* the dts
> >   doesn't create a derivative work under the GPL (similar to Linus'
> >   statement re the Linux kernel, Wolfgang and U-Boot, etc).
> > - Screw it, plow forward, and revert/rewrite GPLonly commits
> > - Ignore the whole issue and hope it goes away.
> > 
> > Personally, I'm in favor of the second one, and think it has the highest
> > chance of success.  After all, ARM-based *BSD is launched from a GPL
> > bootloader in most cases, right (U-Boot, barebox)?  Thoughts?
> 
> What if another OS (such as BSD) needs to add some additional hardware
> description to the DT files (because, for example, we've modelled
> something on the Linux implementation, rather than describing the
> hardware.)

irqchip?  </me ducks>

> Another OS may not be happy to contribute to something which is GPLv2
> only, in which case you'll get division of the DT.

Very good point.

> The question is whether you're likely to see 370-xp adopted by other
> OS - if yes, then rewriting Simon's commits are the way to go, if not,
> then staying as-is is probably best.

Well, the favorite hobby of part-time hackers is running mainline
kernels on random NASs and Wifi Routers.  A lot of which have Marvell
SoCs in them...  That's how myself and most of the mvebu contributors
got into this.

> However, there's one issue here which can't be overlooked - what if
> some of Simon's work has been copied by someone else into another DT
> file, which then gets re-licensed with X11... This is going to need
> careful auditing - and careful auditing for ever going forward.

It looks as though Arnd is already looking at that.  So far, it seems
isolated to the Lacie boards.

> It would just be a whole lot easier if Simon did give his permission,
> but if he really is unwilling to allow his efforts to be re-used else-
> where, then we will have to do that work.

I'll admit I'm stuck here.  I disagree with Simon, but I also think we
need to respect his desire as author of the files.

I'm not a fan of GPLv2+, but I'm willing to compromise if it means wider
adoption of DT.  I would hope Simon could come around to the same
conclusion from the other side.

thx,

Jason.
