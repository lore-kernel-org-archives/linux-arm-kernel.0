From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Sep 2013 12:27:47 -0400
Subject: [GIT PULL] ARM: mvebu: dt changes for v3.13
Message-ID: <20130930162747.GH31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Same as mvebu/drivers, these are the changes that missed the last
window.  All have been in -next since v3.12-rc1 without a problem.

thx,

Jason.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.13

for you to fetch changes up to 37078732998e51c2645db99e7434ccc6774dafed:

  ARM: dove: add initial DT file for Globalscale D3Plug (2013-09-30 15:00:54 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.13

 - mvebu
    - add MSI
    - new compatible string for mv64xxx-i2c

 - dove
    - use the pre-processor
    - define the MBus nodes
    - add PCIe controllers
    - add Globalscale D3Plug
    - relocate internal registers nodes

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: dts: mvebu: Update with the new compatible string for mv64xxx-i2c

Sebastian Hesselbarth (6):
      ARM: dove: use preprocessor on device tree files
      ARM: dove: add MBUS_ID macro to Dove DT
      ARM: dove: add MBus DT node
      ARM: dove: relocate internal registers device nodes
      ARM: dove: add PCIe controllers to SoC DT
      ARM: dove: add initial DT file for Globalscale D3Plug

Thomas Petazzoni (2):
      ARM: mvebu: the MPIC now provides MSI controller features
      ARM: mvebu: link PCIe controllers to the MSI controller

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/armada-370-xp.dtsi     |    3 +-
 arch/arm/boot/dts/armada-370.dtsi        |    9 +
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |    1 +
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |    1 +
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |    1 +
 arch/arm/boot/dts/armada-xp.dtsi         |   10 +
 arch/arm/boot/dts/dove-cm-a510.dts       |    2 +-
 arch/arm/boot/dts/dove-cubox.dts         |    2 +-
 arch/arm/boot/dts/dove-d2plug.dts        |    2 +-
 arch/arm/boot/dts/dove-d3plug.dts        |  103 +++
 arch/arm/boot/dts/dove-dove-db.dts       |    2 +-
 arch/arm/boot/dts/dove.dtsi              | 1009 ++++++++++++++++--------------
 13 files changed, 670 insertions(+), 476 deletions(-)
 create mode 100644 arch/arm/boot/dts/dove-d3plug.dts
