From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Fri, 27 Apr 2018 13:37:15 -0500
Subject: [PATCHv2 0/3] Add SDRAM ECC support for Stratix10 
Message-ID: <1524854238-19394-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The Intel Stratix10 platform is an ARM64 but still has many register
definitions that are similar to the Arria10. One significant difference
is the Stratix10 Secure Monitor handles registers that may
be shared by guest OSes at a different exception level. Register access
is through an ARM SMC call. Currently, SMC handling is implemented
in Stratix10 U-Boot.

Thor Thayer (3):
  Documentation: dt: socfpga: Add Stratix10 ECC Manager binding
  edac: altera: Add support for Stratix10 SDRAM EDAC
  arm64: dts: stratix10: add sdram ecc

 .../bindings/arm/altera/socfpga-eccmgr.txt         |  35 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  12 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/altera_edac.c                         | 455 ++++++++++++++++++++-
 drivers/edac/altera_edac.h                         | 126 +++++-
 5 files changed, 602 insertions(+), 28 deletions(-)

-- 
2.7.4
