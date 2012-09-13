From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Sep 2012 10:35:34 +0200
Subject: [GIT PULL 2/5] ARM i.MX cleanup patches
In-Reply-To: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
References: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347525337-19115-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-cleanup

for you to fetch changes up to 51f66191cf54ba3d62dd7e4a77dd376cc97de27f:

  ARM i.MX53 clk: Fix ldb parent clocks (2012-09-12 11:57:13 +0200)

----------------------------------------------------------------
ARM i.MX cleanup patches

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: plat-mxc: Remove unused imx_ioremap
      ARM: imx27-phytec-phycore: Fix I2C EEPROM address

Javier Martin (1):
      ARM i.MX mx2_camera: Remove MX2_CAMERA_SWAP16 and MX2_CAMERA_PACK_DIR_MSB flags.

Oskar Schirmer (1):
      serial/imx: fix IMX UART macro usage to reflect correct processor

Sascha Hauer (3):
      ARM: i.MX clk pllv1: move mxc_decode_pll code to its user
      ARM: i.MX remove last leftovers from legacy clock support
      ARM i.MX53 clk: Fix ldb parent clocks

Wei Yongjun (1):
      ARM i.MX: remove duplicated include from clk-imx21.c

 arch/arm/boot/dts/imx27-phytec-phycore.dts    |    2 +-
 arch/arm/mach-imx/Makefile                    |    2 +-
 arch/arm/mach-imx/clk-imx21.c                 |    1 -
 arch/arm/mach-imx/clk-imx51-imx53.c           |    4 +-
 arch/arm/mach-imx/clk-pllv1.c                 |   49 ++++-
 arch/arm/mach-imx/clk.c                       |    3 +
 arch/arm/mach-imx/clk.h                       |    3 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c         |    1 -
 arch/arm/plat-mxc/Makefile                    |    2 +-
 arch/arm/plat-mxc/clock.c                     |  257 -------------------------
 arch/arm/plat-mxc/cpufreq.c                   |    1 -
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    2 +-
 arch/arm/plat-mxc/include/mach/clock.h        |   70 -------
 arch/arm/plat-mxc/include/mach/mx2_cam.h      |    2 -
 arch/arm/plat-mxc/system.c                    |    4 -
 15 files changed, 58 insertions(+), 345 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk.c
 delete mode 100644 arch/arm/plat-mxc/clock.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/clock.h
