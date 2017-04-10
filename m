From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 22:37:55 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.12
In-Reply-To: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1491835076-1995-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.12

for you to fetch changes up to 6678254bb4a46dc47620f993a4b71480a3c56ee4:

  dt-bindings: arm: Add entry for FSL LS1088A RDB, QDS boards (2017-04-04 20:57:27 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.12:
 - Add support of LS2088A SoC, which is a derivative of existing
   LS2080A SoC, and the major difference is on ARM cores.
 - Add support of LS1088A SoC which includes eight Cortex-A53 cores
   with 32 KB L1 D-cache and I-cache respectively.
 - Add crypto and thermal device support for LS1012A platform.
 - Add ECC register region for SATA device on LS1012A, LS1043A and
   LS1046A platforms.

----------------------------------------------------------------
Abhimanyu Saini (3):
      dt-bindings: Add compatible for LS2088A QDS and RDB board
      arm64: dts: freescale: ls2080a: Split devicetree for code resuability
      arm64: dts: freescale: ls2088a: Add DTS support for FSL's LS2088A SoC

Harninder Rai (3):
      arm64: dts: Add support for FSL's LS1088A SoC
      dt-bindings: clockgen: Add compatible string for LS1088A
      dt-bindings: arm: Add entry for FSL LS1088A RDB, QDS boards

Horia Geant? (1):
      arm64: dts: ls1012a: add crypto node

Tang Yuantian (2):
      arm64: dts: added ecc register address to sata node on ls1043a
      arm64: dts: added ecc register address to sata node on ls1046a

Yuantian Tang (2):
      arm64: dts: updated sata node on ls1012a platform
      arm64: dts: ls1012a: add thermal monitor node

 Documentation/devicetree/bindings/arm/fsl.txt      |  23 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  |   4 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 182 ++++-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 123 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  | 107 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 275 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  | 155 +---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  | 110 +--
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 863 +++------------------
 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts  |  64 ++
 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts  |  64 ++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     | 165 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi | 196 +++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi | 151 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     | 737 ++++++++++++++++++
 21 files changed, 2206 insertions(+), 1034 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
