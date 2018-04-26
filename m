From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 26 Apr 2018 20:01:08 +0200
Subject: [PATCH] mtd: nand: davinci: don't acquire and enable clock
In-Reply-To: <20180330143051.26423-1-nsekhar@ti.com>
References: <20180330143051.26423-1-nsekhar@ti.com>
Message-ID: <20180426200108.2afb375c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

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
> If/when this patch gets accepted, it will nice to put this on
> an immutable branch others can merge. There is potential cleanup
> in drivers/clock and in DaVinci machine code that will depend
> on this.

I prepared the nand/davinci-clock tag for you to fetch if needed. I'll
merge it into the nand/next branch soon.

Thanks,

Boris 

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mtd.git tags/nand/davinci-clock

for you to fetch changes up to a8e3923ab57192547ffad01d78939c5c0d5d0c30:

  mtd: rawnand: davinci: don't acquire and enable clock (2018-04-26 19:55:40 +0200)

----------------------------------------------------------------
Prepare things for davinci clk driver cleanup

----------------------------------------------------------------
Sekhar Nori (1):
      mtd: rawnand: davinci: don't acquire and enable clock

 drivers/mtd/nand/raw/davinci_nand.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)
