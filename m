From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Thu, 4 May 2017 18:48:55 +0800
Subject: [v2,
 0/5] Add eSDHC UHS-I/HS200 mode support for ls1012a/ls1046a/ls208xa
Message-ID: <1493894940-47452-1-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to add eSDHC UHS-I/HS200 mode support for ls1012a/ls1046a/ls208xa.
Also add eSDHC node for ls1088a. Because eSDHC is not a standard SD controller,
the specific speed mode support depends on board's peripheral circuit for eSDHC.
So, we have to add these speed modes support on board dts file.

In additon, these dts patches depends on esdhc driver patches which just had been merged
on mmc.git. Otherwise, the UHS-I SD card and eMMC HS200 card would fail to be initialized,
but other cards still could work fine.
https://patchwork.kernel.org/patch/9689875/
https://patchwork.kernel.org/patch/9689877/
https://patchwork.kernel.org/patch/9689879/
https://patchwork.kernel.org/patch/9689887/
https://patchwork.kernel.org/patch/9689885/

Yangbo Lu (5):
  mmc: dt: add compatible into eSDHC required properties
  arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
  arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC HS200 on QDS
  arm64: dts: ls1012a: add eSDHC nodes
  arm64: dts: ls1088a: add esdhc node

 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  8 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 13 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 25 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  8 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 12 +++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |  4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  2 +-
 12 files changed, 83 insertions(+), 3 deletions(-)

-- 
2.1.0.27.g96db324
