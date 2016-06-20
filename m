From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Mon, 20 Jun 2016 09:50:45 -0500
Subject: [PATCHv4 0/7] Add Ethernet EDAC & peripheral init functions
Message-ID: <1466434252-26107-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch set adds the Ethernet EDAC and memory initialization functions
for Altera's Arria10 peripherals. The ECC memory init functions are common
to all the peripheral memory buffers (to follow in later patches).

Thor Thayer (7):
  EDAC, altera: Add panic flag check to A10 IRQ
  EDAC, altera: Make all private data structures static const.
  EDAC, altera: Share Arria10 check_deps & IRQ functions
  Documentation: dt: socfpga: Add Arria10 Ethernet binding
  EDAC, altera: Add Arria10 ECC memory init functions
  EDAC, altera: Add Arria10 Ethernet EDAC support
  ARM: dts: Add Arria10 Ethernet EDAC devicetree entry

 .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   16 +
 drivers/edac/Kconfig                               |    7 +
 drivers/edac/altera_edac.c                         |  312 +++++++++++++++++---
 drivers/edac/altera_edac.h                         |   12 +
 5 files changed, 333 insertions(+), 38 deletions(-)

-- 
1.7.9.5
