From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:48:06 +0000
Subject: [PATCH V4 0/5] arm64: imx: add imx8qxp support
Message-ID: <1541864596-15958-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp mek basic support with the function
Lpuart
uSDHC
FEC
GPIO

ChangeLog:
v4:
 * change to new power domain binding suggested by Ulf
 * Note below patches were merged separetely by each SS maintainer,
   so dropped in this seris
   dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp compatible string
   dt-bindings: i2c: i2c-imx-lpi2c: add imx8qxp compatible string
   dt-bindings: spi: lpspi: add imx8qxp compatible string

Dong Aisheng (5):
  dt-bindings: serial: lpuart: add imx8qxp compatible string
  arm64: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp support
  arm64: dts: imx: add imx8qxp mek support
  defconfig: arm64: add imx8qxp support

 Documentation/devicetree/bindings/arm/fsl.txt      |   8 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 arch/arm64/Kconfig.platforms                       |  22 ++
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi       |  61 +++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      | 137 +++++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         | 409 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   6 +
 8 files changed, 646 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ca35.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi

-- 
2.7.4
