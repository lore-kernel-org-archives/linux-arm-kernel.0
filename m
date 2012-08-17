From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 17 Aug 2012 15:21:56 +0200
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120816183708.GT22226@titan.lakedaemon.net>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120816132839.GO22226@titan.lakedaemon.net>
 <20120816183708.GT22226@titan.lakedaemon.net>
Message-ID: <20120817152156.4d91ba16@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Thu, 16 Aug 2012 14:37:08 -0400,
Jason Cooper <jason@lakedaemon.net> a ?crit :

> > Whole series applied to:
> > 
> > git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7
> 
> I'm getting the following build error with orion_nand enabled:
> 
>   CC      drivers/mtd/nand/orion_nand.o
> drivers/mtd/nand/orion_nand.c:24:27: fatal error: mach/hardware.h: No
> such file or directory
> compilation terminated.
> 
> I don't have time to look at it right now, hopefully I can look at it
> tomorrow or this weekend.

I have just built your boards-for-v3.7 for Kirkwood (which includes the
orion_nand driver) and it builds just fine.

Are you perhaps trying to enable the orion_nand driver for a mach-mvebu
platform (Armada 370 or XP)? If it's the case, then yes, this build
breakage is expected: we haven't enabled any of the I/O for now, so we
don't have hardware.h yet. This is not something that is broken due to
the address decoding changes.

If however my guess was wrong, could you send me the failing .config so
that I can reproduce and investigate?

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
