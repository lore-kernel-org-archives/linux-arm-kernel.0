From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  8 Jun 2017 16:11:20 +1200
Subject: [RFC PATCH 0/4] EDAC support for Marvell Armada SoCs
Message-ID: <20170608041124.4624-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a basic EDAC driver for the memory controller and L2 cache
on the Marvell Armada SoCs. My test platform uses armada-xp-98dx3236 so I've
included some patches for that also.

I'm still chasing Marvell for some more info on how to inject errors, hence
the RFC.

Chris Packham (4):
  EDAC: mvebu: Add driver for Marvell Armada SoCs
  ARM: l2x0: support parity-enable/disable on aurora
  ARM: l2x0: add arm,ecc-enable property for aurora
  ARM: dts: enable l2c parity and ecc protection on 98dx3236

 Documentation/devicetree/bindings/arm/l2c2x0.txt |   2 +
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi        |   2 +
 arch/arm/mm/cache-l2x0.c                         |  14 +
 drivers/edac/Kconfig                             |   7 +
 drivers/edac/Makefile                            |   1 +
 drivers/edac/mvebu_edac.c                        | 506 +++++++++++++++++++++++
 drivers/edac/mvebu_edac.h                        |  66 +++
 7 files changed, 598 insertions(+)
 create mode 100644 drivers/edac/mvebu_edac.c
 create mode 100644 drivers/edac/mvebu_edac.h

-- 
2.13.0
