From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 30 Apr 2011 08:53:40 +1000
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <4DBAA9B4.3070306@vmware.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop> <201104291326.25634.arnd@arndb.de>
	<4DBAA9B4.3070306@vmware.com>
Message-ID: <1304117620.2513.268.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 14:06 +0200, Thomas Hellstrom wrote:
> I think Jerome has mentioned at one point that the Radeon graphics
> cards support non-coherent mappings.

If the card is PCI/PCI-X/PCIe then coherency is not its business, it's
the business of the host bridge. However, on PCIe at least, the card can
indeed set a "no snoop" attribute on DMA transactions to request "no
coherency". At least the systems have the latitude to just ignore that
bit (like we do on all ppc afaik) :-)

> Fwiw, the PowerVR SGX MMU also supports this mode of operation,
> although  it being functional I guess depends on the system
> implementation.

Right, it's not a GPU thing, it's really a system design thing.

Cheers,
Ben.
