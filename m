From: Frank.Li@freescale.com (Frank Li)
Date: Wed, 31 Oct 2012 12:24:40 +0800
Subject: [PATCH 0/4] Support the MX6 FEC as a PTP hardware clock
Message-ID: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables hardware time stamping and a PTP hardware clock
for mx6 ENET controller.

Frank Li (4):
  net: fec: move fec_enet_private to header file
  ARM: dts: imx6q: Add ENET PTP clock pin and clock source
  ARM: imx6q: Set enet tx reference clk from anatop to support 1588
  FEC: Add time stamping code and a PTP hardware clock

 arch/arm/boot/dts/imx6q.dtsi             |    5 +-
 arch/arm/mach-imx/mach-imx6q.c           |   12 +
 drivers/net/ethernet/freescale/Kconfig   |    9 +
 drivers/net/ethernet/freescale/Makefile  |    1 +
 drivers/net/ethernet/freescale/fec.c     |  161 +++++++------
 drivers/net/ethernet/freescale/fec.h     |  119 +++++++++
 drivers/net/ethernet/freescale/fec_ptp.c |  386 ++++++++++++++++++++++++++++++
 7 files changed, 617 insertions(+), 76 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/fec_ptp.c
