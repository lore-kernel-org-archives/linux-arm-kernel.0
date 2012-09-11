From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Sep 2012 20:02:47 +0800
Subject: =?UTF-8?q?=5BGIT=20PULL=201/2=5D=20imx=20device=20tree=20changes?=
In-Reply-To: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
References: <1347364968-27496-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347364968-27496-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:

  Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.7

for you to fetch changes up to f8135a74df53ba7010a162dddd112b73ee5652e3:

  ARM: imx6q-sabrelite: Rename 'pinctrl_gpio_hog' (2012-09-11 16:27:00 +0800)

----------------------------------------------------------------
imx-dt-3.7

- All imx53 board files are removed by the equal device tree support
- The efikamx board files are removed to ease device tree migration
- Remove dummy pinctrl state by setting up pinctrl in device tree

----------------------------------------------------------------
Fabio Estevam (4):
      ARM: dts: imx: Always enable the watchdog
      ARM: dts: imx: Move SDMA firmware to SoC dtsi file
      ARM: mach-imx: Remove board entries in dt_board_compat
      ARM: imx6q-sabrelite: Rename 'pinctrl_gpio_hog'

Matt Sealey (3):
      ARM: efikamx: remove support for Genesi Efika MX from the build
      ARM: efikamx: remove Genesi Efika MX from the i.MX v6/v7 defconfig
      ARM: efikamx: remove Genesi Efika MX platform files from the tree

Michael Grzeschik (1):
      ARM: dts: imx: add imx5x usb entries

Shawn Guo (18):
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
      ARM: imx51: decouple device tree boot from board files

Steffen Trumtrar (1):
      ARM i.MX53: dts: add flexcan to imx53

Uwe Kleine-K?nig (1):
      ARM: imx/imx31-dt: drop selecting USE_OF

 arch/arm/boot/dts/imx27-phytec-phycore.dts     |    4 -
 arch/arm/boot/dts/imx27.dtsi                   |    1 -
 arch/arm/boot/dts/imx51-babbage.dts            |   44 +-
 arch/arm/boot/dts/imx51.dtsi                   |  146 ++-
 arch/arm/boot/dts/imx53-ard.dts                |   59 +-
 arch/arm/boot/dts/imx53-evk.dts                |   39 +-
 arch/arm/boot/dts/imx53-qsb.dts                |   42 +-
 arch/arm/boot/dts/imx53-smd.dts                |   46 +-
 arch/arm/boot/dts/imx53.dtsi                   |  199 +++-
 arch/arm/boot/dts/imx6q-arm2.dts               |   21 +
 arch/arm/boot/dts/imx6q-sabrelite.dts          |   27 +-
 arch/arm/boot/dts/imx6q-sabresd.dts            |   25 +-
 arch/arm/boot/dts/imx6q.dtsi                   |  224 +++--
 arch/arm/configs/imx_v6_v7_defconfig           |    4 +-
 arch/arm/mach-imx/Kconfig                      |  106 +--
 arch/arm/mach-imx/Makefile                     |    9 +-
 arch/arm/mach-imx/Makefile.boot                |    8 +-
 arch/arm/mach-imx/devices-imx53.h              |   48 -
 arch/arm/mach-imx/efika.h                      |   10 -
 arch/arm/mach-imx/imx51-dt.c                   |   21 -
 arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} |   27 -
 arch/arm/mach-imx/mach-imx6q.c                 |   10 -
 arch/arm/mach-imx/mach-mx51_efikamx.c          |  300 ------
 arch/arm/mach-imx/mach-mx51_efikasb.c          |  296 ------
 arch/arm/mach-imx/mach-mx53_ard.c              |  272 ------
 arch/arm/mach-imx/mach-mx53_evk.c              |  179 ----
 arch/arm/mach-imx/mach-mx53_loco.c             |  321 -------
 arch/arm/mach-imx/mach-mx53_smd.c              |  168 ----
 arch/arm/mach-imx/mm-imx5.c                    |   47 -
 arch/arm/mach-imx/mx51_efika.c                 |  633 ------------
 arch/arm/plat-mxc/include/mach/common.h        |    6 -
 arch/arm/plat-mxc/include/mach/iomux-mx53.h    | 1219 ------------------------
 32 files changed, 773 insertions(+), 3788 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices-imx53.h
 delete mode 100644 arch/arm/mach-imx/efika.h
 rename arch/arm/mach-imx/{imx53-dt.c => mach-imx53.c} (81%)
 delete mode 100644 arch/arm/mach-imx/mach-mx51_efikamx.c
 delete mode 100644 arch/arm/mach-imx/mach-mx51_efikasb.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_ard.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_evk.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_loco.c
 delete mode 100644 arch/arm/mach-imx/mach-mx53_smd.c
 delete mode 100644 arch/arm/mach-imx/mx51_efika.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx53.h
