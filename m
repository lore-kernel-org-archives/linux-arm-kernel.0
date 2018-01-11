From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 11 Jan 2018 14:59:00 +1300
Subject: [PATCH v2 0/3] ARM: mvebu: dts: updates to enable EDAC
Message-ID: <20180111015903.11322-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've split this off from my earlier series[1] this is just the dts changes that
will enable support for the EDAC series when it lands.

The Armada 38x as well as the 98dx3236 and similar switch chips with integrated
CPUs use the same SDRAM controller block as the Armada XP. The key difference
is the width of the DDR interface.

[1] - https://marc.info/?l=linux-kernel&m=151545124505964&w=2

Changes in v2:
- update commit message
- add labels to dts

Chris Packham (3):
  ARM: dts: armada-xp: enable L2 cache parity and ecc on db-xc3-24g4xg
  ARM: dts: armada-xp: add label to sdram-controller node
  ARM: dts: mvebu: add sdram controller node to Armada-38x

 arch/arm/boot/dts/armada-38x.dtsi             | 5 +++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 5 +++++
 arch/arm/boot/dts/armada-xp.dtsi              | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.15.1
