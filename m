From: atull@opensource.altera.com (Alan Tull)
Date: Fri, 22 May 2015 13:02:13 -0500
Subject: [PATCH v4 0/2] socfpga: support suspend to ram
Message-ID: <1432317735-29413-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support suspend to ram on socfpga.
  * allocate space in ocram using sram driver.
  * Add a function in ocram to place DDR in self-refresh
    and suspend.
  * SDRAM ECC is mutually exclusive with using ocram for
    suspend, so disable SDRAM ECC if socfpga suspend is
    enabled.
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
 arch/arm/mach-socfpga/pm.c                         |  150 +++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S               |  157 ++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c                    |    6 +-
 drivers/edac/Kconfig                               |    2 +-
 8 files changed, 340 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdram-controller.txt
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

-- 
1.7.9.5
