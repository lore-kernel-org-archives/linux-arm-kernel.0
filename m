From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 May 2012 13:52:53 +0100
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <4FB39C62.3030305@antcom.de>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <4FB39C62.3030305@antcom.de>
Message-ID: <20120516125253.GD9571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 02:24:02PM +0200, Roland Stigge wrote:
> After applying series 1-6 (as well as with 1-7), my just posted LPC32xx
> NAND drivers have problems mounting the MTD (basically, NAND page reads,
> DMA dev to mem from NAND controller internal buffers).
> 
> * SLC driver says:
> 
> lpc32xx-nand 20020000.flash: FIFO not empty!
> lpc32xx-nand 20020000.flash: FIFO held data too long
> lpc32xx-nand 20020000.flash: DMA FIFO failure
> 
> * MLC driver just gets bad data resulting in detected bad blocks.
> 
> Without the patches, they work as tested.
> 
> Any hints, before I find the time to sort out all the details with
> amba-pl08x?

Nothing jumps out; it would be useful if you could bisect the small
series - I did the conversion in small steps so it should be easy to
track down.  And it shouldn't take too long to rebuild between each
iteration.  Whatever it is, it's probably going to be a stupid mistake
somewhere.
