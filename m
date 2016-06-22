From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 22 Jun 2016 08:58:51 -0500
Subject: [PATCHv5 0/8] Add Ethernet EDAC & peripheral init functions
Message-ID: <1466603939-7526-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

This patch set adds the Ethernet EDAC and memory initialization functions
for Altera's Arria10 peripherals. The ECC memory init functions are common
to all the peripheral memory buffers (to follow in later patches).

Version 5 corrects a misunderstanding of the phandle name for the parent
node in the bindings and device tree.

Thor Thayer (8):
  EDAC, altera: Check parent status for Arria10 EDAC block
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
 drivers/edac/altera_edac.c                         |  329 +++++++++++++++++---
 drivers/edac/altera_edac.h                         |   12 +
 5 files changed, 350 insertions(+), 38 deletions(-)

-- 
1.7.9.5
