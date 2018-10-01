From: shawnguo@kernel.org (Shawn Guo)
Date: Mon,  1 Oct 2018 15:20:02 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.20
In-Reply-To: <20181001072003.16238-1-shawnguo@kernel.org>
References: <20181001072003.16238-1-shawnguo@kernel.org>
Message-ID: <20181001072003.16238-4-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.20

for you to fetch changes up to b739c177e1aeab532f355493439a1901b85be38c:

  arm64: dts: fsl: Fix I2C and SPI bus warnings (2018-09-26 17:01:53 +0800)

----------------------------------------------------------------
Freescale arm64 device tree update for 4.20:
 - Add the second Dual UART device for LS208xA SoCs.
 - Add necessary big-endian property for NOR device on LS104xA based
   boards, remove unneeded big-endian property from IFC controller.
 - DTC has new checks for I2C and SPI buses to land into 4.20.  A patch
   from Rob to fix the bus node names and warnings in unit-addresses.

----------------------------------------------------------------
Kurt Kanzenbach (1):
      arm64: dts: ls208xa: add second duart

Prabhakar Kushwaha (2):
      arm64: dts: Add big-endian in nor node for ls104xa
      arm64: dts: fsl: remove big-endian field from IFC controller

Rob Herring (1):
      arm64: dts: fsl: Fix I2C and SPI bus warnings

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts |  2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts |  2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts |  2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi    |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi    | 20 ++++++++++++++++++--
 8 files changed, 34 insertions(+), 12 deletions(-)
