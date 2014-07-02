From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Jul 2014 09:13:12 +0200
Subject: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
In-Reply-To: <20140701221428.GC32514@n2100.arm.linux.org.uk>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140701221428.GC32514@n2100.arm.linux.org.uk>
Message-ID: <20140702071312.GO14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Jul 01, 2014 at 11:14:28PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 10:37:03PM +0200, Uwe Kleine-K?nig wrote:
> > I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
> > identical; if not, feel free to nack this series.
> 
> CONFIG_FOOTBRIDGE means that we have a DC21285 in the system.  We
> used to have ARCH_FOOTBRIDGE and ARCH_CO285 which both selected
> CONFIG_FOOTBRIDGE.
> 
> ARCH_FOOTBRIDGE was for either host or addin mode using a PAGE_OFFSET
> of 0xc0000000.  ARCH_CO285 had a PAGE_OFFSET of 0x80000000 as they
> wanted to be able to map almost all of PCI memory space.
> 
> So think of CONFIG_FOOTBRIDGE as meaning that we have the physical
> device, and CONFIG_ARCH_FOOTBRIDGE meaning that we want to support
> boards with the device on.
I expected something like that. Is it possible to "have" the device on a
cpu != StrongARM? If so I wonder why ARCH_FOOTBRIDGE is a "ARM system
type". And if not, wouldn't it be possible and better to have all
platforms which select CPU_SA110 (ARCH_EBSA110, ARCH_FOOTBRIDGE; what
about RPC?) in a single mach dir and make FOOTBRIDGE an option there?

It's hard to find information on the net about these chips, even
http://developer.intel.com/design/strong/sa110.htm only talks about x86
stuff only, so please excuse my unknowingness.
 
> So, it may make sense to rename CONFIG_FOOTBRIDGE to CONFIG_DC21285
> if that makes the configuration symbol intention clearer.
Maybe even better CONFIG_HAS_DC21285?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
