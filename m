From: ian.molton@codethink.co.uk (Ian Molton)
Date: Fri, 20 Jul 2012 17:05:26 +0100
Subject: SATA working on 370/XP, Ethernet next...
In-Reply-To: <20120720175237.6a10eb83@skate>
References: <20120720144133.GA15606@lunn.ch> <20120720175237.6a10eb83@skate>
Message-ID: <500981C6.3090109@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/07/12 16:52, Thomas Petazzoni wrote:
> Le Fri, 20 Jul 2012 16:41:33 +0200,
> Andrew Lunn <andrew@lunn.ch> a ?crit :
>
> > I'm interested in Ethernet. I assume it uses
> > drivers/net/ethernet/marvell/mv643xx_eth.c?
>
> A while ago, we had a discussion with Ben Dooks (from CodeThink) on
> whether a new driver was needed or not. Ben will correct me if I'm
> wrong, but he was suggesting that a new driver was not needed, but both
> Marvell engineers and my comparison of the datasheets between A370/AXP
> and older Marvell EBU SoCs clearly show that this IP has changed
> dramatically, and is even not the same IP as before.
> If needed, I can post the network driver code in a RFC state, but it 
> is clearly not yet ready for inclusion.

I would certainly like to see that if possible, it'd definitley help my
analysis of the problem.

> I would of course be happy to test SATA patches for the Armada XP. 
> Ian, did you reuse the plat-orion/addr-map.c code to do the window 
> setup? Best regards, Thomas 

The code is very similar, and could probably be merged with that. is
plat-orion meant to now be common to orion, kirkwood, and armada?

the window setup code looks horrid to me - we really should look for a
way to pass this in nicely.
