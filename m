From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Aug 2012 14:22:36 +0200
Subject: [PATCH] mtd: orion_nand: remove <mach/hardware.h> include
In-Reply-To: <20120828091139.GC31704@lunn.ch>
References: <20120816183708.GT22226@titan.lakedaemon.net>
 <1346110528-30858-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346110528-30858-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120828091139.GC31704@lunn.ch>
Message-ID: <20120828142236.2c7e9bd3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 28 Aug 2012 11:11:39 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> I compiled tested on Dove, Kirkwood, Orion5x and mv78xx0.
> 
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks! Will Jason take care of merging this on top of the previous
address decoding patches? Note that if you want to keep build
bisectability, it should be merged before my "arm: plat-orion: introduce
PLAT_ORION_LEGACY hidden config option" patch.

> One other driver you might want to look at is:
> 
> drivers/watchdog/orion_wdt.c
> 
> It uses <mach/bridge-regs.h>

This driver is:

config ORION_WATCHDOG
        tristate "Orion watchdog"
        depends on ARCH_ORION5X || ARCH_KIRKWOOD

so it isn't selectable with ARCH_MVEBU, so it will not cause problems
for now. Of course, at some point, we'll have a look at the watchdog
driver but for now, it's fine.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
