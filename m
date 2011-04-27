From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 28 Apr 2011 07:41:07 +1000
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427202603.GY17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104271302.44249.arnd@arndb.de>
	<20110427201605.GW17290@n2100.arm.linux.org.uk>
	<201104272221.48601.arnd@arndb.de>
	<20110427202603.GY17290@n2100.arm.linux.org.uk>
Message-ID: <1303940467.2513.188.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> As I said above, I don't think bus code can do it.  Take my example
> above of a tulip pci device on x86 and a tulip pci device on ARM.  Both
> use the same PCI code.
> 
> Maybe something in asm/pci.h - but that invites having lots of bus
> specific header files in asm/.
> 
> A better solution imho would be to have an architecture callback for
> struct device which gets registered, which can inspect the type of
> the device, and set the flag depending on where it appears in the
> tree.

Now -that's gross :-)

For PCI you can have the flag propagate from the PHB down, for busses
without a bus type (platform) then whoever instanciate them (the
platform code) can set that appropriately.

Ben.
