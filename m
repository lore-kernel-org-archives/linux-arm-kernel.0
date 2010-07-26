From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Jul 2010 15:46:17 +0200
Subject: Pull request mxc
In-Reply-To: <20100726103219.GB20737@n2100.arm.linux.org.uk>
References: <20100726090014.GQ14113@pengutronix.de>
	<20100726092855.GA20737@n2100.arm.linux.org.uk>
	<20100726103219.GB20737@n2100.arm.linux.org.uk>
Message-ID: <20100726134617.GS14113@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 26, 2010 at 11:32:19AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 26, 2010 at 10:28:55AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Jul 26, 2010 at 11:00:14AM +0200, Sascha Hauer wrote:
> > >  160 files changed, 6547 insertions(+), 3276 deletions(-)
> > 
> > I get:
> > 
> > 160 files changed, 6530 insertions(+), 3265 deletions
> > 
> > which seems to be down to this difference between your diffstat and mine:
> > 
> > > arch/arm/mach-mx3/mach-mx31lilly.c                 |   48 +-
> > 
> >  arch/arm/mach-mx3/mach-mx31lilly.c                 |   20 +-
> > 
> > This seems to be down to 4d5d859 (ARM: mx3: mx31lilly: fix build error for
> > !CONFIG_USB_ULPI).
> 
> Err...
> 
> commit 10ee61384e444133e4d2cf2a1f21fdd50c2be297
> Author: Baruch Siach <baruch@tkos.co.il>
> Date:   Sun Jul 4 07:55:10 2010 +0300
> 
>     mx2_camera: Add soc_camera support for i.MX25/i.MX27
> 
>     This is the soc_camera support developed by Sascha Hauer for the i.MX27.  Alan
>     Carvalho de Assis modified the original driver to get it working on more recent
>     kernels. I modified it further to add support for i.MX25. This driver has been
>     tested on i.MX25 and i.MX27 based platforms.
> 
>     Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>     Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Why has no one from the V4L community reviewed this patch?
> 
> Why are you using void __iomem * with the virtual address returned from
> dma_alloc_coherent()?  It doesn't return IOMEM addresses!

I dropped this patch until this is sorted out and the other one you
mentioned in the other mail from the branch. Here's another try:

The following changes since commit 815c4163b6c8ebf8152f42b0a5fd015cfdcedc78:

  Linux 2.6.35-rc4 (2010-07-04 20:22:50 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Amit Kucheria (2):
      arm: mxc: utilise usecount field in clock operations
      mxc: Fix pad names for imx51

Baruch Siach (10):
      mxc_nand: add support for platform defined partitions
      mx25: add platform code for imx-keypad
      mx25pdk: add keypad support
      mx25: add watchdog clock
      mx25pdk: register watchdog device
      mx25: add a comment documenting undocumented IPG clocks
      mx27: add support for the CSI device
      mx25: add support for the CSI device
      mx25: add iomux defines for UART4 on KPP pins
      mx25: add PWM4 to iomux

Daniel Mack (2):
      ARM: mx3: pcm037: remove unused variable
      ARM: mx3: mx31lilly: pass mc13783 SPI IRQ pin

Dinh Nguyen (2):
      mx5: Add i2c to Freescale MX51 Babbage HW
      mx5: Register i2c on Freescale MX51 Babbage HW

Eric B?nard (35):
      eukrea_mbimx27-baseboard: fix typo in display name
      eukrea_mbimx27-baseboard: add generic-bl and platform-lcd controls
      eukrea_mbimx27-baseboard: add timings for DVI output
      cpuimx27 and mbimx27: allow fine control of UART4 and SDHC2 usage
      mach-cpuimx27: fix QuadUART's IRQ typo in pins'setup
      eukrea_mbimx27: fix ADS7846 support
      mach-cpuimx27: add USB Host2 and OTG support
      mach-cpuimx27: register wdt and w1_master resources
      mxcmmc: add card detect through DAT3 possibility
      eukrea_mbimx27: use card detect through DAT3 for SDHC1
      MX2X: Add Keypad device definition for MX2X arch
      eukrea_mbimx27: add support for the keyboard
      eukrea_mbimx27: add audio codec
      i.MX35: return IPU clock's value for mx3fb
      mach-cpuimx27: fix USB_ULPI build warnings
      eukrea_mbimx27: fix audio support when SOC is compiled as module
      i.MX27: add suspend to RAM support
      MX25: put define for OTG base address in right include
      plat-mxc/ehci.c: add i.MX25 support
      i.MX25: fix get_rate_otg to return the correct value
      i.MX25: fix EHCI support
      i.MX25: fix USB gadget support
      i.MX25: add AUDMUX and SSI support
      i.MX25: add cpuimx25 module and its baseboard
      i.MX35: add cpuimx35 support and its baseboard
      mxcmmc: convert to pm_ops and enable/disable clock
      imx25: fix low level debug
      imxfb: add pwmr controlled backlight support
      eukrea_mbimx27-baseboard: fix compile when CONFIG_SPI_IMX is disabled
      i.MX51: handle IRQ for gpio 16..31
      iomux-mx51: add 4 pin definitions
      mbimxsd baseboards : remove unnecessary include
      Fix KConfig warning
      eukrea-baseboards: merge includes in one file
      i.MX51: add support for cpuimx51 module and its baseboard

Fabio Estevam (1):
      mx31_3ds: Handle USB OTG GPIO Errors

Jason Wang (9):
      mx51/iomux: Fix mux mode and input path for two pads
      mx51/iomux: add UART and GPIO pad definitions for imx51_3ds board
      mxc/iomux: add GPIO bank offset for iomux v3 platforms
      mxc: add common debug board for 3-stack platforms
      mx31_3ds: revert 3ds debug board relate code
      mx51_3ds: Add support for the imx51 3-stack board
      mx51: add imx_keypad device definition for mx51 platforms
      mx51_3ds: add keypad support on 3ds platform
      imx: move gpio init after to irq init

Luotao Fu (2):
      pca100: add framebuffer device support and TFT
      pca100: clean up GPIO pin multiplexing

Marc Kleine-Budde (5):
      mx25: add flexcan address and interrupt definition
      mx35: adjust flexcan clock definition
      mx35: add flexcan address
      imx: dynamically register flexcan devices for mx25 and mx35
      pcm043: register flexcan device

Rogerio Pimentel (1):
      mx27_3ds: add support for the keypad

Sascha Hauer (2):
      mxc_nand: Fix OOB handling
      mx25: flexcan clock support

Uwe Kleine-K?nig (60):
      ARM: mx3: rename mach-mx35pdk.c to mach-mx35_3ds.c matching its arch number
      ARM: mx25: rename mach-mx25pdk.c to mach-mx25_3ds.c matching its arch number
      ARM: mx1: don't use deprecated symbol names
      ARM: mx1/scb9328: fix type of uart1_mxc_exit to make compiler happy
      ARM: mx2/mx27_3ds: document alternative names and remove empty header
      ARM: imx: remove empty and unused board headers
      ARM: mx3/kzm_arm11_01: fold board header in its only user
      ARM: mx2/mx21ads: fold board header in its only user
      ARM: mx2/mx27ads: fold board header in its only user
      ARM: mx3/qong: get rid of nearly empty header
      ARM: mx3/mx31_3ds: fold board header in its only user
      ARM: mx3/mx31ads: fold board header in its only user
      ARM: mxc: grammar fix
      ARM: imx: rename mach dir for mx21 and mx27 to mach-imx
      ARM: imx/mx1: fold crm_regs.h into its only consumer
      ARM: imx: get rid of mxc_gpio_init
      ARM: imx: fold serial.c into devices.c
      ARM: imx1: rename imx_csi_device to match its .name
      ARM: imx1: rename imx_i2c_device to follow a common naming scheme
      ARM: imx1: rename imx_uart[12]_device to follow a common naming scheme
      ARM: imx: rename mxc_uart_devicex to follow a common naming scheme
      ARM: imx: move mx1 support to mach-imx
      ARM: imx: Kconfig: use an if block instead of a depend for many symbols
      ARM: imx: prepare deprecating ARCH_MX1, MACH_MX2, MACH_MX21 and MACH_MX27
      ARM: imx: new Kconfig symbol and feature test macro for DMA on mx1 and mx2
      ARM: imx: new helper function imx_add_platform_device
      MTD: mxc_nand: make bit fields unsigned to please sparse
      ARM: imx: remove paragraphs with old address of the FSF
      ARM: mx25: remove paragraphs with old address of the FSF
      ARM: mx3: remove paragraphs with old address of the FSF
      ARM: mxc91231: remove paragraphs with old address of the FSF
      ARM: mxc: remove paragraphs with old address of the FSF
      ARM: imx: Change the way nand devices are registered (generic part)
      ARM: imx: Change the way nand devices are registered (imx21)
      ARM: imx: Change the way nand devices are registered (imx25)
      ARM: imx: Change the way nand devices are registered (imx27)
      ARM: imx: Change the way nand devices are registered (imx31)
      ARM: imx: Change the way nand devices are registered (imx35)
      ARM: imx: dynamically register imx-i2c devices (generic part)
      ARM: imx: dynamically register imx-i2c devices (imx1)
      ARM: imx: dynamically register imx-i2c devices (imx21)
      ARM: imx: dynamically register imx-i2c devices (imx25)
      ARM: imx: dynamically register imx-i2c devices (imx27)
      ARM: imx: dynamically register imx-i2c devices (imx31)
      ARM: imx: dynamically register imx-i2c devices (imx35)
      ARM: imx: dynamically register spi_imx devices (generic part)
      ARM: imx: dynamically register spi_imx devices (imx21)
      ARM: imx: dynamically register spi_imx devices (imx25)
      ARM: imx: dynamically register spi_imx devices (imx27)
      ARM: imx: dynamically register spi_imx devices (imx31)
      ARM: imx: dynamically register spi_imx devices (imx35)
      ARM: imx: dynamically register imx-uart devices (generic part)
      ARM: imx: dynamically register imx-uart devices (imx1)
      ARM: imx: dynamically register imx-uart devices (imx21)
      ARM: imx: dynamically register imx-uart devices (imx25)
      ARM: imx: dynamically register imx-uart devices (imx27)
      ARM: imx: dynamically register imx-uart devices (imx31)
      ARM: imx: dynamically register imx-uart devices (imx35)
      ARM: mx3: complement uart init routine with an exit routine
      Merge branch 'imx/for-2.6.36' of git://git.pengutronix.de/git/ukl/linux-2.6 into HEAD

Wolfram Sang (1):
      pcm037/pcm043/pca100: fix ULPI-related build warnings

 arch/arm/Makefile                                  |    4 +-
 arch/arm/mach-imx/Kconfig                          |  193 +++++++
 arch/arm/{mach-mx2 => mach-imx}/Makefile           |   18 +-
 arch/arm/{mach-mx2 => mach-imx}/Makefile.boot      |    4 +
 .../{mach-mx1/clock.c => mach-imx/clock-imx1.c}    |   50 ++-
 .../clock_imx21.c => mach-imx/clock-imx21.c}       |    0
 .../clock_imx27.c => mach-imx/clock-imx27.c}       |    2 +-
 .../{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} |    0
 arch/arm/mach-imx/devices-imx1.h                   |   18 +
 arch/arm/mach-imx/devices-imx21.h                  |   30 +
 arch/arm/mach-imx/devices-imx27.h                  |   38 ++
 arch/arm/{mach-mx2 => mach-imx}/devices.c          |  296 +++++++----
 arch/arm/{mach-mx2 => mach-imx}/devices.h          |   32 +-
 .../{plat-mxc/dma-mx1-mx2.c => mach-imx/dma-v1.c}  |    4 +-
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |  392 ++++++++++++++
 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h       |   10 +
 .../include/mach/dma-v1.h}                         |   10 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c    |  122 ++++-
 arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c   |   11 +-
 arch/arm/{mach-mx1 => mach-imx}/mach-mx1ads.c      |   34 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c     |   58 ++-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c    |   40 ++-
 arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c     |   76 ++--
 arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c    |   36 +-
 arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c      |  114 +++-
 arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c      |   33 +-
 arch/arm/{mach-mx1 => mach-imx}/mach-scb9328.c     |   21 +-
 .../arm/{mach-mx1/generic.c => mach-imx/mm-imx1.c} |   23 +-
 arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c         |    5 +-
 arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c         |    5 +-
 .../ksym_mx1.c => mach-imx/mx1-camera-fiq-ksym.c}  |    0
 .../mx1_camera_fiq.S => mach-imx/mx1-camera-fiq.S} |    0
 arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c |    0
 arch/arm/mach-imx/pm-imx27.c                       |   46 ++
 arch/arm/mach-mx1/Kconfig                          |   19 -
 arch/arm/mach-mx1/Makefile                         |   15 -
 arch/arm/mach-mx1/Makefile.boot                    |    4 -
 arch/arm/mach-mx1/crm_regs.h                       |   55 --
 arch/arm/mach-mx1/devices.c                        |  242 ---------
 arch/arm/mach-mx1/devices.h                        |    7 -
 arch/arm/mach-mx2/Kconfig                          |  116 ----
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c       |  249 ---------
 arch/arm/mach-mx2/serial.c                         |  141 -----
 arch/arm/mach-mx25/Kconfig                         |   23 +
 arch/arm/mach-mx25/Makefile                        |    4 +-
 arch/arm/mach-mx25/clock.c                         |   70 +++-
 arch/arm/mach-mx25/devices-imx25.h                 |   43 ++
 arch/arm/mach-mx25/devices.c                       |  313 +++--------
 arch/arm/mach-mx25/devices.h                       |   16 +-
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c      |  260 +++++++++
 arch/arm/mach-mx25/mach-cpuimx25.c                 |  173 ++++++
 .../mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c}  |   58 ++-
 arch/arm/mach-mx25/mm.c                            |    7 +-
 arch/arm/mach-mx3/Kconfig                          |   53 ++
 arch/arm/mach-mx3/Makefile                         |    4 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    6 +-
 arch/arm/mach-mx3/devices-imx31.h                  |   38 ++
 arch/arm/mach-mx3/devices-imx35.h                  |   37 ++
 arch/arm/mach-mx3/devices.c                        |  247 +---------
 arch/arm/mach-mx3/devices.h                        |   13 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |  263 +++++++++
 arch/arm/mach-mx3/mach-armadillo5x0.c              |   17 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |  227 ++++++++
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |   31 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |  256 +++-------
 arch/arm/mach-mx3/mach-mx31ads.c                   |   55 ++-
 arch/arm/mach-mx3/mach-mx31lilly.c                 |   15 +-
 arch/arm/mach-mx3/mach-mx31lite.c                  |   17 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   50 +-
 .../mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c}   |   16 +-
 arch/arm/mach-mx3/mach-pcm037.c                    |   34 +-
 arch/arm/mach-mx3/mach-pcm037_eet.c                |    7 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |   31 +-
 arch/arm/mach-mx3/mach-qong.c                      |   16 +-
 arch/arm/mach-mx3/mm.c                             |    7 +-
 arch/arm/mach-mx3/mx31lilly-db.c                   |   14 +-
 arch/arm/mach-mx3/mx31lite-db.c                    |   15 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   10 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |    4 -
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   11 +-
 arch/arm/mach-mx5/Kconfig                          |   27 +
 arch/arm/mach-mx5/Makefile                         |    4 +-
 arch/arm/mach-mx5/board-cpuimx51.c                 |  293 ++++++++++
 arch/arm/mach-mx5/board-mx51_3ds.c                 |  164 ++++++
 arch/arm/mach-mx5/board-mx51_babbage.c             |   28 +-
 arch/arm/mach-mx5/clock-mx51.c                     |   16 +
 arch/arm/mach-mx5/devices.c                        |   83 +++-
 arch/arm/mach-mx5/devices.h                        |    4 +
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |  200 +++++++
 arch/arm/mach-mx5/mm.c                             |    3 +
 arch/arm/mach-mxc91231/crm_regs.h                  |    5 -
 arch/arm/mach-mxc91231/devices.c                   |    2 +-
 arch/arm/mach-mxc91231/mm.c                        |    8 +-
 arch/arm/plat-mxc/3ds_debugboard.c                 |  202 +++++++
 arch/arm/plat-mxc/Kconfig                          |   22 +-
 arch/arm/plat-mxc/Makefile                         |    5 +-
 arch/arm/plat-mxc/audmux-v1.c                      |    4 -
 arch/arm/plat-mxc/audmux-v2.c                      |   19 +-
 arch/arm/plat-mxc/clock.c                          |   37 +-
 arch/arm/plat-mxc/devices.c                        |   33 ++
 arch/arm/plat-mxc/devices/Kconfig                  |   15 +
 arch/arm/plat-mxc/devices/Makefile                 |    8 +
 arch/arm/plat-mxc/devices/platform-flexcan.c       |   30 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |   29 +
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |   60 +++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c      |   44 ++
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   30 +
 arch/arm/plat-mxc/ehci.c                           |   50 ++-
 arch/arm/plat-mxc/gpio.c                           |    6 +
 arch/arm/plat-mxc/include/mach/3ds_debugboard.h    |   18 +
 .../arm/plat-mxc/include/mach/board-armadillo5x0.h |   15 -
 arch/arm/plat-mxc/include/mach/board-kzmarm11.h    |   39 --
 arch/arm/plat-mxc/include/mach/board-mx21ads.h     |   52 --
 arch/arm/plat-mxc/include/mach/board-mx27ads.h     |  344 ------------
 arch/arm/plat-mxc/include/mach/board-mx27lite.h    |   14 -
 arch/arm/plat-mxc/include/mach/board-mx27pdk.h     |   14 -
 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h    |   59 --
 arch/arm/plat-mxc/include/mach/board-mx31ads.h     |  117 ----
 arch/arm/plat-mxc/include/mach/board-mx31lilly.h   |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31lite.h    |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    2 +-
 arch/arm/plat-mxc/include/mach/board-mx35pdk.h     |   22 -
 arch/arm/plat-mxc/include/mach/board-pcm037.h      |   22 -
 arch/arm/plat-mxc/include/mach/board-pcm038.h      |    2 +-
 arch/arm/plat-mxc/include/mach/board-pcm043.h      |   22 -
 arch/arm/plat-mxc/include/mach/board-qong.h        |   17 -
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    4 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |   60 +++
 ...board-eukrea_cpuimx27.h => eukrea-baseboards.h} |   19 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    1 +
 arch/arm/plat-mxc/include/mach/iomux-mx25.h        |   28 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |  559 ++++++++++----------
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h    |    4 -
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |   15 +
 arch/arm/plat-mxc/include/mach/mmc.h               |    3 +
 arch/arm/plat-mxc/include/mach/mx1.h               |   28 +-
 arch/arm/plat-mxc/include/mach/mx25.h              |   50 ++-
 arch/arm/plat-mxc/include/mach/mx27.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx31.h              |    4 +-
 arch/arm/plat-mxc/include/mach/mx35.h              |    6 +-
 arch/arm/plat-mxc/include/mach/mx3_camera.h        |    4 -
 arch/arm/plat-mxc/include/mach/mxc91231.h          |    4 -
 arch/arm/plat-mxc/include/mach/mxc_nand.h          |   10 +-
 arch/arm/plat-mxc/include/mach/system.h            |    4 -
 arch/arm/plat-mxc/include/mach/timex.h             |    4 -
 arch/arm/plat-mxc/include/mach/uncompress.h        |    4 -
 arch/arm/plat-mxc/include/mach/vmalloc.h           |    4 -
 arch/arm/plat-mxc/irq.c                            |    3 -
 arch/arm/plat-mxc/system.c                         |    4 -
 arch/arm/plat-mxc/tzic.c                           |    2 -
 drivers/mmc/host/mxcmmc.c                          |   48 ++-
 drivers/mtd/nand/mxc_nand.c                        |   33 +-
 drivers/usb/gadget/fsl_mxc_udc.c                   |    2 +-
 drivers/usb/host/ehci-mxc.c                        |    2 +-
 drivers/video/imxfb.c                              |   72 +++-
 155 files changed, 4950 insertions(+), 3263 deletions(-)
 create mode 100644 arch/arm/mach-imx/Kconfig
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile (55%)
 rename arch/arm/{mach-mx2 => mach-imx}/Makefile.boot (67%)
 rename arch/arm/{mach-mx1/clock.c => mach-imx/clock-imx1.c} (90%)
 rename arch/arm/{mach-mx2/clock_imx21.c => mach-imx/clock-imx21.c} (100%)
 rename arch/arm/{mach-mx2/clock_imx27.c => mach-imx/clock-imx27.c} (99%)
 rename arch/arm/{mach-mx2/cpu_imx27.c => mach-imx/cpu-imx27.c} (100%)
 create mode 100644 arch/arm/mach-imx/devices-imx1.h
 create mode 100644 arch/arm/mach-imx/devices-imx21.h
 create mode 100644 arch/arm/mach-imx/devices-imx27.h
 rename arch/arm/{mach-mx2 => mach-imx}/devices.c (67%)
 rename arch/arm/{mach-mx2 => mach-imx}/devices.h (54%)
 rename arch/arm/{plat-mxc/dma-mx1-mx2.c => mach-imx/dma-v1.c} (99%)
 create mode 100644 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
 create mode 100644 arch/arm/mach-imx/include/mach/dma-mx1-mx2.h
 rename arch/arm/{plat-mxc/include/mach/dma-mx1-mx2.h => mach-imx/include/mach/dma-v1.h} (93%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-cpuimx27.c (66%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-imx27lite.c (86%)
 rename arch/arm/{mach-mx1 => mach-imx}/mach-mx1ads.c (81%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx21ads.c (77%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27_3ds.c (74%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mx27ads.c (82%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-mxt_td60.c (86%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pca100.c (80%)
 rename arch/arm/{mach-mx2 => mach-imx}/mach-pcm038.c (91%)
 rename arch/arm/{mach-mx1 => mach-imx}/mach-scb9328.c (89%)
 rename arch/arm/{mach-mx1/generic.c => mach-imx/mm-imx1.c} (68%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx21.c (95%)
 rename arch/arm/{mach-mx2 => mach-imx}/mm-imx27.c (95%)
 rename arch/arm/{mach-mx1/ksym_mx1.c => mach-imx/mx1-camera-fiq-ksym.c} (100%)
 rename arch/arm/{mach-mx1/mx1_camera_fiq.S => mach-imx/mx1-camera-fiq.S} (100%)
 rename arch/arm/{mach-mx2 => mach-imx}/pcm970-baseboard.c (100%)
 create mode 100644 arch/arm/mach-imx/pm-imx27.c
 delete mode 100644 arch/arm/mach-mx1/Kconfig
 delete mode 100644 arch/arm/mach-mx1/Makefile
 delete mode 100644 arch/arm/mach-mx1/Makefile.boot
 delete mode 100644 arch/arm/mach-mx1/crm_regs.h
 delete mode 100644 arch/arm/mach-mx1/devices.c
 delete mode 100644 arch/arm/mach-mx1/devices.h
 delete mode 100644 arch/arm/mach-mx2/Kconfig
 delete mode 100644 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
 delete mode 100644 arch/arm/mach-mx2/serial.c
 create mode 100644 arch/arm/mach-mx25/devices-imx25.h
 create mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
 create mode 100644 arch/arm/mach-mx25/mach-cpuimx25.c
 rename arch/arm/mach-mx25/{mach-mx25pdk.c => mach-mx25_3ds.c} (76%)
 create mode 100644 arch/arm/mach-mx3/devices-imx31.h
 create mode 100644 arch/arm/mach-mx3/devices-imx35.h
 create mode 100644 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
 create mode 100644 arch/arm/mach-mx3/mach-cpuimx35.c
 rename arch/arm/mach-mx3/{mach-mx35pdk.c => mach-mx35_3ds.c} (89%)
 create mode 100644 arch/arm/mach-mx5/board-cpuimx51.c
 create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
 create mode 100644 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
 create mode 100644 arch/arm/plat-mxc/3ds_debugboard.c
 create mode 100644 arch/arm/plat-mxc/devices/Kconfig
 create mode 100644 arch/arm/plat-mxc/devices/Makefile
 create mode 100644 arch/arm/plat-mxc/devices/platform-flexcan.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-i2c.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-uart.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_nand.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-spi_imx.c
 create mode 100644 arch/arm/plat-mxc/include/mach/3ds_debugboard.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-armadillo5x0.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-kzmarm11.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx21ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27lite.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx27pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31_3ds.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx31ads.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-mx35pdk.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm037.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-pcm043.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/board-qong.h
 create mode 100644 arch/arm/plat-mxc/include/mach/devices-common.h
 rename arch/arm/plat-mxc/include/mach/{board-eukrea_cpuimx27.h => eukrea-baseboards.h} (64%)

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
