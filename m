From: tony@atomide.com (Tony Lindgren)
Date: Tue, 02 Feb 2010 18:25:51 -0800
Subject: [PATCH 0/9] omap fixes for 2.6.33-rc6
Message-ID: <20100203022318.26347.34734.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Kevin Hilman (2):
      OMAP2/3: IRQ: ensure valid base address
      OMAP2/3: GPMC: ensure valid clock pointer

Marek Skuczynski (1):
      omap: Fix access to already released memory in clk_debugfs_register_one()

Sriram (1):
      ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP

Tony Lindgren (4):
      omap: Remove old unused defines for OMAP_32KSYNCT_BASE
      omap: Fix 3630 mux errors
      omap: Fix arch/arm/mach-omap2/mux.c: Off by one error
      omap: Disable serial port autoidle by default

Uwe Kleine-K?nig (1):
      omap: define _toggle_gpio_edge_triggering only for OMAP1


 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-omap2/gpmc.c       |    5 +++-
 arch/arm/mach-omap2/irq.c        |    4 ++-
 arch/arm/mach-omap2/mux.c        |   10 +++++++-
 arch/arm/mach-omap2/mux34xx.c    |   47 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/serial.c     |    8 ++++++
 arch/arm/plat-omap/clock.c       |    4 ++-
 arch/arm/plat-omap/gpio.c        |    4 ++-
 arch/arm/plat-omap/omap_device.c |   10 --------
 9 files changed, 75 insertions(+), 18 deletions(-)

-- 
Signature
