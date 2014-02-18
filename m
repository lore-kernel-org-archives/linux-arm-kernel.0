From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Feb 2014 14:58:09 +0100
Subject: [PATCH] net: ethernet: remove unneeded dependency of mvneta and
 update help text
In-Reply-To: <20140218141303.77c77272@skate>
References: <1392719391-8851-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140218122952.GM7862@titan.lakedaemon.net>
 <20140218134532.7607a616@skate>
 <20140218125206.GN7862@titan.lakedaemon.net>
 <20140218141303.77c77272@skate>
Message-ID: <20140218135809.GD17984@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> At this point, I don't expect to see this IP in any other SOCs than
> Marvell Armada EBU, so I'll resend with a "depends on PLAT_ORION", as I
> agree it is much safer in terms of build problems.

Hi Thomas

PLAT_ORION is a bit of an odd thing now.

For me, PLAT_ORION means arch/arm/plat-orion. 

But as far as i know, 370/XP does not actually use anything from
arch/arm/plat-orion. When kirkwood moves into mach-mvebu, it also will
not use any code from it, and i suspect dove is the same.

So maybe in a few cycles, when only mach-orion5x is left, we can merge
arch/arm/plat-orion into arch/arm/mach-orion5x and PLAT_ORION goes
away?

Or do we want to define that PLAT_ORION means any system which can
make use of mvebu drivers?

     Andrew
