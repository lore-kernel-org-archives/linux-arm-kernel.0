From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 16:33:26 -0400
Subject: [GIT PULL] ARM: mvebu: dove changes for v3.12
Message-ID: <20130814203326.GJ13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is the one with several dependencies.  Basically, Sebastian was
able to leverage all the other work this cycle (in mvebu and kirkwood)
to update and further convert dove.  Surprisingly, There are no merge
conflicts, just several dependencies, all within mvebu/*.

This has also spent some time in -next.

With any luck, this is the last of it for v3.12 :)

thx,

Jason.


The following changes since commit 57f1eafe6952ee3ebe5f16c850b497e3ca2b3d04:

  ARM: mvebu: link PCIe controllers to the MSI controller (2013-08-13 18:13:45 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dove-all-3.12

for you to fetch changes up to 8959f5ae29b6241befa953304cd0569226488c40:

  ARM: dove: remove legacy pcie and clock init (2013-08-14 13:03:00 +0000)

----------------------------------------------------------------
mvebu dove changes for v3.12

 - various PCI mvebu fixes and features
 - dove
    - init MBus, PCI, ethernet and clock via DT

Depends:
 - mvebu/boards
 - mvebu/drivers
 - mvebu/msi_mvebu
    - mvebu/msi_pci

----------------------------------------------------------------

Jason Cooper (3):
      Merge branch 'mvebu/mbus_dt' into mvebu/dove_pcie-mbus-dt
      Merge branch 'mvebu/msi_mvebu' into mvebu/dove_pcie-mbus-dt
      Merge branch 'mvebu/dove_pcie-mbus-dt' into for-next

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
