From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2011 22:17:27 +0200
Subject: [PATCH 4/7] tty: serial: support device tree in pxa
In-Reply-To: <20110719200515.GB308@n2100.arm.linux.org.uk>
References: <20110719194010.GI6848@ponder.secretlab.ca>
	<CACxGe6u1Pq990opdt7irttuY1OvpZVNXSM11cLdqo5zN8YpYeg@mail.gmail.com>
	<20110719200515.GB308@n2100.arm.linux.org.uk>
Message-ID: <2932110.niB1oCsTtu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 July 2011 21:05:15 Russell King - ARM Linux wrote:
> On Tue, Jul 19, 2011 at 01:53:53PM -0600, Grant Likely wrote:
> > On Tue, Jul 19, 2011 at 1:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > Right. We should probably rename of_serial to 8250_of and remove the qpace
> > > parts from the driver.
> > 
> > In fact, I think we've got about 3 devtree drivers for 8250 serial
> > ports.  I think it is about time for some consolidation work.  :-)
> > 
> > I wonder if we can roll of_serial directly into the 8250.c driver.
> 
> The original serial.c got split into 8250.c, plus several probe modules
> (8250_pnp.c, 8250_pci.c, etc) to get around the problem of lots of
> bus specific crap appearing in the main driver.  8250_of.c would follow
> on that theme.

Yes. Going even further, I'd actually like to pull the ISA bits and the
platform driver out of the 8250.c file as well. While it would be
possible to combine the platform driver with the of driver, I don't
think that's too useful in case of 8250 because the two actually
look quite different.

	Arnd
