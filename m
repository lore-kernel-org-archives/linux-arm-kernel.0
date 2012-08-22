From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 22 Aug 2012 15:18:41 +0800
Subject: [PATCH 0/7] add imx-syscon driver for general registers access
Message-ID: <1345619928-15446-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series mainly adds an imx-syscon driver which is used to access
general system controller registers like IOMUXC GPR and ANATOP,
after that, we convert all the exist private access general registers code to use
standard API from imx-syscon to access registers.
Finally we remove the old mfd anatop driver which is only for anatop register
access.

The patch series is based on linus's tree since commit 9160338.

Dong Aisheng (7):
  mfd: add imx syscon driver based on regmap
  ARM: imx6q: add iomuxc gpr support into imx-syscon
  ARM: imx6q: add anatop support into imx-syscon
  regulator: anatop-regulator: convert to use imx-syscon to access
    anatop register
  ARM: imx6q: convert to use imx-syscon to access anatop registers
  ARM: dts: imx6q: add simple-bus compatible string for anatop
  mfd: anatop-mfd: remove anatop driver

 .../devicetree/bindings/mfd/imx-syscon.txt         |   11 +
 arch/arm/boot/dts/imx6q.dtsi                       |   15 +-
 arch/arm/mach-imx/Kconfig                          |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   25 +--
 drivers/mfd/Kconfig                                |   14 +-
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/anatop-mfd.c                           |  124 --------
 drivers/mfd/imx-syscon.c                           |  193 ++++++++++++
 drivers/regulator/Kconfig                          |    2 +-
 drivers/regulator/anatop-regulator.c               |   17 +-
 include/linux/fsl/imx6q-iomuxc-gpr.h               |  319 ++++++++++++++++++++
 include/linux/mfd/anatop.h                         |   40 ---
 include/linux/mfd/imx-syscon.h                     |   22 ++
 13 files changed, 585 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/imx-syscon.txt
 delete mode 100644 drivers/mfd/anatop-mfd.c
 create mode 100644 drivers/mfd/imx-syscon.c
 create mode 100644 include/linux/fsl/imx6q-iomuxc-gpr.h
 delete mode 100644 include/linux/mfd/anatop.h
 create mode 100644 include/linux/mfd/imx-syscon.h
