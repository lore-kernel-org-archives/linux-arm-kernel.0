From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Oct 2011 11:10:32 +0200
Subject: [GIT PULL] i.MX5 devicetree support
Message-ID: <20111025091032.GT23421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following. It contains devicetree support for i.MX5
based systems. You can use the following to resolve the merge conflicts
against your for-next branch:

git://git.pengutronix.de/git/imx/linux-2.6.git imx-dt-merge

Sascha

The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-for-arnd

Shawn Guo (2):
      arm/mx5: add device tree support for imx53 boards
      arm/mx5: add device tree support for imx51 babbage

 Documentation/devicetree/bindings/arm/fsl.txt |   19 ++
 arch/arm/boot/dts/imx51-babbage.dts           |  135 +++++++++++
 arch/arm/boot/dts/imx51.dtsi                  |  246 ++++++++++++++++++++
 arch/arm/boot/dts/imx53-ard.dts               |  113 +++++++++
 arch/arm/boot/dts/imx53-evk.dts               |  120 ++++++++++
 arch/arm/boot/dts/imx53-qsb.dts               |  125 ++++++++++
 arch/arm/boot/dts/imx53-smd.dts               |  169 ++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                  |  301 +++++++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                     |   21 ++
 arch/arm/mach-mx5/Makefile                    |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c        |    9 +-
 arch/arm/mach-mx5/board-mx53_ard.c            |   12 +-
 arch/arm/mach-mx5/board-mx53_evk.c            |    9 +-
 arch/arm/mach-mx5/board-mx53_loco.c           |    9 +-
 arch/arm/mach-mx5/board-mx53_smd.c            |    9 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c           |   39 ++++
 arch/arm/mach-mx5/imx51-dt.c                  |  116 ++++++++++
 arch/arm/mach-mx5/imx53-dt.c                  |  126 +++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    8 +
 19 files changed, 1577 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 arch/arm/boot/dts/imx51-babbage.dts
 create mode 100644 arch/arm/boot/dts/imx51.dtsi
 create mode 100644 arch/arm/boot/dts/imx53-ard.dts
 create mode 100644 arch/arm/boot/dts/imx53-evk.dts
 create mode 100644 arch/arm/boot/dts/imx53-qsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-smd.dts
 create mode 100644 arch/arm/boot/dts/imx53.dtsi
 create mode 100644 arch/arm/mach-mx5/imx51-dt.c
 create mode 100644 arch/arm/mach-mx5/imx53-dt.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
