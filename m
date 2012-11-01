From: zonque@gmail.com (Daniel Mack)
Date: Thu,  1 Nov 2012 19:36:06 +0100
Subject: [PATCH v2 0/4] RFC: OMAP GPMC DT bindings
Message-ID: <1351794970-14675-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of patches to support GPMC peripherals on OMAP boards.

Depends on Linus' master +
omap-next (branch omap-for-v3.8/cleanup-headers-gpmc)

The only supported peripheral for now is NAND, but other types would be
easy to add.

Version 2 addresses details pointed out by Jon Hunter, Afzal Mohammed
and Rob Herring:

 - add "reg" and "ti,hwmod" properties to Documentation
 - use generic of_mtd functions and the property names defined by them,
   namely "nand-bus-width" and "nand-ecc-mode"
 - reduce the default register space size in the Documentation to 8K,
   as found in the hwmod code
 - switch to a DT layout based on ranges and address translation.
   Although this property is not currently looked at as long as the
   handling code still uses the runtime calculation methods, we now
   have these values in the bindings, eventually allowing us to
   switch the implementation with less pain.

Thanks,
Daniel

Daniel Mack (4):
  mtd: omap-nand: pass device_node in platform data
  ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
  ARM: OMAP: gpmc: don't create devices from initcall on DT
  ARM: OMAP: gpmc: add DT bindings for GPMC timings and NAND

 Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  73 +++++++++++
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  61 +++++++++
 arch/arm/mach-omap2/gpmc-nand.c                    |   2 +-
 arch/arm/mach-omap2/gpmc.c                         | 146 +++++++++++++++++++++
 drivers/mtd/nand/omap2.c                           |   4 +-
 include/linux/platform_data/mtd-nand-omap2.h       |   2 +
 6 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt

-- 
1.7.11.7
