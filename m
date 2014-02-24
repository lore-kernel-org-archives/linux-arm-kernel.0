From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Feb 2014 15:53:51 -0500
Subject: [PATCH 0/4] ARM: mm: Use dma-ranges for dma address translation
Message-ID: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the RFC [1] comments and suggestions from Olof, Arnd, here is the
patchset tries to make use of dma-ranges property for dma address translations.
We add dma_pfn_offset to ARM archdata which can be updated per platform device
using a callback like dma-coherent callbacks.

I would like to get the fix for the problem in kernel sooner so appriciate
early feedback. 

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Grygorii Strashko <grygorii.strashko@ti.com>

Grygorii Strashko (4):
  ARM: mm: Introduce archdata.dma_pfn_offset
  ARM: mm: Remove unsed dma_to_virt()
  ARM: dts: keystone: Use dma-ranges property
  ARM: keystone: Use dma-ranges for dma_pfn_offset configuration

 arch/arm/boot/dts/keystone.dtsi             |    1 +
 arch/arm/include/asm/device.h               |    1 +
 arch/arm/include/asm/dma-mapping.h          |   25 ++++-----
 arch/arm/mach-iop13xx/include/mach/memory.h |   11 ----
 arch/arm/mach-keystone/keystone.c           |   76 +++++++++++++++++++++++++--
 arch/arm/mach-ks8695/include/mach/memory.h  |    2 -
 arch/arm/mach-omap1/include/mach/memory.h   |    4 --
 7 files changed, 86 insertions(+), 34 deletions(-)

Regards,
Santosh
[1] http://www.spinics.net/lists/arm-kernel/msg304555.html
-- 
1.7.9.5
