From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue,  9 Jan 2018 11:31:55 +1300
Subject: [PATCH 0/3] EDAC: support for Armada 38x and 98dx3236 SoCs
Message-ID: <20180108223158.21930-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series applies on top of Jan Lubbe's "EDAC drivers for Armada XP L2 and
DDR" series[1].

The Armada 38x as well as the 98dx3236 and similar switch chips with integrated
CPUs use the same SDRAM controller block as the Armada XP. The key difference
is the width of the DDR interface.

[1] - https://marc.info/?l=linux-edac&m=151030475715706&w=2

Chris Packham (3):
  ARM: dts: enable L2 cache parity and ecc on db-xc3-24g4xg board
  ARM: dts: mvebu: add sdram controller node to Armada-38x
  EDAC: armada_xp: Add support for more SoCs

 arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 drivers/edac/armada_xp_edac.c                 | 5 +++++
 3 files changed, 15 insertions(+)

-- 
2.15.1
