From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Fri, 21 Apr 2017 11:52:33 +0800
Subject: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
 ls1012a/ls1046a/ls208xa
Message-ID: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add eSDHC UHS-I/HS200 mode support for ls1012a/ls1046a/ls208xa.
Because eSDHC is not a standard SD controller, the specific speed mode support
depends on board's peripheral circuit for eSDHC. So, we have to add these speed
modes support on board dts file.

In additon, these dts patches depends on esdhc driver patches which just had been merged
on mmc.git. Otherwise, the UHS-I SD card and eMMC HS200 card would fail to be initialized,
but other cards still could work fine.
https://patchwork.kernel.org/patch/9689875/
https://patchwork.kernel.org/patch/9689877/
https://patchwork.kernel.org/patch/9689879/
https://patchwork.kernel.org/patch/9689887/
https://patchwork.kernel.org/patch/9689885/

Yangbo Lu (3):
  arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
  arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC HS200 on QDS
  arm64: dts: ls1012a: add eSDHC nodes

 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  8 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 13 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 25 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  8 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  2 +-
 8 files changed, 62 insertions(+), 3 deletions(-)

-- 
2.1.0.27.g96db324
