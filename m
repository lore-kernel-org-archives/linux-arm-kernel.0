From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 17:00:30 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.10
In-Reply-To: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1479200431-1765-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.10

for you to fetch changes up to 236f794e4463a6b53139702c1b609091f61a17ab:

  arm64: dts: ls2080a: Add TMU device tree support for LS2080A (2016-11-15 15:05:36 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.10:
 - Enable Thermal Monitoring Unit (TMU) for thermal management on
   LS1043A and LS2080A.
 - Add support for LS1046A SoC, which has similar peripherals as
   LS1043A but integrates 4 A72 cores.
 - Add two LS1046A based board support: LS1046A-QDS and LS1046A-RDB.

----------------------------------------------------------------
Hongtao Jia (2):
      arm64: dts: ls1043a: Add TMU device tree support for LS1043A
      arm64: dts: ls2080a: Add TMU device tree support for LS2080A

Mingkai Hu (2):
      arm64: dts: add QorIQ LS1046A SoC support
      arm64: dts: add LS1046A-RDB board support

Shaohui Xie (8):
      dt-bindings: fsl: Add LS1043A/LS1046A/LS2080A SoC compatible strings
      dt-bindings: fsl: add LS1043A/LS1046A/LS2080A compatible for SCFG and DCFG
      dt-bindings: i2c: adds two more nxp devices
      dt-bindings: qoriq-clock: add LS1043A/LS1046A/LS2080A compatible for clockgen
      dt-bindings: ahci-fsl-qoriq: updated for SoC ls1046a
      Documentation: DT: Add entry for QorIQ LS1046A-RDB board
      Documentation: DT: Add entry for QorIQ LS1046A-QDS board
      arm64: dts: add LS1046A-QDS board support

 Documentation/devicetree/bindings/arm/fsl.txt      |  34 +-
 .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |   2 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   3 +
 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  78 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  | 212 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 150 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 515 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 116 ++++-
 15 files changed, 1107 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
