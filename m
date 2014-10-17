From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Fri, 17 Oct 2014 15:33:44 -0500
Subject: [PATCHv2 0/4] Add Altera peripheral memories to EDAC framework
Message-ID: <1413578029-13205-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch adds the L2 cache and OCRAM peripherals to the EDAC framework
using the EDAC device framework. The ECC is enabled early in the boot
process in the platform specific code.

Thor Thayer (4):
  arm: socfpga: Enable L2 Cache ECC on startup.
  arm: socfpga: Enable OCRAM ECC on startup.
  edac: altera: Add Altera L2 Cache and OCRAM EDAC Support
  arm: dts: Add Altera L2 Cache and OCRAM EDAC

 .../bindings/arm/altera/socfpga-l2-edac.txt        |   15 ++
 .../bindings/arm/altera/socfpga-ocram-edac.txt     |   16 ++
 MAINTAINERS                                        |    4 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   15 +-
 arch/arm/mach-socfpga/Makefile                     |    2 +
 arch/arm/mach-socfpga/l2_cache.c                   |   44 ++++
 arch/arm/mach-socfpga/l2_cache.h                   |   28 +++
 arch/arm/mach-socfpga/ocram.c                      |   90 +++++++
 arch/arm/mach-socfpga/ocram.h                      |   28 +++
 arch/arm/mach-socfpga/socfpga.c                    |   13 +-
 drivers/edac/Kconfig                               |   14 ++
 drivers/edac/Makefile                              |    3 +
 drivers/edac/altera_edac_mgr.c                     |  261 ++++++++++++++++++++
 drivers/edac/altera_edac_mgr.h                     |   56 +++++
 drivers/edac/altera_l2_edac.c                      |  130 ++++++++++
 drivers/edac/altera_ocram_edac.c                   |  107 ++++++++
 16 files changed, 823 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-l2-edac.txt
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-ocram-edac.txt
 create mode 100644 arch/arm/mach-socfpga/l2_cache.c
 create mode 100644 arch/arm/mach-socfpga/l2_cache.h
 create mode 100644 arch/arm/mach-socfpga/ocram.c
 create mode 100644 arch/arm/mach-socfpga/ocram.h
 create mode 100644 drivers/edac/altera_edac_mgr.c
 create mode 100644 drivers/edac/altera_edac_mgr.h
 create mode 100644 drivers/edac/altera_l2_edac.c
 create mode 100644 drivers/edac/altera_ocram_edac.c

-- 
1.7.9.5
