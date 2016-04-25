From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 25 Apr 2016 12:52:41 -0500
Subject: [PATCHv2 0/7]  Add EDAC peripheral init functions & Ethernet EDAC
Message-ID: <1461606768-14404-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch set adds the memory initialization functions for Altera's
Arria10 peripherals, the first of which is the Ethernet EDAC. The
ECC memory init functions are common to all the peripheral memory
buffers.

Thor Thayer (7):
  EDAC, altera: Check parent status for Arria10 EDAC block
  EDAC, altera: Add panic flag check to A10 IRQ
  EDAC, altera: Move Arria10 IRQ function
  Documentation: dt: socfpga: Add Arria10 Ethernet binding
  EDAC, altera: Add Arria10 ECC memory init functions
  EDAC, altera: Add Arria10 Ethernet EDAC support
  ARM: dts: Add Arria10 Ethernet EDAC devicetree entry

 .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   36 ++
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/altera_edac.c                         |  373 ++++++++++++++++++--
 drivers/edac/altera_edac.h                         |   23 ++
 5 files changed, 443 insertions(+), 20 deletions(-)

-- 
1.7.9.5
