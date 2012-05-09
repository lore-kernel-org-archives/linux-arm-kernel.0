From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 May 2012 09:15:00 +0200
Subject: [GIT PULL] i.MX common clock support
Message-ID: <20120509071500.GC16535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following i.MX common clock support branch for next.

Same as with Shawns series this one depends on:

git://git.linaro.org/people/mturquette/linux.git clk-next
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git clkdev

Thanks
 Sascha

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-common-clk

for you to fetch changes up to c818f97bc3266f0fbf619f2348d951272f8ac335:

  ARM i.MX: remove now unused clock files (2012-05-09 09:00:40 +0200)

----------------------------------------------------------------
ARM i.MX common clock framework support

----------------------------------------------------------------
Sascha Hauer (30):
      dmaengine i.MX SDMA: do not depend on grouped clocks
      spi i.MX: do not depend on grouped clocks
      video imxfb: do not depend on grouped clocks
      net fec: do not depend on grouped clocks
      mmc mxcmmc: do not depend on grouped clocks
      mmc sdhc i.MX: do not depend on grouped clocks
      serial i.MX: do not depend on grouped clocks
      mtd mxc_nand: prepare/unprepare clock
      USB ehci mxc: prepare/unprepare clock
      USB ehci mxc: sanitize clock handling
      w1 i.MX: prepare/unprepare clock
      watchdog imx2: prepare clk before enabling it
      media mx3 camera: prepare clk before enabling it
      dmaengine i.MX ipu: clk_prepare/unprepare clock
      rtc: imx dryice: Add missing clk_prepare
      ARM i.MX5: prepare gpc_dvfs_clk
      ARM i.MX timer: request correct clock
      ARM i.MX3: Make ccm base address a variable
      ARM i.MX: prepare for common clock framework
      ARM i.MX: Add common clock support for pllv1
      ARM i.MX: Add common clock support for pllv2
      ARM i.MX: Add common clock support for 2bit gate
      ARM i.MX25: implement clocks using common clock framework
      ARM i.MX1: implement clocks using common clock framework
      ARM i.MX21: implement clocks using common clock framework
      ARM i.MX27: implement clocks using common clock framework
      ARM i.MX31: implement clocks using common clock framework
      ARM i.MX5: implement clocks using common clock framework
      ARM i.MX35: implement clocks using common clock framework
      ARM i.MX: remove now unused clock files

Shawn Guo (4):
      ARM: imx: add common clock support for pllv3
      ARM: imx: add common clock support for pfd
      ARM: imx: add common clock support for clk busy
      ARM: i.MX6: implement clocks using common clock framework

 arch/arm/mach-imx/Kconfig              |    8 +
 arch/arm/mach-imx/Makefile             |   19 +-
 arch/arm/mach-imx/clk-busy.c           |  189 +++
 arch/arm/mach-imx/clk-gate2.c          |  118 ++
 arch/arm/mach-imx/clk-imx1.c           |  115 ++
 arch/arm/mach-imx/clk-imx21.c          |  186 +++
 arch/arm/mach-imx/clk-imx25.c          |  248 ++++
 arch/arm/mach-imx/clk-imx27.c          |  290 +++++
 arch/arm/mach-imx/clk-imx31.c          |  182 +++
 arch/arm/mach-imx/clk-imx35.c          |  278 +++++
 arch/arm/mach-imx/clk-imx51-imx53.c    |  466 +++++++
 arch/arm/mach-imx/clk-imx6q.c          |  439 +++++++
 arch/arm/mach-imx/clk-pfd.c            |  147 +++
 arch/arm/mach-imx/clk-pllv1.c          |   66 +
 arch/arm/mach-imx/clk-pllv2.c          |  249 ++++
 arch/arm/mach-imx/clk-pllv3.c          |  419 +++++++
 arch/arm/mach-imx/clk.h                |   83 ++
 arch/arm/mach-imx/clock-imx1.c         |  636 ----------
 arch/arm/mach-imx/clock-imx21.c        | 1239 -------------------
 arch/arm/mach-imx/clock-imx25.c        |  346 ------
 arch/arm/mach-imx/clock-imx27.c        |  785 ------------
 arch/arm/mach-imx/clock-imx31.c        |  630 ----------
 arch/arm/mach-imx/clock-imx35.c        |  536 --------
 arch/arm/mach-imx/clock-imx6q.c        | 2111 --------------------------------
 arch/arm/mach-imx/clock-mx51-mx53.c    | 1675 -------------------------
 arch/arm/mach-imx/crmregs-imx3.h       |   79 +-
 arch/arm/mach-imx/mm-imx3.c            |    6 +
 arch/arm/mach-imx/mm-imx5.c            |    1 +
 arch/arm/mach-imx/pm-imx3.c            |    4 +-
 arch/arm/plat-mxc/clock.c              |   11 +
 arch/arm/plat-mxc/include/mach/clock.h |    4 +
 arch/arm/plat-mxc/time.c               |   14 +
 drivers/dma/imx-sdma.c                 |   40 +-
 drivers/dma/ipu/ipu_idmac.c            |    6 +-
 drivers/media/video/mx3_camera.c       |    4 +-
 drivers/mmc/host/mxcmmc.c              |   39 +-
 drivers/mmc/host/sdhci-esdhc-imx.c     |   42 +-
 drivers/mtd/nand/mxc_nand.c            |    6 +-
 drivers/net/ethernet/freescale/fec.c   |   35 +-
 drivers/rtc/rtc-imxdi.c                |    6 +-
 drivers/spi/spi-imx.c                  |   30 +-
 drivers/tty/serial/imx.c               |   38 +-
 drivers/usb/host/ehci-mxc.c            |   62 +-
 drivers/video/imxfb.c                  |   50 +-
 drivers/w1/masters/mxc_w1.c            |    4 +-
 drivers/watchdog/imx2_wdt.c            |    2 +-
 46 files changed, 3796 insertions(+), 8147 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-busy.c
 create mode 100644 arch/arm/mach-imx/clk-gate2.c
 create mode 100644 arch/arm/mach-imx/clk-imx1.c
 create mode 100644 arch/arm/mach-imx/clk-imx21.c
 create mode 100644 arch/arm/mach-imx/clk-imx25.c
 create mode 100644 arch/arm/mach-imx/clk-imx27.c
 create mode 100644 arch/arm/mach-imx/clk-imx31.c
 create mode 100644 arch/arm/mach-imx/clk-imx35.c
 create mode 100644 arch/arm/mach-imx/clk-imx51-imx53.c
 create mode 100644 arch/arm/mach-imx/clk-imx6q.c
 create mode 100644 arch/arm/mach-imx/clk-pfd.c
 create mode 100644 arch/arm/mach-imx/clk-pllv1.c
 create mode 100644 arch/arm/mach-imx/clk-pllv2.c
 create mode 100644 arch/arm/mach-imx/clk-pllv3.c
 create mode 100644 arch/arm/mach-imx/clk.h
 delete mode 100644 arch/arm/mach-imx/clock-imx1.c
 delete mode 100644 arch/arm/mach-imx/clock-imx21.c
 delete mode 100644 arch/arm/mach-imx/clock-imx25.c
 delete mode 100644 arch/arm/mach-imx/clock-imx27.c
 delete mode 100644 arch/arm/mach-imx/clock-imx31.c
 delete mode 100644 arch/arm/mach-imx/clock-imx35.c
 delete mode 100644 arch/arm/mach-imx/clock-imx6q.c
 delete mode 100644 arch/arm/mach-imx/clock-mx51-mx53.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
