From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 May 2012 12:49:07 -0400 (EDT)
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205161528.27318.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205161200.59362.arnd@arndb.de>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A581@IL-MB01.marvell.com>
 <201205161528.27318.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1205161246080.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 May 2012, Arnd Bergmann wrote:

> On Wednesday 16 May 2012, Lior Amsalem wrote:
> > > 
> > > Thanks for the list, very helpful!
> > > 
> > > So do you think it makes sense to put all of these into mach-orion?
> > >
> > Well, Orion is old and seems like not the best name for a directory to include 
> > all the new platforms.
> > We are discussing it internally as well and I'll update with our suggestion.
> 
> The name has the advantage that we have a bunch of drivers using it already:
> 
> arch/arm/plat-orion/gpio.c
> arch/arm/plat-orion/irq.c
> arch/arm/plat-orion/mpp.c
> arch/arm/plat-orion/pcie.c
> arch/arm/plat-orion/time.c
> drivers/mtd/nand/orion_nand.c
> drivers/spi/spi-orion.c
> drivers/usb/host/ehci-orion.c
> drivers/watchdog/orion_wdt.c
> 
> AFAICT, those are shared between most of those socs, and I would not want
> to change the code in them to the new name.

Why not?  Module aliases can be used if that is a concern.

> If we change the directory
> name to something completely different, it no longer matches the driver
> names.

I wouldn't consider this as a major concern.  For example, the ethernet 
driver that all those SOCs use is not called "orion".


Nicolas
