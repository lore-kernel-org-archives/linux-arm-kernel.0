From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 2 Apr 2018 09:01:00 +0200
Subject: [PATCH] mtd: nand: davinci: don't acquire and enable clock
In-Reply-To: <20180330143051.26423-1-nsekhar@ti.com>
References: <20180330143051.26423-1-nsekhar@ti.com>
Message-ID: <20180402090100.28961677@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Mar 2018 20:00:51 +0530
Sekhar Nori <nsekhar@ti.com> wrote:

> NAND itself is an asynchronous interface, it does not have any
> clock input. DaVinci NAND driver acquires clock for AEMIF
> (asynchronous external memory interface) which is an on-chip
> IP to which NAND is connected.
> 
> The same clock is also enabled in AEMIF driver (either present
> drivers/memory or from machine code for some older platforms).
> AEMIF timing must be initialized before NAND can be accessed.
> This ensures that AEMIF clock is enabled too.
> 
> Remove the superfluous clock acquisition and enable in DaVinci
> NAND driver.
> 
> Tested on K2L, K2HK, K2E, DA850 EVM, DA850 LCDK in device-tree
> boot and DM644x EVM in legacy boot.
> 
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Hi Boris,
> 
> If/when this patch gets accepted,

I'll probably queue it just after v4.17-rc1 is out if nobody complains
about the change.

> it will nice to put this on
> an immutable branch others can merge. There is potential cleanup
> in drivers/clock and in DaVinci machine code that will depend
> on this.

Sure, I can do that. 

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
