From: zonque@gmail.com (Daniel Mack)
Date: Mon, 22 Oct 2012 21:55:54 +0200
Subject: [PATCH 0/4] RFC: OMAP GPMC bindings
Message-ID: <1350935758-9215-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of patches to support GPMC peripherals on OMAP boards.

Depends on Linus' master +
omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)

The only supported peripheral for now is NAND, but other types would be
easy to add.

In order to make the gpmc driver the 'hub' for all sub-nodes, I had to
add some includes. I'm not particularily happy about the fact that there
are mutual references from gpmc.c to gpmc-nand.c now, but that was the
easiest way.

I successfully tested these patches on an AM33xx board to make NAND
work.

Comments welcome!


Thanks,
Daniel


Daniel Mack (4):
  mtd: omap-nand: pass device_node in platform data
  ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
  ARM: OMAP: gpmc: don't create devices from initcall on DT
  OMAP: mtd: gpmc: add DT bindings for GPMC timings and NAND

 Documentation/devicetree/bindings/bus/gpmc.txt     |  59 +++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  65 +++++++++
 arch/arm/mach-omap2/gpmc-nand.c                    |   2 +-
 arch/arm/mach-omap2/gpmc.c                         | 146 +++++++++++++++++++++
 drivers/mtd/nand/omap2.c                           |   4 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   2 +
 6 files changed, 276 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

-- 
1.7.11.7
