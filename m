From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 18 Dec 2013 15:41:30 -0700
Subject: [PATCH V1 0/7] Fix imx6 fec interrupts
Message-ID: <1387406497-26430-1-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series works around a hardware
wake up on FEC interrupt bug.


Note: The last 2 patches need testing from
someone who has the boards.

Troy Kisky (7):
  ARM: dts: imx: pinfunc: add MX6QDL_PAD_GPIO_6__ENET_IRQ
  ARM: dts: imx6qdl: add pingroups for enet with GPIO6 interrupt
  ARM: dts: imx6qdl-sabrelite: use MX6QDL_ENET_PINGRP_RGMII_MD
  ARM: dts: imx6qdl: use interrupts-extended for fec
  ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC interrupt.
  ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC interrupt.
  ARM: dts: imx6q-arm2: use GPIO_6 for FEC interrupt.

 arch/arm/boot/dts/imx6dl-pinfunc.h        |  1 +
 arch/arm/boot/dts/imx6q-arm2.dts          |  4 +-
 arch/arm/boot/dts/imx6q-pinfunc.h         |  1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 19 ++------
 arch/arm/boot/dts/imx6qdl-pingrp.h        | 77 +++++++++++++------------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  |  4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  | 19 ++------
 arch/arm/boot/dts/imx6qdl.dtsi            |  5 +-
 8 files changed, 52 insertions(+), 78 deletions(-)

-- 
1.8.1.2
