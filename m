From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Aug 2011 15:21:24 +0200
Subject: [PATCH 00/10] Clean up some io.h and associated code
In-Reply-To: <20110821083744.GB12028@n2100.arm.linux.org.uk>
References: <20110817075104.GC1006@n2100.arm.linux.org.uk>
	<201108181714.47464.arnd@arndb.de>
	<20110821083744.GB12028@n2100.arm.linux.org.uk>
Message-ID: <9736370.N3v9K0B2fU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 August 2011 09:37:44 Russell King - ARM Linux wrote:
> > I did some research during the Cambourne meeting about of these
> > and found that the omap1 and a91 platforms also need the IO_SPACE_LIMIT
> > defined to 0xffffffff when CONFIG_AT91_CF or CONFIG_OMAP_CF are
> > set, so these fall into the same category as CONFIG_PCMCIA_SOC_COMMON.
> 
> It looks like AT91 and OMAP both only support one socket CF, so it
> probably makes sense to have them converted to use a single 64k window.

If I read arch/arm/mach-at91/at91sam9260_devices.c correctly,
it actually supports two CF slots. However, each slot only
has 2KB worth of I/O space there, so it would still be reasonable
to pretend having 64KB of total space and map the two slots
at 4KB and 8KB offset into that.

	Arnd
