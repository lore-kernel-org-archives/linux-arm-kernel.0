From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Jul 2012 18:12:58 +0200
Subject: SATA working on 370/XP, Ethernet next...
In-Reply-To: <500981C6.3090109@codethink.co.uk>
References: <20120720144133.GA15606@lunn.ch> <20120720175237.6a10eb83@skate>
 <500981C6.3090109@codethink.co.uk>
Message-ID: <20120720181258.65cbd2fe@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 20 Jul 2012 17:05:26 +0100,
Ian Molton <ian.molton@codethink.co.uk> a ?crit :

> > A while ago, we had a discussion with Ben Dooks (from CodeThink) on
> > whether a new driver was needed or not. Ben will correct me if I'm
> > wrong, but he was suggesting that a new driver was not needed, but both
> > Marvell engineers and my comparison of the datasheets between A370/AXP
> > and older Marvell EBU SoCs clearly show that this IP has changed
> > dramatically, and is even not the same IP as before.
> > If needed, I can post the network driver code in a RFC state, but it 
> > is clearly not yet ready for inclusion.
> 
> I would certainly like to see that if possible, it'd definitley help my
> analysis of the problem.

Ok. I am not sure I wanted to submit this publicly on the netdev
mailing list right now, because the first feeling with a given patch
set is an important one. Would a private submission be possible?

I have been busy the last two days reviewing the code, making many
cleanups on it and collecting comments for the Marvell engineer who
wrote the code initially.

> > I would of course be happy to test SATA patches for the Armada XP. 
> > Ian, did you reuse the plat-orion/addr-map.c code to do the window 
> > setup? Best regards, Thomas 
> 
> The code is very similar, and could probably be merged with that. is
> plat-orion meant to now be common to orion, kirkwood, and armada?

Ok, so you duplicated the addr-map.c code?

Initially, I didn't want to use the plat-orion/ code, because I wanted
to replace that with proper drivers (i.e pinctrl driver instead of MPP,
gpio driver in drivers/gpio, proper platform driver for PCI, etc.). But
many drivers (SATA, SDIO, etc.) need the headers file from plat-orion/.
So reusing those drivers without using plat-orion/ is not that simple.

Would you mind sharing the current state of your SATA work, even if not
ready for prime time?

> the window setup code looks horrid to me - we really should look for a
> way to pass this in nicely.

I had started a discussion with Andrew on the mailing list earlier this
week, and we agreed for the moment to re-use the existing code, and see
later what could be done to expose this in the device tree.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
