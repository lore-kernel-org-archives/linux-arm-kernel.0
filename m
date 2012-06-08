From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 8 Jun 2012 16:35:48 +0200
Subject: mach/io.h cleanup and removal question
In-Reply-To: <4FD207C9.5010006@gmail.com>
References: <20120608102040.GA26034@lunn.ch>
 <20120608114316.GC15555@n2100.arm.linux.org.uk>
 <4FD207C9.5010006@gmail.com>
Message-ID: <20120608143548.GC26034@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Probably shrinking ORION5X_PCIE_IO_SIZE to 64K, unless we really have a
> > requirement to support a larger IO space.
> 
> Agreed. The next step is moving all i/o space to a fixed virtual address
> and for this we want to make i/o windows 64K.

O.K. I will submit a patch for this, so Orion5x at least boots. Maybe
PCI will not work, but booting is a step forward.

> However, I think you may also have a problem with
> ORION5X_PCIE_IO_BUS_BASE and the resource start. The i/o resource start
> should really be 0 and then the __io() macro should add the virtual i/o
> base address. However, Russell has mentioned previously that some chips
> may not work correctly with i/o space at 0 (PCI bus addresses, not host).
> 
> Do you have cards with i/o that you can test or know what devices are
> used with this platform?

Humm, not sure. I have a Marvell Orion5x NAS reference design. It has
a Mini-PCI slot on the bottom. So if i can find a card, i can test. I
know i have some WiFi cards in my junk box, but i've no idea if these
have i/o.

     Andrew
