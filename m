From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Dec 2013 15:53:41 +0100
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1386740489.7152.288.camel@host5.omatika.ru>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <201312110611.46443.arnd@arndb.de>
 <1386740489.7152.288.camel@host5.omatika.ru>
Message-ID: <201312111553.42076.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 December 2013, Sergei Ianovich wrote:
> On Wed, 2013-12-11 at 06:11 +0100, Arnd Bergmann wrote:
> > It depends: if the driver is for the entire FPGA and does
> > the irqchip stuff in addition, it should probably live
> > in drivers/mfd. If it's a pure irqchip driver, drivers/irqchip
> > is better. You have to be careful in the second case though
> > because devices pointing to this irqchip in DT won't get
> > an IRQ resource assigned automatically but have to use
> > irq_of_parse_and_map instead. This may have been fixed since
> > I last looked though, I would consider that behavior a
> > bug in the of_platform handling.
> 
> Thanks again for explaining.
> 
> Although FPGA is a MFD, its irq are used mostly by 8250 serial ports. It
> will be enough to embed irqchip into serial driver for now.
> 
> If there is a need to use the chip in another driver, it will be
> possible to introduce an artificial dependency there for the serial
> driver to ensure the serial driver is loaded before the other one.
> 
> Is this plan acceptable?
> 

If you already have an MFD driver, I think it's more logical to put
the irqchip in there, we have a number of other MFD drivers doing the
same but I have not seen a UART driver that comes with its own irqchip.

	Arnd
