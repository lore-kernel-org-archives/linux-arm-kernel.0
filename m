From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon,  7 Aug 2017 13:46:37 +1200
Subject: [RESEND PATCH 0/4] EDAC: support reduce bus width on 98dx3236
Message-ID: <20170807014641.4003-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(sorry I messed up sending this earlier, there is one additional patch and I'll
actually include the linux-arm and linux-edac mailing lists)

This series applies on top of Jan Lubbe's "EDAC drivers for Armada XP L2 and
DDR" series[1]. 1/4, 2/4 and 3/4 don't strictly depend on Jan's work so they
could go in through the ARM tree if that is preferred.

The 98dx3236 and similar switch chips with integrated CPUs have fewer pins
available for the SDRAM interface so the definition of "full" and "half" is
different to the Armada-XP SoC. In this series I introduce a
"marvell,reduced-width" device tree property and use this to identify such a
system.

I chose to use a new property instead of a new compatible string because the IP
block really is the Armada-XP one (at least according to the Marvell FAE I
spoke to) and because the scenario of requiring a reduced pin-count when going
from an external SoC to an integrated one will be reasonably common as we see
more an more of these switches with integrated ARM cores.


[1] - http://marc.info/?l=linux-edac&m=150167758312924

Chris Packham (4):
  ARM: dts: enable L2 cache parity and ecc on db-xc3-24g4xg board
  dt-bindings: add "reduced-width" property for Armada XP SDRAM
    controller
  ARM: dts: mvebu: set reduced-width property for SDRAM on 98dx3236
  EDAC: add support for reduced-width Armada-XP SDRAM

 .../bindings/memory-controllers/mvebu-sdram-controller.txt          | 6 ++++++
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                           | 1 +
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts                       | 5 +++++
 drivers/edac/armada_xp_edac.c                                       | 3 +++
 4 files changed, 15 insertions(+)

-- 
2.13.0
