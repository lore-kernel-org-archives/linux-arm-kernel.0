From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 17:26:37 +0100
Subject: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
In-Reply-To: <20140702071312.GO14781@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140701221428.GC32514@n2100.arm.linux.org.uk>
 <20140702071312.GO14781@pengutronix.de>
Message-ID: <20140702162636.GP32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 09:13:12AM +0200, Uwe Kleine-K?nig wrote:
> I expected something like that. Is it possible to "have" the device on a
> cpu != StrongARM? If so I wonder why ARCH_FOOTBRIDGE is a "ARM system
> type". And if not, wouldn't it be possible and better to have all
> platforms which select CPU_SA110 (ARCH_EBSA110, ARCH_FOOTBRIDGE; what
> about RPC?) in a single mach dir and make FOOTBRIDGE an option there?
> 
> It's hard to find information on the net about these chips, even
> http://developer.intel.com/design/strong/sa110.htm only talks about x86
> stuff only, so please excuse my unknowingness.

The Footbridge is a companion device to the StrongARM - the two are
designed to work together.  It probably is possible that the Footbridge
could have been connected to another CPU with appropriate interfacing,
but that never happened.

The thing to realise is that the Footbridge is a little more than just
a pure PCI bridge.  It's also the SDRAM controller, UART port and
provides support for a non-PCI expansion bus.

Probably the best model which represents it is in actual fact the x86
PC in years gone by.  The separate processor (StrongARM) with the PCI
northbridge (Footbridge) which couples the processor to the rest of
the system.  Some Footbridge systems really do approximate the x86
PC with a southbridge attached (eg, Netwinder did this, with a real
southbridge providing keyboard, mouse, bridge to the ISA bus, IDE etc).

You could also think of it as an early SoC which hasn't quite integrated
the CPU, as the Footbridge defines quite a lot about how the physical
system memory map looks.

The difference between the CO285 and the EBSA285 is that CO285 was
exclusively add-in mode (in other words, CO285 was Linux running on
a DC21285 based card you could plug into your PC and wanted to map
large spaces of PCI memory space) whereas the EBSA285 was the much
smaller end of the add-in mode, and also host mode (StrongARM being
responsible for PCI configuration etc.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
