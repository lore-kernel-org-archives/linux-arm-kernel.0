From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  7 May 2012 22:11:27 +0800
Subject: [PATCH 0/3] Initial device tree support for mxs
Message-ID: <1336399890-12883-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is based on mxs common clk and pinctrl support to recreate
the mxs/dt branch, which includes the initial device tree support, fec
and serial console for imx28-evk and imx23-evk boards.

Dong Aisheng (1):
  ARM: mxs: add initial device tree support for imx28-evk board

Shawn Guo (2):
  ARM: mxs: add initial device tree support for imx23-evk board
  ARM: mxs: always build in device tree support

 Documentation/devicetree/bindings/arm/fsl.txt |    8 +
 arch/arm/Kconfig                              |    1 +
 arch/arm/boot/dts/imx23-evk.dts               |   32 ++
 arch/arm/boot/dts/imx23.dtsi                  |  243 ++++++++++++++++
 arch/arm/boot/dts/imx28-evk.dts               |   48 +++
 arch/arm/boot/dts/imx28.dtsi                  |  382 +++++++++++++++++++++++++
 arch/arm/configs/mxs_defconfig                |    1 +
 arch/arm/mach-mxs/Kconfig                     |   10 +
 arch/arm/mach-mxs/Makefile                    |    1 +
 arch/arm/mach-mxs/devices/Kconfig             |    1 -
 arch/arm/mach-mxs/mach-mxs.c                  |  109 +++++++
 drivers/clk/mxs/clk-imx23.c                   |    1 +
 drivers/clk/mxs/clk-imx28.c                   |    1 +
 13 files changed, 837 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-evk.dts
 create mode 100644 arch/arm/boot/dts/imx23.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-evk.dts
 create mode 100644 arch/arm/boot/dts/imx28.dtsi
 create mode 100644 arch/arm/mach-mxs/mach-mxs.c

-- 
1.7.5.4
