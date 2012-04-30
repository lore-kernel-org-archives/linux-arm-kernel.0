From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Apr 2012 21:24:28 +0000
Subject: [PATCH] maintainership update for the Marvell Orion family of SOCs
In-Reply-To: <87wr4x9c9t.fsf@lebrac.rtp-net.org>
References: <alpine.LFD.2.02.1204301330111.21030@xanadu.home>
 <87wr4x9c9t.fsf@lebrac.rtp-net.org>
Message-ID: <201204302124.28892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012, Arnaud Patard wrote:
> Sorry to hijack a little bit this thread, but I got a few days ago a
> 88ap510/dove device so I was wondering if the work currently done on
> kirkwood would allow us the same kernel binary at least on dove and
> kirkwood ? [1] If so, when it'll be possible, will it be considered to
> move the corresponding board setup from
> arch/arm/mach-{dove,kirkwood,...} into a new directory, like what was
> done on recently on imx ?
> 
> [1] I'm only talking of kirkwood and dove because it's only what I can
> test. Of course, if it can be a single kernel binary for
> dove/kirkwood/mv78xx0/orion5x, it'll be even better.

While I don't know of anyone working on this currently, I've also thought
about it being doable, but I would defer it until we can probe all
the devices using the device tree, because at that point it will get
much simpler. We might just move all the DT based board support into
the plat-orion directory and leave the other directories for the classic
probing, eventually to be removed when the new stuff can handle all the
machines that someone cares about.

Note that dove is fundamentally incompatible with the others at runtime,
being ARMv7 based instead of ARMv5, but it could still live in the same
directory, like we do for other platforms.

	Arnd
