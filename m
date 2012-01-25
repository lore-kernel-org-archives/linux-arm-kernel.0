From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 08:45:33 +0000
Subject: Common clock API for i.MX
In-Reply-To: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
Message-ID: <20120125084533.GD1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 07:54:08PM -0600, Matt Sealey wrote:
> Hi Arnd/RMK/Sascha,
> 
> We're trying to bring up a good batch of drivers here for MX51 and
> EfikaMX systems and noticed that the released 3.2 kernel doesn't
> include the common clock stuff that all the other platforms seem to be
> using.

As far as I know, it still isn't ready (if it was, surely it would've
been merged?)

Grepping for clk_prepare() it looks like very few people have converted
over to this - it's just the AMBA stuff, a few bits of OMAP and MXS.
So even if the common clock stuff comes in, almost nothing will be able
to use it:

arch/arm/common/sa1111.c
arch/arm/common/timer-sp.c
arch/arm/mach-omap2/clock2xxx.c
arch/arm/mach-omap2/clock.h
arch/arm/mach-omap2/prcm.c
arch/arm/mach-omap2/clock2430_data.c
arch/arm/mach-omap2/clock2xxx.h
arch/arm/mach-omap2/clock2420_data.c
arch/arm/mach-mxs/clock-mx23.c
arch/arm/mach-mxs/clock.c
arch/arm/mach-mxs/timer.c
arch/arm/mach-mxs/system.c
arch/arm/mach-mxs/clock-mx28.c
arch/arm/mach-mxs/mach-mx28evk.c
arch/arm/kernel/smp_twd.c
drivers/gpio/gpio-pxa.c
drivers/tty/serial/amba-pl011.c
drivers/tty/serial/mxs-auart.c
drivers/tty/serial/amba-pl010.c
drivers/amba/bus.c
drivers/net/ethernet/freescale/fec.c
drivers/net/can/flexcan.c
drivers/video/omap2/dss/dsi.c
drivers/video/amba-clcd.c
drivers/video/mxsfb.c
drivers/staging/tidspbridge/include/dspbridge/clk.h
drivers/staging/tidspbridge/core/dsp-clock.c
drivers/spi/spi-pl022.c
drivers/mmc/host/mmci.c
drivers/mmc/host/mxs-mmc.c
drivers/dma/mxs-dma.c
drivers/mtd/nand/gpmi-nand/gpmi-lib.c

My conclusion, therefore, is that there's very little actual interest
amongst the ARM community to move towards a common clk API.

I'm rather disappointed by that, and have been wondering for some time
why I wasted my time over the clk_prepare() stuff, and wondering why the
hell I bothered putting it in mainline.  I must have been under the
mistaken impression that this is something people wanted.  Obviously not.

There's a good saying here: actions speak louder than words.  The action
here is the lack of patches from platform maintainers.  That definitely
shouts.

As a result of the lack of motivation by others over this, I've lost
interest in it.  Sorry.
