From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Fri, 7 Nov 2014 10:54:17 -0600
Subject: [PATCHv4 0/5] Add Altera peripheral memories to EDAC framework
Message-ID: <1415379263-12391-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch adds the L2 cache and OCRAM peripherals to the EDAC framework
using the EDAC device framework. The ECC is enabled early in the boot
process in the platform specific code.

v2 changes:
- Split On-Chip RAM ECC platform initialization into separate patch from
  L2 ECC platform initialization.
- Fix L2 cache dependency comments.
- Remove OCRAM node from dts and reference prior patch.

v3 changes:
- Move L2 cache & On-Chip RAM EDAC code into altera_edac.c
- Remove SDRAM module compile.

v4 changes:
- Change mask defines to use BIT().
- Fix comment style to agree with kernel coding style.
- Better printk description for read != write in trigger.
- Remove SysFS debugging message.
- Better dci->mod_name
- Move gen_pool pointer assignment to end of function.
- Invert logic to reduce indent in ocram depenency check.
- Change from dev_err() to edac_printk()
- Replace magic numbers with defines & comments.
- Improve error injection test.
- Change Makefile intermediary name to altr (from alt)

Thor Thayer (5):
  arm: socfpga: Enable L2 Cache ECC on startup.
  arm: socfpga: Enable OCRAM ECC on startup.
  edac: altera: Remove SDRAM module compile
  edac: altera: Add Altera L2 Cache and OCRAM EDAC Support
  arm: dts: Add Altera L2 Cache and OCRAM EDAC

 .../bindings/arm/altera/socfpga-l2-edac.txt        |   15 +
 .../bindings/arm/altera/socfpga-ocram-edac.txt     |   16 +
 MAINTAINERS                                        |    2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   15 +-
 arch/arm/mach-socfpga/Makefile                     |    2 +
 arch/arm/mach-socfpga/l2_cache.c                   |   44 ++
 arch/arm/mach-socfpga/l2_cache.h                   |   28 ++
 arch/arm/mach-socfpga/ocram.c                      |   90 ++++
 arch/arm/mach-socfpga/ocram.h                      |   28 ++
 arch/arm/mach-socfpga/socfpga.c                    |   13 +-
 drivers/edac/Kconfig                               |   18 +-
 drivers/edac/Makefile                              |    5 +-
 drivers/edac/altera_edac.c                         |  481 +++++++++++++++++++-
 13 files changed, 751 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt
 create mode 100644 arch/arm/mach-socfpga/l2_cache.c
 create mode 100644 arch/arm/mach-socfpga/l2_cache.h
 create mode 100644 arch/arm/mach-socfpga/ocram.c
 create mode 100644 arch/arm/mach-socfpga/ocram.h

-- 
1.7.9.5
