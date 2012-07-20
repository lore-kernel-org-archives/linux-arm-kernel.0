From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 20 Jul 2012 17:52:37 +0200
Subject: SATA working on 370/XP, Ethernet next...
In-Reply-To: <20120720144133.GA15606@lunn.ch>
References: <20120720144133.GA15606@lunn.ch>
Message-ID: <20120720175237.6a10eb83@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 20 Jul 2012 16:41:33 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> I'm interested in Ethernet. I assume it uses
> drivers/net/ethernet/marvell/mv643xx_eth.c?

No, the network IP in the A370 and AXP is totally different and Marvell
engineers think it needs a new driver, and I have been making internal
reviews of their driver, but it needs more work before being ready for
submission.

A while ago, we had a discussion with Ben Dooks (from CodeThink) on
whether a new driver was needed or not. Ben will correct me if I'm
wrong, but he was suggesting that a new driver was not needed, but both
Marvell engineers and my comparison of the datasheets between A370/AXP
and older Marvell EBU SoCs clearly show that this IP has changed
dramatically, and is even not the same IP as before.

If needed, I can post the network driver code in a RFC state, but it is
clearly not yet ready for inclusion.

I would of course be happy to test SATA patches for the Armada XP. Ian,
did you reuse the plat-orion/addr-map.c code to do the window setup?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
