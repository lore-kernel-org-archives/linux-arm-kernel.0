From: tony@atomide.com (Tony Lindgren)
Date: Mon, 08 Oct 2012 10:35:52 -0700
Subject: [PATCH 0/2] omap plat/cpu.h removal for v3.8 merge window
Message-ID: <20121008173452.10603.53886.stgit@muffinssi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These two patches for v3.8 merge window make plat/cpu.h local
to mach-omap1 and mach-omap2.

We'll have to keep plat/cpu.h around until the merge window
so drivers are fixed, but after that it can be removed.

These patches are based on current linux next with the
following patches:

- [PATCH 00/16] More omap plat header cleanup for v3.8 merge window

- [PATCH V2 0/7] ARM: OMAP: Move plat/dma*.h,omap-secure.h headers as part of single zImage work

- [PATCH v2 1/5] [media] omap3isp: Fix compilation error in ispreg.h
  ...
  [PATCH v2 5/5] arm: omap: Move iopgtable header to drivers/iommu/

- [PATCH 0/6] ARM: OMAP: remove clock files in arch/arm/plat-omap

Regards,

Tony


---

Tony Lindgren (2):
      ARM: OMAP: Trivial driver changes to remove include plat/cpu.h
      ARM: OMAP: Split plat/cpu.h into local soc.h for mach-omap1 and mach-omap2


 arch/arm/mach-omap1/clock.c                 |    2 
 arch/arm/mach-omap1/clock_data.c            |    2 
 arch/arm/mach-omap1/i2c.c                   |    2 
 arch/arm/mach-omap1/id.c                    |    2 
 arch/arm/mach-omap1/include/mach/hardware.h |    2 
 arch/arm/mach-omap1/include/mach/memory.h   |    2 
 arch/arm/mach-omap1/irq.c                   |    2 
 arch/arm/mach-omap1/mcbsp.c                 |    2 
 arch/arm/mach-omap1/soc.h                   |  229 +++++++++++
 arch/arm/mach-omap2/board-3430sdp.c         |    1 
 arch/arm/mach-omap2/board-flash.c           |    2 
 arch/arm/mach-omap2/board-omap3beagle.c     |    1 
 arch/arm/mach-omap2/board-omap3evm.c        |    1 
 arch/arm/mach-omap2/board-zoom-display.c    |    1 
 arch/arm/mach-omap2/clock33xx_data.c        |    2 
 arch/arm/mach-omap2/clockdomain.c           |    1 
 arch/arm/mach-omap2/clockdomain.h           |    1 
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c  |    2 
 arch/arm/mach-omap2/clockdomains2420_data.c |    1 
 arch/arm/mach-omap2/clockdomains2430_data.c |    1 
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    1 
 arch/arm/mach-omap2/common.h                |    1 
 arch/arm/mach-omap2/display.c               |    1 
 arch/arm/mach-omap2/dma.c                   |    1 
 arch/arm/mach-omap2/gpmc.c                  |    1 
 arch/arm/mach-omap2/hsmmc.c                 |    1 
 arch/arm/mach-omap2/i2c.c                   |    1 
 arch/arm/mach-omap2/mux.c                   |    1 
 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |    1 
 arch/arm/mach-omap2/omap_hwmod.h            |    1 
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c  |    1 
 arch/arm/mach-omap2/omap_twl.c              |    1 
 arch/arm/mach-omap2/opp3xxx_data.c          |    1 
 arch/arm/mach-omap2/pm-debug.c              |    1 
 arch/arm/mach-omap2/pm.c                    |    1 
 arch/arm/mach-omap2/pm24xx.c                |    1 
 arch/arm/mach-omap2/pm34xx.c                |    1 
 arch/arm/mach-omap2/pm44xx.c                |    1 
 arch/arm/mach-omap2/pmu.c                   |    1 
 arch/arm/mach-omap2/powerdomain.h           |    2 
 arch/arm/mach-omap2/powerdomains2xxx_data.c |    1 
 arch/arm/mach-omap2/prcm.c                  |    1 
 arch/arm/mach-omap2/serial.c                |    1 
 arch/arm/mach-omap2/soc.h                   |  468 ++++++++++++++++++++++
 arch/arm/mach-omap2/sr_device.c             |    2 
 arch/arm/mach-omap2/usb-host.c              |    1 
 arch/arm/mach-omap2/usb-musb.c              |    3 
 arch/arm/plat-omap/dma.c                    |    4 
 arch/arm/plat-omap/i2c.c                    |    4 
 arch/arm/plat-omap/include/plat/cpu.h       |  562 ---------------------------
 arch/arm/plat-omap/sram.c                   |    3 
 drivers/char/hw_random/omap-rng.c           |    2 
 drivers/crypto/omap-aes.c                   |    6 
 drivers/crypto/omap-sham.c                  |    8 
 drivers/dma/omap-dma.c                      |    9 
 drivers/mmc/host/omap_hsmmc.c               |    1 
 sound/soc/omap/omap-pcm.c                   |    9 
 57 files changed, 763 insertions(+), 602 deletions(-)
 create mode 100644 arch/arm/mach-omap1/soc.h

-- 
Signature
