From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 05:48:00 +0200
Subject: [PATCH 1/4] GPMI-NAND: Define ecc.strength
In-Reply-To: <4FB9B19B.2080309@freescale.com>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
 <201205210440.09310.marex@denx.de> <4FB9B19B.2080309@freescale.com>
Message-ID: <201205210548.00536.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

> ? 2012?05?21? 10:40, Marek Vasut ??:
> > I doubt so ... but noone ever could test it without DT bindings as you
> > NAKed/stalled every single attempt to add the platform binding code. So
> > this code was rotting in the tree, who knows how many bugs are still in
> > it. Now I guess it's about time to start squashing the bugs.
> 
> I checked the latest l2-mtd code. The bug does exit if the gpmi-nand
> driver can works(actually it can not).

There's also the bug where you need to put gpmi at 8000c000 into the DTS file 
instead of gpmi-nand at 8000c000 ... maybe you should fix it?

Also, there's still the bug with subpage write size, "GPMI-NAND: Wrong ECC size 
in driver" thread in linux-mtd. That thread kind of died, but gpmi-nand is still 
broken in that way, it's depending on loose end of the mtd stack there. Won't 
hurt fixing that too, there was even a fix proposed.

> 
> I will test your patch.
> Anyway, this patch should be sent to Artem, not the arm-soc.

Resent, fixed, sorry for the inconvenience.

> 
> thanks
> Huang Shijie

Best regards,
Marek Vasut
