From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 23:14:28 +0100
Subject: [PATCH 0/3] s/FOOTBRIDGE/ARCH_FOOTBRIDGE/
In-Reply-To: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404247026-379-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140701221428.GC32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 10:37:03PM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> I'm not sure that FOOTBRIDGE and ARCH_FOOTBRIDGE are semantically
> identical; if not, feel free to nack this series.

CONFIG_FOOTBRIDGE means that we have a DC21285 in the system.  We
used to have ARCH_FOOTBRIDGE and ARCH_CO285 which both selected
CONFIG_FOOTBRIDGE.

ARCH_FOOTBRIDGE was for either host or addin mode using a PAGE_OFFSET
of 0xc0000000.  ARCH_CO285 had a PAGE_OFFSET of 0x80000000 as they
wanted to be able to map almost all of PCI memory space.

So think of CONFIG_FOOTBRIDGE as meaning that we have the physical
device, and CONFIG_ARCH_FOOTBRIDGE meaning that we want to support
boards with the device on.

So, it may make sense to rename CONFIG_FOOTBRIDGE to CONFIG_DC21285
if that makes the configuration symbol intention clearer.

This is why I prefer even hidden symbols to have a help text - having
the help text explains why they exist...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
