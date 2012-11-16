From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 16 Nov 2012 16:50:00 +0100
Subject: [GIT PULL] i.MX SoC updates
Message-ID: <20121116155000.GX10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please pull the following i.MX SoC updates for next merge window.

Sascha

The following changes since commit 89a4150331bc07014256714678ce8e9b238fc145:

  Merge remote-tracking branch 'arm-soc/imx/multiplatform' into x (2012-11-16 16:21:27 +0100)

are available in the git repository at:


  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-soc

for you to fetch changes up to d6aef84a48fa54ac606ae719fcd125199939f43d:

  ARM i.MX51 babbage: Add display support (2012-11-16 16:34:18 +0100)

----------------------------------------------------------------
ARM i.MX SoC updates

based on imx-multiplatform branch.

----------------------------------------------------------------
Fabio Estevam (3):
      ARM: dts: imx27-3ds: Remove local watchdog inclusion
      ARM: clk-imx27: Add missing clock for mx2-camera
      mx2_camera: Fix regression caused by clock conversion

Ga?tan Carlier (1):
      ARM : i.MX27 : split code for allocation of ressources of camera and eMMA

Roland Stigge (2):
      ARM: mach-imx: Support for DryIce RTC in i.MX53
      watchdog: Support imx watchdog on SOC_IMX53

Sascha Hauer (7):
      ARM i.MX27: Fix low reference clock path
      ARM i.MX51: setup MIPI during startup
      ARM i.MX5: switch IPU clk support to devicetree bindings
      ARM i.MX53: Add IPU support
      ARM i.MX51: Add IPU support
      ARM i.MX6: Add IPU support
      ARM i.MX51 babbage: Add display support

Steffen Trumtrar (1):
      ARM i.MX6: fix ldb_di_sel mux

 arch/arm/boot/dts/imx27-3ds.dts                 |    4 --
 arch/arm/boot/dts/imx51-babbage.dts             |   16 ++++++
 arch/arm/boot/dts/imx51.dtsi                    |   67 +++++++++++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                    |    7 +++
 arch/arm/boot/dts/imx6q.dtsi                    |   18 ++++++
 arch/arm/mach-imx/Kconfig                       |    2 +
 arch/arm/mach-imx/clk-imx27.c                   |   18 +++++-
 arch/arm/mach-imx/clk-imx51-imx53.c             |   20 ++++---
 arch/arm/mach-imx/clk-imx6q.c                   |    2 +-
 arch/arm/mach-imx/devices-imx27.h               |    4 +-
 arch/arm/mach-imx/devices/Kconfig               |    3 +
 arch/arm/mach-imx/devices/Makefile              |    1 +
 arch/arm/mach-imx/devices/devices-common.h      |    9 ++-
 arch/arm/mach-imx/devices/platform-mx2-camera.c |   17 ------
 arch/arm/mach-imx/mm-imx5.c                     |   20 +++++++
 arch/arm/plat-mxc/devices/platform-mx2-emma.c   |   40 ++++++++++++++
 drivers/media/platform/soc_camera/mx2_camera.c  |   39 +++++++++----
 17 files changed, 242 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-emma.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
