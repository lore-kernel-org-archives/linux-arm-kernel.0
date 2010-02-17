From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2010 20:31:14 +0000
Subject: PL-330 DMA driver
In-Reply-To: <63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
References: <1b68c6791002162150wb8fbae8ya1e5b3c0a56b7fad@mail.gmail.com>
	<63386a3d1002171026h51f34d4buc9ba0293ea08c004@mail.gmail.com>
Message-ID: <20100217203114.GC30033@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2010 at 07:26:00PM +0100, Linus Walleij wrote:
> 2010/2/17 jassi brar <jassisinghbrar@gmail.com>:
> 
> > Could maintainers please suggest what is the best place for the PL330
> > controller driver?
> 
> drivers/dma/amba-pl033.c would be my bet.
> 
> I have patches to support MMCI (PL180/PL181) using the generic DMA
> engine pending, I will attempt to submit patches for spi/amba-pl022.c and
> serial/amba-pl011.c when I get the time.

One of the problems with the DMA engine APIs are that the data needed to
setup the non-device side is opaque - in other words, it's specific to
the DMA engine being used.

This means primecell drivers can't define this data; they don't know what
kind of DMA engine will be used - and I'm not sure passing it in from
the platform side of things makes much sense either.

Unless... we define a base structure for DMA engines used with primecell
peripherals...
