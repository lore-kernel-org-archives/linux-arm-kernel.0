From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Jun 2017 23:55:22 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.13
In-Reply-To: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1497801323-6389-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.13

for you to fetch changes up to 375b6755a5b1836699d00c47f689d63bd1e40b95:

  arm64: dts: ls1088a: update sata node (2017-06-14 22:42:42 +0800)

----------------------------------------------------------------
The Freescale arm64 device tree updates for 4.13:
 - A series from NXP employee Li Yang that updates the copyright claims
   to comply with company policy.
 - A patch-set from Madalin Bucur that adds Data Path Acceleration
   Architecture (DPAA) QBMan and FMan.  Quite a few .dtsi files are
   created for SoCs with different DPAA configuration to include the
   devices as needed.
 - Enable UHS-I SD and eMMC support for LS1046A and LS208xA RDB/QDS
   boards.
 - Enable TMU device for thermal management support on LS1088A.
 - Update SATA device node for LS1088A with correct compatible and ECC
   register bit.
 - A few small random device tree updates.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      arm64: dts: ls1043a: Add generic compatible string for I2C EEPROM

Li Yang (1):
      arm64: dts: freescale: update the copyright claims

Madalin Bucur (6):
      arm64: dts: add DPAA QBMan portals
      arm64: dts: add LS1043A DPAA QBMan nodes
      arm64: dts: add LS1046A DPAA QBMan nodes
      arm64: dts: add DPAA FMan nodes
      arm64: dts: add LS1043A DPAA FMan support
      arm64: dts: add LS1046A DPAA FMan nodes

Prabhakar Kushwaha (2):
      arm64: dts: Define big endian of IFC for LS1043a/LS1046a
      arm64: dts: Add flash node for ls1088a qds and rdb

Ran Wang (1):
      arm64: dts: ls1046a: Add dis_rxdet_inp3_quirk property to USB3 node

Scott Wood (1):
      arm64: dts: ls1012a: Add coreclk

Yangbo Lu (5):
      mmc: dt: add compatible into eSDHC required properties
      arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
      arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC HS200 on QDS
      arm64: dts: ls1012a: add eSDHC nodes
      arm64: dts: ls1088a: add esdhc node

Yuantian Tang (4):
      arm64: dts: ls1088a: update the sata node
      arm64: dts: ls1088a: Add TMU device tree support
      dt-bindings: ahci-fsl-qoriq: add ls1088a chip name to the list
      arm64: dts: ls1088a: update sata node

yinbo.zhu (1):
      arm64: dts: ls208xa: disable SD UHS-I modes by default on RDB

 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |   2 +-
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  14 +++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  10 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |  15 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  39 +++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi |  45 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |  79 ++++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  69 ++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi |  48 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  70 ++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  75 +++++++++++++-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |  28 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  20 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 111 +++++++++++++++++++--
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts  |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   5 +-
 .../boot/dts/freescale/qoriq-bman-portals.dtsi     |  71 +++++++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  42 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  42 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  41 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  41 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  41 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  41 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  41 ++++++++
 .../boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  41 ++++++++
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi   |  81 +++++++++++++++
 .../boot/dts/freescale/qoriq-qman-portals.dtsi     |  80 +++++++++++++++
 38 files changed, 1192 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046-post.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
