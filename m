From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jun 2012 14:30:21 +0000
Subject: RF231 transceiver on at91sam9g20ek board
In-Reply-To: <CAJmB2rBcRuNe0QfEGoJN1rQnRnr33gyE=nLt3Az=mGEWuR7mCg@mail.gmail.com>
References: <CAJmB2rDxv45OP4otn7rmQcpzCvLujKm0j9_OqNW6PoyHuarTLw@mail.gmail.com>
 <201206221834.41869.arnd@arndb.de>
 <CAJmB2rBcRuNe0QfEGoJN1rQnRnr33gyE=nLt3Az=mGEWuR7mCg@mail.gmail.com>
Message-ID: <201206281430.21916.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 June 2012, Alexander Smirnov wrote:
> >
> > It might not be the problem you are faced with but note that at91
> > is moving towards probing all devices using the device tree, so
> > starting with linux-3.4 you should be defining the device in the
> > at91sam9g20ek.dts file for your board and use the generic
> > board-dt.c file. The platform_data gets replaced with
> > calls to of_get_gpio() in that case.
> 
> Thank you for the reply!
> 
> Are you going to add SPI section to the device tree in the nearest
> future or I can do it by myself and send you the patch? The reason is
> that this week I merged at86rf230 driver to the 'net-next' tree, but
> it won't work without platform data.

Jean-Christophe or Nicolas might now what the status is for atmel-spi.
It seems like it would be trivial to just add the compatible string in
the atmel-spi driver, which would let us probe all of its child devices
using DT.

	Arnd
