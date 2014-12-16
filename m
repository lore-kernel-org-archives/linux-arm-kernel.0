From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Dec 2014 18:44:56 +0000
Subject: [PATCH 08/27] ARM: mvebu: armada-370-xp: Relicense the device
 tree under GPLv2+/X11
In-Reply-To: <20141216144533.GL967@titan.lakedaemon.net>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <1418657915-22775-9-git-send-email-gregory.clement@free-electrons.com>
 <20141215232221.GD19261@kw.sim.vm.gnt>
 <20141216130331.GJ967@titan.lakedaemon.net>
 <20141216133719.GE19261@kw.sim.vm.gnt>
 <20141216144533.GL967@titan.lakedaemon.net>
Message-ID: <20141216184456.GR11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 09:45:33AM -0500, Jason Cooper wrote:
> Ok, fair enough.  I just needed to know if the NAK was against the
> GPLv2+ part or the X11 part.  Clearly, it's the X11 part.

Yes, it's rather sad that Simon has said no to this - because the whole
reason for this is to promote sharing these files with other projects
and allowing them to re-use this data.

> Options:
> 
> - Ask Simon to find an OSI-compatible license to replace X11 that:
>    - *BSD can use
>    - meets the intent of himself and other like-minded authors

I don't think that's on - we really don't want to ask those who have
already transitioned to include X11 to re-think their licensing for
another time.

> - Leave licensing as is, but make a statement that *using* the dts
>   doesn't create a derivative work under the GPL (similar to Linus'
>   statement re the Linux kernel, Wolfgang and U-Boot, etc).
> - Screw it, plow forward, and revert/rewrite GPLonly commits
> - Ignore the whole issue and hope it goes away.
> 
> Personally, I'm in favor of the second one, and think it has the highest
> chance of success.  After all, ARM-based *BSD is launched from a GPL
> bootloader in most cases, right (U-Boot, barebox)?  Thoughts?

What if another OS (such as BSD) needs to add some additional hardware
description to the DT files (because, for example, we've modelled
something on the Linux implementation, rather than describing the
hardware.)

I'm thinking about things like the sound {} nodes and similar.

Another OS may not be happy to contribute to something which is GPLv2
only, in which case you'll get division of the DT.

The question is whether you're likely to see 370-xp adopted by other
OS - if yes, then rewriting Simon's commits are the way to go, if not,
then staying as-is is probably best.

However, there's one issue here which can't be overlooked - what if
some of Simon's work has been copied by someone else into another DT
file, which then gets re-licensed with X11... This is going to need
careful auditing - and careful auditing for ever going forward.

It would just be a whole lot easier if Simon did give his permission,
but if he really is unwilling to allow his efforts to be re-used else-
where, then we will have to do that work.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
