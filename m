From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:20 +0800
Subject: [PATCH 00/17] ARM: imx: add pinctrl settings for DT boot
Message-ID: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds pinctrl settings for imx6q, imx53 and imx51 booting
from DT.  As the results, the dummy pinctrl state gets removed from
these DT images, and all imx53 board files get removed from the tree.
Therefore, imx53 becomes the second DT only i.MX SoC besides imx6q.

Shawn Guo (17):
  ARM: dts: imx6q: improve indentation for fsl,pins
  ARM: dts: imx6q: name iomuxc sub-nodes following pin function
  ARM: dts: imx6q: sort iomuxc sub-nodes in name
  ARM: dts: imx6q-sabrelite: add pinctrl for usdhc and enet
  ARM: dts: imx6q-arm2: add pinctrl for uart and enet
  ARM: dts: imx6q-sabresd: add pinctrl settings
  ARM: imx6q: remove dummy pinctrl state
  ARM: dts: imx53-qsb: add pinctrl settings
  ARM: dts: imx53-ard: add pinctrl settings
  ARM: dts: imx53-evk: add pinctrl settings
  ARM: dts: imx53-smd: add pinctrl settings
  ARM: imx53: build in pinctrl support
  ARM: imx53: decouple device tree boot from board files
  ARM: imx53: support device tree boot only
  ARM: imx53: remove unneeded files and functions
  ARM: dts: imx51-babbage: add pinctrl settings
  ARM: imx51: build in pinctrl support

 arch/arm/boot/dts/imx51-babbage.dts            |   36 +-
 arch/arm/boot/dts/imx51.dtsi                   |  116 +++
 arch/arm/boot/dts/imx53-ard.dts                |   49 +-
 arch/arm/boot/dts/imx53-evk.dts                |   31 +-
 arch/arm/boot/dts/imx53-qsb.dts                |   34 +-
 arch/arm/boot/dts/imx53-smd.dts                |   38 +-
 arch/arm/boot/dts/imx53.dtsi                   |  155 +++
 arch/arm/boot/dts/imx6q-arm2.dts               |   21 +
 arch/arm/boot/dts/imx6q-sabrelite.dts          |   19 +-
 arch/arm/boot/dts/imx6q-sabresd.dts            |   25 +-
 arch/arm/boot/dts/imx6q.dtsi                   |  223 ++++--
 arch/arm/configs/imx_v6_v7_defconfig           |    2 +-
 arch/arm/mach-imx/Kconfig                      |   79 +--
 arch/arm/mach-imx/Makefile                     |    6 +-
 arch/arm/mach-imx/Makefile.boot                |    8 +-
 arch/arm/mach-imx/devices-imx53.h              |   48 -
 arch/arm/mach-imx/imx51-dt.c                   |    3 -
 arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} |   23 -
 arch/arm/mach-imx/mach-imx6q.c                 |    7 -
 arch/arm/mach-imx/mach-mx53_ard.c              |  272 ------
 arch/arm/mach-imx/mach-mx53_evk.c              |  179 ----
 arch/arm/mach-imx/mach-mx53_loco.c             |  321 -------
 arch/arm/mach-imx/mach-mx53_smd.c              |  168 ----
 arch/arm/mach-imx/mm-imx5.c                    |   47 -
 arch/arm/plat-mxc/include/mach/common.h        |    5 -
 arch/arm/plat-mxc/include/mach/iomux-mx53.h    | 1219 ------------------------
 26 files changed, 697 insertions(+), 2437 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx53.h
 rename arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} (82%)
 delete mode 100644 arch/arm/mach-imx/mach-mx53_ard.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_evk.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_loco.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_smd.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx53.h

-- 
1.7.5.4
