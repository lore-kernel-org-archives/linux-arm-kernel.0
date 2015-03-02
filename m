From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 17:05:38 +0000
Subject: [PATCH 00/10] initial clkdev cleanups
Message-ID: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's some initial clkdev cleanups.  These are targetted for the next
merge window, and while the initial patches can be merged independently,
I'd prefer to keep the series together as further work on solving the
problems which unique struct clk's has introduced is needed.

The initial cleanups are more about using the correct clkdev function
than anything else: there's no point interating over a array of
clk_lookup structs, adding each one in turn when we have had a function
which does this since forever.

I'm also killing a chunk of seemingly unused code in the omap3isp driver.

Lastly, I'm introducing a clkdev_create() helper, which combines the
clkdev_alloc() + clkdev_add() pattern which keeps cropping up.

Individual patches copied to appropriate people, but they will all appear
on the mailing lists.

 arch/arm/mach-lpc32xx/clock.c                |  5 +--
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c | 12 ++-----
 arch/arm/mach-omap2/omap_device.c            | 24 +++++--------
 arch/arm/plat-orion/common.c                 |  6 +---
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c       |  3 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c       |  4 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c       |  4 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c       |  4 +--
 arch/sh/kernel/cpu/sh4a/clock-shx3.c         |  4 +--
 drivers/clk/clk-s2mps11.c                    |  4 +--
 drivers/clk/clkdev.c                         | 52 +++++++++++++++++++++-------
 drivers/clk/versatile/clk-impd1.c            |  4 +--
 drivers/media/platform/omap3isp/isp.c        | 18 ----------
 drivers/media/platform/omap3isp/isp.h        |  1 -
 include/linux/clkdev.h                       |  3 ++
 include/media/omap3isp.h                     |  6 ----
 sound/soc/sh/migor.c                         |  3 +-
 17 files changed, 68 insertions(+), 89 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
