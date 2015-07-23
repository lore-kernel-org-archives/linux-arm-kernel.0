From: marex@denx.de (Marek Vasut)
Date: Thu, 23 Jul 2015 09:00:50 +0200
Subject: [PATCH v2 1/5] mtd: spi-nor: notify (Q)SPI controller about
 protocol change
In-Reply-To: <55AFC3F0.5050002@atmel.com>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com>
 <201507221541.46135.marex@denx.de> <55AFC3F0.5050002@atmel.com>
Message-ID: <201507230900.50570.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 22, 2015 at 06:25:20 PM, Cyrille Pitchen wrote:
> Hi Marek,
> 
> Le 22/07/2015 15:41, Marek Vasut a ?crit :
> > On Wednesday, July 22, 2015 at 03:17:06 PM, Cyrille Pitchen wrote:
> >> Once the Quad SPI mode has been enabled on a Micron flash memory, this
> >> device expects ALL the following commands to use the SPI 4-4-4 protocol.
> >> The (Q)SPI controller needs to be notified about the protocol change so
> >> it can adapt and keep on dialoging with the Micron memory.
> >> 
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> >> ---
> >> 
> >>  drivers/mtd/spi-nor/spi-nor.c | 17 +++++++++++++++++
> >>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
> >>  2 files changed, 30 insertions(+)
> >> 
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c
> >> b/drivers/mtd/spi-nor/spi-nor.c index d78831b4422b..93627d4e6be8 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -163,6 +163,18 @@ static inline int write_disable(struct spi_nor
> >> *nor)
> >> 
> >>  	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
> >>  
> >>  }
> >> 
> >> +/*
> >> + * Notify the (Q)SPI controller about the new protocol to be used.
> > 
> > Hi!
> > 
> > Can you please just reword this a little, so that it is absolutelly clear
> > even to the less bright of us (like me) that this is a notification
> > coming from the upper layers (ie. the spi-nor framework) toward the
> > hardware ?
> 
> Sure, no problem! what about the following?
> 
> /*
>  * Let the spi-nor framework notify lower layers, especially the driver of
> the * (Q)SPI controller, about the new protocol to be used. Indeed, once
> the * spi-nor framework has sent manufacturer specific commands to a
> memory to * enable its Quad SPI mode, it should immediately after tell the
> QSPI * controller to use the very same Quad SPI protocol as expected by
> the memory. */

Sure, excellent, thanks ! :-)
