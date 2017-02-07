From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed,  8 Feb 2017 09:28:09 +1300
Subject: [PATCH v2 0/6] Updates for Marvell Switch SoCs
Message-ID: <20170207202815.20226-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shortly after I posted my last series I got access to a more recent
Marvell SDK which had some device tree support for the switch SoCs I'd
been wanting. It was still based on an older kernel but it was a huge
improvement over what came before.

Patch 1/6 is a typo I noticed after my initial series was applied.

Patch 2/6 is a bit of a cleanup. I did initially struggle with how to
access individual parts of the DFX block as well as retaining a handle on
the entire thing for the switch driver to use.

Patch 3/6 is a re-jig of the dtsi files which is needed by 5/6. This is
required because I need to use the coreclk label on a different node. It
also means I don't have to disable nodes for blocks that only exist on
the Armada-XP.

Patch 4/6, 5/6 and 6/6 are ported from the Marvell Linux kernel. I've tested
them on the hardware I have access to and things look pretty good.

Chris Packham (6):
  ARM: dts: Fix typo in armada-xp-98dx4251
    Changes in v2:
    - new
  ARM: dts: armada-xp-98dx3236: combine dfx server nodes
    Changes in v2:
    - none
  ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236
    Changes in v2:
    - Update root compatible strings in armada-xp-98dx3336.dtsi,
      armada-xp-98dx4251.dtsi, armada-xp-db-dxbc2.dts and
      armada-xp-db-xc3-24g4xg.dts
  ARM: mvebu: Add mv98dx3236-soc-id
    Changes in v2:
    - none
  ARM: dts: mvebu: Move mv98dx3236 clock bindings
    Changes in v2:
    - New. Split out from "clk: mvebu: Expand mv98dx3236-core-clock support"
  clk: mvebu: Expand mv98dx3236-core-clock support
    Changes in v2:
    - split dts updates into separate patch
    - add 98DX4251 specific support

 .../bindings/arm/marvell/mv98dx3236-soc-id.txt     |  14 ++
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
 .../bindings/clock/mvebu-gated-clock.txt           |  11 ++
 .../devicetree/bindings/net/marvell,prestera.txt   |  13 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 211 ++++++++++++++++-----
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |   2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   2 +-
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |  43 ++++-
 drivers/clk/mvebu/Makefile                         |   2 +-
 drivers/clk/mvebu/armada-xp.c                      |  13 --
 drivers/clk/mvebu/mv98dx3236.c                     | 180 ++++++++++++++++++
 13 files changed, 422 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
 create mode 100644 drivers/clk/mvebu/mv98dx3236.c

-- 
2.11.0.24.ge6920cf
