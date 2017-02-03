From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Fri,  3 Feb 2017 16:40:08 +1300
Subject: [PATCH 0/4] Updates for Marvell Switch SoCs
Message-ID: <20170203034012.29399-1-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shortly after I posted my last series I got access to a more recent
Marvell SDK which had some device tree support for the switch SoCs I'd
been wanting. It was still based on an older kernel but it was a huge
improvement over what came before.

Patch 1/4 is a bit of a cleanup. I did initially struggle with how to
access individual parts of the DFX block as well as retaining a handle on
the entire thing for the switch driver to use.

Patch 2/4 is a re-jig of the dtsi files which is needed by 4/4. This is
required because I need to use the coreclk label on a different node. It
also means I don't have to disable nodes for blocks that only exist on
the Armada-XP.

Patch 3/4 and 4/4 are ported from the Marvell Linux kernel. I've tested
them on the hardware I have access to and things look pretty good.

Chris Packham (4):
  ARM: dts: armada-xp-98dx3236: combine dfx server nodes
  ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236
  ARM: mvebu: Add mv98dx3236-soc-id
  clk: mvebu: Expand mv98dx3236-core-clock support

 .../bindings/arm/marvell/mv98dx3236-soc-id.txt     |  14 ++
 .../devicetree/bindings/clock/mvebu-core-clock.txt |   7 +
 .../bindings/clock/mvebu-gated-clock.txt           |  11 ++
 .../devicetree/bindings/net/marvell,prestera.txt   |  13 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 211 ++++++++++++++++-----
 arch/arm/mach-mvebu/mvebu-soc-id.c                 |  43 ++++-
 drivers/clk/mvebu/Makefile                         |   2 +-
 drivers/clk/mvebu/armada-xp.c                      |  13 --
 drivers/clk/mvebu/mv98dx3236.c                     | 144 ++++++++++++++
 9 files changed, 382 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/mv98dx3236-soc-id.txt
 create mode 100644 drivers/clk/mvebu/mv98dx3236.c

-- 
2.11.0.24.ge6920cf
