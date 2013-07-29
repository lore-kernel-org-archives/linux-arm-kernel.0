From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Jul 2013 14:31:49 +0200
Subject: [PATCH 0/5] ARM: dove: switch to DT MBus
Message-ID: <1375101114-28858-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set converts DT based Dove boards to DT probed MBus to be
introduced with v3.12.

The first two patches prepare Dove DT nodes for MBus ID remapping by using
preprocessor includes and adding the MBUS_ID macro. The third patch adds a
MBus DT node to Dove SoC dtsi with required ranges for internal MBus and
AXI registers, and PCIe mem and I/O apertures. The forth patch relocates
the nodes for the internal devices to the new MBus node. Also, internal-regs
ranges are updated to allow proper translation of MBus children's reg
properties. Finally, legacy MBus init is replaced by DT based MBus init
for DT based Dove.

The patch set depends on the MBus device tree patches that should appear
in v3.12. Currently, it is based on v3.11-rc2 with Dove DT cleanup patches
and MBus patch set v8 applied.

The patch set is _not_ sent to devicetree mainling list, because the MBus
binding will be discussed there on the MBus patches itself.

Sebastian Hesselbarth (5):
  ARM: dove: use preprocessor on device tree files
  ARM: dove: add MBUS_ID macro to Dove DT
  ARM: dove: add MBus DT node
  ARM: dove: relocate internal registers device nodes
  ARM: dove: switch to DT probed mbus address windows

 arch/arm/boot/dts/dove-cm-a510.dts |    2 +-
 arch/arm/boot/dts/dove-cubox.dts   |    2 +-
 arch/arm/boot/dts/dove-d2plug.dts  |    2 +-
 arch/arm/boot/dts/dove-dove-db.dts |    2 +-
 arch/arm/boot/dts/dove.dtsi        |  958 ++++++++++++++++++------------------
 arch/arm/mach-dove/board-dt.c      |   10 +-
 6 files changed, 491 insertions(+), 485 deletions(-)

---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.10.4
