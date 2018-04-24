From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 24 Apr 2018 13:35:56 -0500
Subject: [PATCH 0/3] Add SDRAM ECC support for Stratix10
Message-ID: <1524594959-5259-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The Intel Stratix10 platform is an ARM64 but still has many register
definitions that are similar to the Arria10. One significant difference
is the Stratix10 hypervisor which requires handling registers that may
be shared by guest OSes at a different exception level. Register access
is through an ARM SMC call. Currently, SMC handling is implemented
in U-Boot.

Thor Thayer (3):
  Documentation: dt: socfpga: Add Stratix10 ECC Manager binding
  edac: altera: Add support for Stratix10 SDRAM EDAC
  arm64: dts: stratix10: add sdram ecc

 .../bindings/arm/altera/socfpga-eccmgr.txt         |  47 +++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  17 +
 drivers/edac/Kconfig                               |   2 +-
 drivers/edac/altera_edac.c                         | 459 +++++++++++++++++++++
 drivers/edac/altera_edac.h                         | 114 +++++
 5 files changed, 638 insertions(+), 1 deletion(-)

-- 
2.7.4
