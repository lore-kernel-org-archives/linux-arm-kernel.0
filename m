From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Jul 2011 02:53:18 +0800
Subject: [PATCH v2 0/3] Add device tree support for i.mx51/53 boards
Message-ID: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It coverts i.mx51 Babbage, i.mx53 ARD, EVK, QSB (aka loco) and SMD
to use device tree.

Changes since v1:
 * Address comments on v1 given by Grant and Sascha
 * Add i.mx51 Babbage support

Shawn Guo (3):
      arm/mx5: parse iomuxc pad configuratoin from device tree
      arm/mx5: add device tree support for imx53 boards
      arm/mx5: add device tree support for imx51 babbage

 .../devicetree/bindings/arm/fsl/boards.txt         |   19 +
 .../devicetree/bindings/arm/fsl/iomuxc.txt         |   47 +
 arch/arm/boot/dts/imx51-babbage.dts                |  548 +++++++++
 arch/arm/boot/dts/imx51.dtsi                       | 1190 ++++++++++++++++++++
 arch/arm/boot/dts/imx53-ard.dts                    |  365 ++++++
 arch/arm/boot/dts/imx53-evk.dts                    |  353 ++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  357 ++++++
 arch/arm/boot/dts/imx53-smd.dts                    |  443 ++++++++
 arch/arm/boot/dts/imx53.dtsi                       | 1055 +++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |   16 +
 arch/arm/mach-mx5/Makefile                         |    4 +
 arch/arm/mach-mx5/imx51-dt.c                       |  101 ++
 arch/arm/mach-mx5/imx53-dt.c                       |  161 +++
 arch/arm/mach-mx5/iomuxc-dt.c                      |   70 ++
 arch/arm/plat-mxc/include/mach/common.h            |    3 +
 15 files changed, 4732 insertions(+), 0 deletions(-)
