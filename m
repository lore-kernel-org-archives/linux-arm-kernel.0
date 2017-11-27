From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 18:38:12 +0000
Subject: [PATCH 0/6] StrongARM SA1111 Companion cleanups
Message-ID: <20171127183811.GM31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series removes some cruft from the SA1111 support, some of which
is blocking other work:

1. Remove the unused "shutdown" method
2. Remove the legacy bus "suspend" and "resume" methods (for work
   by Rafael).
3. Remove now unused sa1111_readl() and sa1111_writel() accessors,
   converting remaining to more appropriate accessors.
4. Remove a bunch of unused definitions.
5. Convert to use IRQ domains for interrupts.
6. Use IRQ domain to map hardware interrupt numbers to Linux IRQ
   numbers.

I'm intending to merge this work via my tree shared with arm-soc if
desired, as being the last known sa11x0 platform maintainer, so acks
would be appreciated.

 arch/arm/common/sa1111.c               | 328 ++++++++++++++++-----------------
 arch/arm/include/asm/hardware/sa1111.h |  32 +---
 2 files changed, 165 insertions(+), 195 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
