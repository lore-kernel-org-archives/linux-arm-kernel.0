From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Jul 2011 23:07:45 +0800
Subject: [PATCH 0/2] Add device tree support for i.mx53 boards
Message-ID: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all device drivers that the current i.mx53 board files are users
of converted to be device tree aware, it may be the time to convert
all the i.mx53 board support to device tree.

The device tree based i.mx53 ARD, EVK, QSB (aka loco) and SMD now can
work equivalently as the non-dt ones.

Shawn Guo (2):
      arm/mx5: parse iomuxc pad configuratoin from device tree
      arm/mx5: add device tree support for imx53 boards

 .../devicetree/bindings/arm/fsl/boards.txt         |   15 +
 .../devicetree/bindings/arm/fsl/iomuxc.txt         |   47 +
 arch/arm/boot/dts/imx53-ard.dts                    |  365 +++++++
 arch/arm/boot/dts/imx53-evk.dts                    |  354 +++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  358 +++++++
 arch/arm/boot/dts/imx53-smd.dts                    |  444 +++++++++
 arch/arm/boot/dts/imx53.dtsi                       | 1044 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |    8 +
 arch/arm/mach-mx5/Makefile                         |    3 +
 arch/arm/mach-mx5/imx53-dt.c                       |  128 +++
 arch/arm/mach-mx5/iomuxc-dt.c                      |   72 ++
 arch/arm/plat-mxc/include/mach/common.h            |    3 +
 12 files changed, 2841 insertions(+), 0 deletions(-)
