From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 14 Nov 2013 14:02:06 -0700
Subject: [PATCH 0/8] imx6 dts cleanup series
Message-ID: <1384462934-17390-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a cleanup series. Only patch 8 adds new functionality,
dualLite support for the sabrelite board.

patches 1-6 can be applied in any order
patch 7 depends on patches 4,5
patch 8 depends on patch 3


Troy Kisky (8):
  ARM: dts: imx: pinfunc: add MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT
  ARM: dts: imx: imx6qdl.dtsi: add mipi_csi tag
  ARM: dts: imx: imx6sl/qdl-pingrp: reorganize USDHCx pad groups
  ARM: dts: imx: imx6q.dtsi: use IRQ_TYPE_LEVEL_HIGH
  ARM: dts: imx: imx6dl.dtsi: use IRQ_TYPE_LEVEL_HIGH
  ARM: dts: imx: imx6sl.dtsi: use IRQ_TYPE_LEVEL_HIGH
  ARM: dts: imx: imx6qdl.dtsi: use IRQ_TYPE_LEVEL_HIGH
  ARM: dts: imx: sabrelite: add dualLite support

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx6dl-pinfunc.h         |   1 +
 arch/arm/boot/dts/imx6dl-sabrelite.dts     |  20 +++
 arch/arm/boot/dts/imx6dl.dtsi              |   9 +-
 arch/arm/boot/dts/imx6q-arm2.dts           |   4 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts    |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts       |   2 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   4 +-
 arch/arm/boot/dts/imx6q-pinfunc.h          |   1 +
 arch/arm/boot/dts/imx6q-sabrelite.dts      | 214 +--------------------------
 arch/arm/boot/dts/imx6q-sbc6x.dts          |   2 +-
 arch/arm/boot/dts/imx6q-udoo.dts           |   2 +-
 arch/arm/boot/dts/imx6q.dtsi               |   8 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-pingrp.h         | 188 +++++++++++-------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi   |   6 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi   | 226 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |   4 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi   |   6 +-
 arch/arm/boot/dts/imx6qdl.dtsi             | 164 ++++++++++++---------
 arch/arm/boot/dts/imx6sl-evk.dts           |  18 +--
 arch/arm/boot/dts/imx6sl-pingrp.h          | 169 ++++++++++-----------
 arch/arm/boot/dts/imx6sl.dtsi              | 125 ++++++++--------
 25 files changed, 620 insertions(+), 562 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabrelite.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi

-- 
1.8.1.2
