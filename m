From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jun 2014 19:58:01 +0200
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <20140610154118.GA4254@lukather>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
 <20140610154118.GA4254@lukather>
Message-ID: <11151546.Z6056AoQxM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 June 2014 17:41:18 Maxime Ripard wrote:
> > +DMA clients connected to the Atmel XDMA controller must use the format
> > +described in the dma.txt file, using a three-cell specifier for each channel:
> > +a phandle plus two integer cells.
> > +The three cells in order are:
> > +
> > +1. A phandle pointing to the DMA controller.
> > +2. The memory interface (16 most significant bits), the peripheral interface
> > +(16 less significant bits).
> 
> Can you elaborate on this? What are they? The request IDs on both ends
> of the transfers?
> 
> > +3. Channel configuration register. Configurable fields are:
> > +  - bit 2-1: MBSIZE, memory burst size.
> > +  - bit 10-8: CSIZE, chunk size.
> > +  - bit 12-11: DWIDTH, data width.
> 
> I'd rather see those as generic properties.

Actually these are standard settings that a slave driver
configures using dma_slave_config. They don't belong into
DT at all, as they are slave driver specific.

	Arnd
