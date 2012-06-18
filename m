From: stigge@antcom.de (Roland Stigge)
Date: Mon, 18 Jun 2012 23:01:49 +0200
Subject: [GIT PULL] ARM: LPC32xx specific updates for next
Message-ID: <4FDF973D.8010600@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

this is the pull request for the 22 patches we discussed last week, still same
commits in the same branch (the 23rd patch was removed from the series, as
discussed on the list).

This time, purely mach-lpc32xx specific patches.

Please tell if sth. is missing, so I can know if I can build upon that. (I'm
already collecting new patches on top of this branch.)

Thanks in advance,

Roland



The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.antcom.de/linux-2.6.git lpc32xx-next

for you to fetch changes up to df072717eb0050326f0f63eed98200412c395831:

  ARM: LPC32xx: Move i2s1 dma enabling to clock.c (2012-06-14 16:16:19 +0200)

----------------------------------------------------------------
Alexandre Pereira da Silva (7):
      ARM: LPC32xx: Build arch dtbs
      ARM: LPC32xx: Add dt settings to the at25 node
      ARM: LPC32xx: Remove spi chipselect request from board init
      ARM: LPC32xx: Remove spi chip definitions
      ARM: LPC32xx: Cleanup board init, remove duplicate clock init
      ARM: LPC32xx: Move uart6 irda disable to serial.c
      ARM: LPC32xx: Move i2s1 dma enabling to clock.c

Roland Stigge (15):
      ARM: LPC32xx: Add NAND flash timing to PHY3250 board dts
      ARM: LPC32xx: Clock initialization for NAND controllers
      ARM: LPC32xx: Remove SLC controller initialization from platform init
      ARM: LPC32xx: Add DMA configuration to platform data
      ARM: LPC32xx: Adjust dtsi file for MLC controller configuration
      ARM: LPC32xx: Add dts for EA3250 reference board
      ARM: LPC32xx: DTS adjustment for key matrix controller
      ARM: LPC32xx: Clock adjustment for key matrix controller
      ARM: LPC32xx: Defconfig update
      ARM: LPC32xx: Add MMC controller support
      ARM: LPC32xx: DTS adjustment for using pl18x primecell
      ARM: LPC32xx: DT conversion of Standard UARTs
      ARM: LPC32xx: High Speed UART configuration via DT
      ARM: LPC32xx: Remove mach specific ARCH_NR_GPIOS, use default
      ARM: LPC32xx: Fix lpc32xx.dtsi status property: "disable" -> "disabled"

 arch/arm/Kconfig                          |    2 -
 arch/arm/boot/dts/ea3250.dts              |  157 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/lpc32xx.dtsi            |   74 +++++++++-----
 arch/arm/boot/dts/phy3250.dts             |   61 +++++++++++
 arch/arm/configs/lpc32xx_defconfig        |   24 +++--
 arch/arm/mach-lpc32xx/Kconfig             |   32 ------
 arch/arm/mach-lpc32xx/Makefile.boot       |    1 +
 arch/arm/mach-lpc32xx/clock.c             |   21 +++-
 arch/arm/mach-lpc32xx/include/mach/gpio.h |    2 -
 arch/arm/mach-lpc32xx/phy3250.c           |  158 ++++++++++++-----------------
 arch/arm/mach-lpc32xx/serial.c            |   90 ++--------------
 11 files changed, 376 insertions(+), 246 deletions(-)
 create mode 100644 arch/arm/boot/dts/ea3250.dts
 delete mode 100644 arch/arm/mach-lpc32xx/Kconfig
