From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 30 Aug 2013 16:54:02 -0400
Subject: [GIT PULL V2] ARM: mvebu: dove changes for v3.12
In-Reply-To: <20130814203326.GJ13964@titan.lakedaemon.net>
References: <20130814203326.GJ13964@titan.lakedaemon.net>
Message-ID: <20130830205402.GX19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Sending V2 based on the new mvebu/msi_mvebu (rebased onto
mvebu/drivers).

thx,

Jason.


The following changes since commit 9f494449cc34b1896e38c1e7da3a774d072ade8f:

  Merge branch 'mvebu/msi_mvebu' into mvebu/dove_pcie-mbus-dt (2013-08-30 20:29:27 +0000)

are available in the git repository at:


  git://git.infradead.org/linux-mvebu.git tags/dove-all-3.12

for you to fetch changes up to 8e6397a5ce592ba0dfed29c708654e96888c0068:

  ARM: dove: remove legacy pcie and clock init (2013-08-30 20:31:51 +0000)

----------------------------------------------------------------
mvebu dove changes for v3.12

 - various PCI mvebu fixes and features
 - dove
    - init MBus, PCI, ethernet and clock via DT

V2:
 - mvebu/msi_mvebu was rebased onto mvebu/drivers to resolve conflicts
   internally.  This branch is rebased on that work.

Depends:
 - mvebu/boards
 - mvebu/msi_mvebu
    - mvebu/msi_pci
    - mvebu/drivers

----------------------------------------------------------------
Sebastian Hesselbarth (13):
      PCI: mvebu: move clock enable before register access
      PCI: mvebu: increment nports only for registered ports
      PCI: mvebu: remove subsys_initcall
      PCI: mvebu: add support for reset on GPIO
      PCI: mvebu: add support for Marvell Dove SoCs
      ARM: dove: use preprocessor on device tree files
      ARM: dove: add MBUS_ID macro to Dove DT
      ARM: dove: add MBus DT node
      ARM: dove: relocate internal registers device nodes
      ARM: dove: switch to DT probed mbus address windows
      ARM: dove: add PCIe controllers to SoC DT
      ARM: dove: add initial DT file for Globalscale D3Plug
      ARM: dove: remove legacy pcie and clock init

 .../devicetree/bindings/pci/mvebu-pci.txt          |    7 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/dove-cm-a510.dts                 |    2 +-
 arch/arm/boot/dts/dove-cubox.dts                   |    2 +-
 arch/arm/boot/dts/dove-d2plug.dts                  |    2 +-
 arch/arm/boot/dts/dove-d3plug.dts                  |  103 ++
 arch/arm/boot/dts/dove-dove-db.dts                 |    2 +-
 arch/arm/boot/dts/dove.dtsi                        | 1009 +++++++++++---------
 arch/arm/mach-dove/board-dt.c                      |   39 +-
 drivers/pci/host/Kconfig                           |    2 +-
 drivers/pci/host/pci-mvebu.c                       |   99 +-
 11 files changed, 719 insertions(+), 549 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-d3plug.dts
