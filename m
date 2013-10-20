From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 07:15:12 +0900
Subject: [GIT PULL 4/6] Samsung s3c64xx-dt for v3.13
Message-ID: <526455F0.201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c64xx-dt

for you to fetch changes up to 2ec35a4252eae3d5277af041bd1b5ae4f6183cad:

   ARM: dts: Add dts file for S3C6410-based SMDK6410 board (2013-09-17 
06:48:29 +0900)

----------------------------------------------------------------
Device tree for S3C64XX
- based on common-clk-s3c64xx branch
- add s3c64xx dt board file for using dt
- add dts file for s3c6410-smdk6410 board
- add dts file for s3c6410-mini6410 board

----------------------------------------------------------------
Tomasz Figa (12):
       ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
       ARM: S3C64XX: Use clk_prepare_enable/clk_disable_unprepare in dma.c
       usb: ohci-s3c2410.c: Use clk_prepare_enable/clk_disable_unprepare
       ARM: S3C64XX: Migrate clock handling to Common Clock Framework
       ARM: S3C64XX: Remove old clock management code
       irqchip: vic: Parse interrupt and resume masks from device tree
       ARM: S3C64XX: Bypass legacy initialization when booting with DT
       gpio: samsung: Skip initialization if device tree is present
       ARM: S3C64XX: Add board file for boot using Device Tree
       ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
       ARM: dts: Add dts file for S3C6410-based Mini6410 board
       ARM: dts: Add dts file for S3C6410-based SMDK6410 board

  Documentation/devicetree/bindings/arm/vic.txt   |   12 +
  arch/arm/Kconfig                                |    2 +-
  arch/arm/boot/dts/Makefile                      |    2 +
  arch/arm/boot/dts/s3c6400.dtsi                  |   41 +
  arch/arm/boot/dts/s3c6410-mini6410.dts          |  228 +++++
  arch/arm/boot/dts/s3c6410-smdk6410.dts          |  103 +++
  arch/arm/boot/dts/s3c6410.dtsi                  |   57 ++
  arch/arm/boot/dts/s3c64xx-pinctrl.dtsi          |  687 ++++++++++++++++
  arch/arm/boot/dts/s3c64xx.dtsi                  |  199 +++++
  arch/arm/mach-s3c64xx/Kconfig                   |   16 +
  arch/arm/mach-s3c64xx/Makefile                  |    3 +-
  arch/arm/mach-s3c64xx/clock.c                   | 1007 
-----------------------
  arch/arm/mach-s3c64xx/common.c                  |   33 +-
  arch/arm/mach-s3c64xx/common.h                  |   12 +-
  arch/arm/mach-s3c64xx/dma.c                     |   13 +-
  arch/arm/mach-s3c64xx/include/mach/regs-clock.h |  132 +--
  arch/arm/mach-s3c64xx/irq-pm.c                  |    9 +
  arch/arm/mach-s3c64xx/mach-anw6410.c            |    2 +-
  arch/arm/mach-s3c64xx/mach-crag6410.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-hmt.c                |    2 +-
  arch/arm/mach-s3c64xx/mach-mini6410.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-ncp.c                |    2 +-
  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c         |   85 ++
  arch/arm/mach-s3c64xx/mach-smartq.c             |   11 +-
  arch/arm/mach-s3c64xx/mach-smdk6400.c           |    2 +-
  arch/arm/mach-s3c64xx/mach-smdk6410.c           |    2 +-
  arch/arm/mach-s3c64xx/pm.c                      |   21 -
  arch/arm/mach-s3c64xx/s3c6400.c                 |   15 +-
  arch/arm/mach-s3c64xx/s3c6410.c                 |   16 +-
  arch/arm/plat-samsung/include/plat/cpu.h        |    4 +
  arch/arm/plat-samsung/init.c                    |   12 +-
  drivers/clk/samsung/Makefile                    |    2 -
  drivers/gpio/gpio-samsung.c                     |   34 +-
  drivers/irqchip/irq-vic.c                       |    7 +-
  drivers/usb/host/ohci-s3c2410.c                 |    8 +-
  35 files changed, 1550 insertions(+), 1235 deletions(-)
  create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
  create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
  create mode 100644 arch/arm/boot/dts/s3c6410-smdk6410.dts
  create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
  create mode 100644 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
  delete mode 100644 arch/arm/mach-s3c64xx/clock.c
  create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
