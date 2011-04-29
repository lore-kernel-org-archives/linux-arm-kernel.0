From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 30 Apr 2011 08:51:54 +1000
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110429125613.616f977b@lxorguk.ukuu.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop> <201104291326.25634.arnd@arndb.de>
	<20110429125613.616f977b@lxorguk.ukuu.org.uk>
Message-ID: <1304117514.2513.266.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-04-29 at 12:56 +0100, Alan Cox wrote:
> > I believe that the PC graphics cards that have noncoherent DMA mappings
> > are all of the unified memory (integrated into the northbridge) kind,
> > so they are not on the same host bridge as all regular PCI devices,
> > even if they appear as a PCI device.
> 
> The AGP GART is not coherent on a lot of systems - not necessarily
> unified memory though, it can be a plug in AGP card too.
> The GART is basically an IOMMU (and indeed in the later AMD case used
> exactly as that)

Right. Actually there's also the ability for PCIe devices to set a "no
snoop" bit on transactions and thus behave in a non-coherent manner.
Hopefully most sane PHBs ignore that bit ...

Cheers,
Ben.
