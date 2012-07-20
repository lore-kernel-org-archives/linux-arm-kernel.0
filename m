From: ian.molton@codethink.co.uk (Ian Molton)
Date: Fri, 20 Jul 2012 17:25:46 +0100
Subject: SATA working on 370/XP, Ethernet next...
In-Reply-To: <20120720181258.65cbd2fe@skate>
References: <20120720144133.GA15606@lunn.ch> <20120720175237.6a10eb83@skate>
 <500981C6.3090109@codethink.co.uk> <20120720181258.65cbd2fe@skate>
Message-ID: <5009868A.9090807@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/12 17:12, Thomas Petazzoni wrote:
> Le Fri, 20 Jul 2012 17:05:26  +0100, Ian Molton
 > <ian.molton@codethink.co.uk> a ?crit :
 >
 >>> A while ago, we had a discussion with Ben Dooks (from CodeThink)
 >>> on whether a new driver was needed or not. Ben will correct me if
 >>> I'm wrong, but he was suggesting that a new driver was not
 >>> needed, but both Marvell engineers and my comparison of the
 >>> datasheets between A370/AXP and older Marvell EBU SoCs clearly
 >>> show that this IP has changed dramatically, and is even not the
 >>> same IP as before. If needed, I can post the network driver code
 >>> in a RFC state, but it is clearly not yet ready for inclusion.
 >>
 >> I would certainly like to see that if possible, it'd definitley
 >> help my analysis of the problem.
 >
 > Ok. I am not sure I wanted to submit this publicly on the netdev
 > mailing list right now, because the first feeling with a given patch
 > set is an important one. Would a private submission be possible?

Certainly.

 >> The code is very similar, and could probably be merged with that.
 >> is plat-orion meant to now be common to orion, kirkwood, and
 >> armada?
 >
 > Ok, so you duplicated the addr-map.c code?

For now, yes. Since it sounds like it'll be acceptable to use plat-orion,
I will redo my patch to do that, and post it here.

> Initially, I didn't want to use  the plat-orion/ code, because I
 > wanted to replace that with proper drivers (i.e pinctrl driver
 > instead of MPP, gpio driver in drivers/gpio, proper platform driver
 > for PCI, etc.). But many drivers (SATA, SDIO, etc.) need the headers
 > file from plat-orion/. So reusing those drivers without using
 > plat-orion/ is not that simple.

Looks like a couple of base addresses differ. I'll let you know if this
causes any trouble on monday.

> Would you mind sharing the  current state of your SATA work, even if
 > not ready for prime time?

Sure, I'll sort out posting it up first thing monday.

>> the window setup code looks  horrid to me - we really should look
 >> for a way to pass this in nicely.
 >
 > I had started a discussion with Andrew on the mailing list earlier
 > this week, and we agreed for the moment to re-use the existing code,
 > and see later what could be done to expose this in the device tree.

I'll take a look.

Cheers,

-Ian
