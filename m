From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 16 Mar 2010 08:09:35 +0200
Subject: [spi-devel-general] [PATCH 0/3] spi: driver for Cirrus EP93xx
	SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636853334B@AUSP01VMBX24.collaborationhost.net>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636853334B@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100316060935.GB12813@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 01:22:51PM -0500, H Hartley Sweeten wrote:
> On Monday, March 15, 2010 9:26 AM, Mika Westerberg wrote:
> > Hello,
> > 
> > This series provides SPI master controller driver implementation for
> > Cirrus Logic EP93xx controllers.
> > 
> > I've tested this on my TS-7260 board with SPI EEPROM (through at25 driver)
> > and with few SD/MMC cards that I own (through mmc_spi driver). Unfortunately
> > I don't have other SPI devices so if someone wants to try this, it would be
> > great (see [1] for example code that I used with MMC cards).
> > 
> > This series applies on top of Linus' 2.6.34-rc1.
> > 
> > Please review.
> > 
> > Thanks,
> > MW
> 
> Hello Mika,

Hi,

> I also have a SPI driver (originally from Bluewater Systems) that I have been
> sitting on.  Your's has the advantage of using interrupts and is already
> coded for 16-bit targets, mine is currently polled and only handles 8-bit
> targets.
> 
> Based on that I'll try to help you get yours merged instead.

That sounds good. Thanks!

> 
> I already responded to patch 2/3.  Overall it's fine I would just like
> the code moved a bit in the source files.  Please review the comments.
> 
> Patch 3/3 looks ok initially.  I think you are hindering the chip-select
> options but I will work that out when I go through the patch 1/3.
> 
> Patch 1/3 looks good for a start.  The only problem I see is your
> limitation to only using built-in gpio's for chipselects.

I'll wait a bit to get more review comments from different people and then
send updated series.

BTW: do you mean that we should support some external GPIO chips
or something like that also as chipselects? As far as I can understand
EP93xx chips don't have dedicated chipselects for SPI.

> I will try to get your patches merged into my tree this week and test
> them.  At that point I will provide more feedback and try to address
> the chipselect limitation.

Thanks.

Regards,
MW
