From: atull@opensource.altera.com (Alan Tull)
Date: Thu, 28 May 2015 16:19:35 -0500
Subject: [PATCHv5 0/2] socfpga: support suspend to ram
Message-ID: <1432847977-18880-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support suspend to ram on socfpga.
  * allocate space in ocram using sram driver.
  * Add a function in ocram to place DDR in self-refresh
    and suspend.
  * Prevent suspend if EDAC is enabled.
  * Add a device tree binding document for the Altera
    SOCFPGA SDRAM controller that is used to put DDR in
    self-refresh mode.

Alan Tull (2):
  ARM: socfpga: support suspend to ram
  ARM: socfpga: dts: add sdram controller dt binding doc

 .../arm/altera/socfpga-sdram-controller.txt        |   12 ++
 arch/arm/mach-socfpga/Kconfig                      |   10 +-
 arch/arm/mach-socfpga/Makefile                     |    1 +
 arch/arm/mach-socfpga/core.h                       |    6 +-
 arch/arm/mach-socfpga/pm.c                         |  149 ++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S               |  136 ++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c                    |    6 +-
 drivers/edac/altera_edac.c                         |   20 +++
 8 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

-- 
1.7.9.5
