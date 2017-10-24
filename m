From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Oct 2017 20:20:44 +0800
Subject: [GIT PULL 3/4] Freescale arm64 device tree updates for 4.15
In-Reply-To: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
References: <1508847645-9191-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1508847645-9191-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.15

for you to fetch changes up to e54b911fd859acfc2b00e03223aed7afdbd1a539:

  arm64: dts: update the DPAA QBMan nodes (2017-10-13 14:52:40 +0800)

----------------------------------------------------------------
Freescale arm64 device tree updates for 4.15:
 - Add GICv3 ITS node and PCIe devcies for LS1088A support.
 - Enable PCIe support for LS2088A SoC.
 - Add OP-TEE support for various Layerscape SoCs, LS1012A, LS1043A,
   LS1046A, LS1088A and LS208XA.
 - Update DPAA QBMan nodes to use constant defines in the interrupt
   description.
 - Add DSPI device to support SPI-NOR on LS1012A based boards.

----------------------------------------------------------------
Hou Zhiqiang (3):
      arm64: dts: ls2088a: add pcie support
      arm64: dts: ls1088a: add gicv3 ITS DT node
      arm64: dts: ls1088a: add PCIe controller DT nodes

Madalin Bucur (1):
      arm64: dts: update the DPAA QBMan nodes

Sumit Garg (1):
      arm64: dts: ls: Add optee node

Yuan Yao (3):
      arm64: dts: ls1012a: add the DTS node for DSPI support
      dt-bindings: spi: Add fsl,ls1012a-dspi compatible string
      dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  2 +
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  | 33 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 20 +++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 11 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     | 11 ++-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 88 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |  4 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  7 ++
 9 files changed, 173 insertions(+), 4 deletions(-)
