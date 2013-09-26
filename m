From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Sep 2013 12:45:53 +0200
Subject: [GIT PULL] ux500 device tree changes for v3.13 take 2
Message-ID: <CACRpkdYdguwxau-NRRP1mEOzdRTecYuz+RV_j7-VCEUTK-NN3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

This is a second version of the pull request from yesterday, now
with a (hopefully) sanitized history, and a patch on top of it fixing
a build problem that I just sent out.

Please pull this in for v3.13!

Yours,
Linus Walleij

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-for-v3.13-2

for you to fetch changes up to c44c8e9d96b9aa8624409d6098f16dabc4afc6c2:

  ARM: ux500: delete devices-common remnants (2013-09-26 11:24:16 +0200)

----------------------------------------------------------------
This is a huge device tree and ATAG removal series for ux500:
- Move all the clock definitions over to the device tree
- Remove all now-redundant AUXDATA and make the ux500 device
  tree only

----------------------------------------------------------------
Lee Jones (88):
      ARM: ux500: Remove PrimeCell IDs from Nomadik I2C DT nodes
      mfd: dbx500-prcmu: Correctly reorder PRCMU clock identifiers
      mfd: dbx500-prcmu: Move PRCMU numerical clock identifiers into
DT include file
      mfd: dbx500: Remove any mention of the BML8580CLK
      ARM: ux500: Add PRCMU clock node to DBx500 Device Tree
      ARM: ux500: Supply the DMA clock lookup to the DBX500 DT
      ARM: ux500: Add PRCC Peripheral clock node to DBx500 Device Tree
      ARM: ux500: Supply the GPIO clocks lookup to the DBX500 DT
      ARM: ux500: Supply the USB clock lookup to the DBX500 DT
      ARM: ux500: Supply the Ethernet clock lookup to Snowball's DT
      ARM: ux500: Add PRCC Kernel clock node to DBx500 Device Tree
      ARM: ux500: Supply the I2C clocks lookup to the DBX500 DT
      ARM: ux500: Supply the UART clocks lookup to the DBX500 DT
      ARM: ux500: Supply the SDI (MMC) clocks lookup to the DBX500 DT
      ARM: ux500: Supply the MSP (Audio) clocks lookup to the DBX500 DT
      ARM: ux500: Add RTC (fixed-frequency) clock node to DBx500 Device Tree
      ARM: ux500: Supply the RTC clock lookup to the DBX500 DT
      ARM: ux500: Add TWD (fixed-factor) clock node to DBx500 Device Tree
      ARM: ux500: Supply the TWD Timer clock lookup to the DBX500 DT
      ARM: ux500: Add a DT node for the Nomadik System Timer (MTU0)
      ARM: ux500: Don't attempt to enable the Nomadik System Timer twice
      clk: ux500: Remove BML8580 clock
      clk: ux500: Copy u8500_clk_init() ready for DT enablement
      clk: ux500: Provide u8500_clk with skeleton Device Tree support
      clk: ux500: Add a 2-cell Device Tree parser for obtaining PRCC clocks
      clk: ux500: Add Device Tree support for the PRCMU clock
      clk: ux500: Add Device Tree support for the PRCC Peripheral clock
      clk: ux500: Add Device Tree support for the PRCC Kernel clock
      clk: ux500: Add Device Tree support for the RTC clock
      clk: ux500: Add Device Tree support for the TWD clock
      usb: musb: ux500: Don't supply a con_id when requesting the clock
      ARM: ux500: Call appropriate clock initialisation based on DT or
!DT booting
      ARM: ux500: Remove AUXDATA relating to GPIO clock-name bindings
      ARM: ux500: Remove AUXDATA relating to UART clock-name bindings
      ARM: ux500: Remove AUXDATA relating to I2C clock-name bindings
      ARM: ux500: Relocate AUXDATA relating to MSP (Audio)
      ARM: ux500: Remove AUXDATA relating to SDI (MMC) clock-name bindings
      ARM: ux500: Remove AUXDATA relating to USB clock-name bindings
      ARM: ux500: Remove AUXDATA relating to Ethernet clock-name bindings
      ARM: ux500: Remove AUXDATA relating to DMA clock-name bindings
      ARM: ux500: Reclassify PRCMU AUXDATA entry
      ARM: ux500: Remove SSP AUXDATA pertaining to DMA bindings
      ARM: ux500: Remove Audio/MSP support when booting with ATAGs
      ARM: ux500: Remove TPS61052 High Power White LED Driver ATAG support
      ARM: ux500: Remove ATAG support for LP5521 Programmable
Three-Channel LED driver
      ARM: ux500: Remove ATAG booting support for Snowball's heatbeat LED
      ARM: ux500: Purge support for Snowball user buttons when booting
with ATAGs
      ARM: ux500: Disable Snowball's SMSC911x Ethernet when booting with ATAGs
      ARM: ux500: Remove support for Snowball's Ethernet regulator
when booting with ATAGs
      ARM: ux500: Disable Snowball's CPUFreq functionality when
booting with ATAGs enabled
      ARM: ux500: Purge SDI regulator support when booting with ATAGs enable
      ARM: ux500: Deactivate Crypt support when booting with ATAGs
      ARM: ux500: Rip out Hash support when booting with ATAGs
      ARM: ux500: Prevent CODEC platform data from being passed when
booting ATAGs
      ARM: ux500: Stop passing GPIO pdata when booitng with ATAGs enabled
      ARM: ux500: Remove TC35892 Flexible IO Expander when booting ATAGs
      ARM: ux500: Remove Light sensor Rohm BH1780GLI when booting with ATAGs
      ARM: ux500: Purge SFH7741 Proximity Sensor support when booting with ATAGs
      ARM: ux500: Remove I2C support when booting with ATAG support
      ARM: ux500: Purge SDI support for ATAG booting
      ARM: ux500: Rip out keypad initialisation which is no longer used
      ARM: ux500: Remove USB support when booting using ATAGs
      ARM: ux500: Purge support for registering the RTC when booting with ATAGs
      ARM: ux500: Stop registering Pinctrl when booting with ATAG support
      ARM: ux500: Stop enabling GPIOs when not booting with Device Tree
      ARM: ux500: Deactivate enablement of DMA40 during ATAG booting
      ARM: ux500: Do not register the PMU device if booting with ATAGs
      ARM: ux500: Rip out SSP/SPI registration when not booting with Device Tree
      ARM: ux500: Stop initialising the pinmaps when booting with ATAGs
      ARM: ux500: Remove UART support when booting without Device Tree
      ARM: ux500: Stop requesting the SoC device to play 'parent' role
      ARM: ux500: Purge DB8500 PRCMU registration when not booting with DT
      ARM: ux500: Don't register Synaptics RMI4 TS when booting with ATAGs
      ARM: ux500: Delete U8500 UIB support when booting with ATAGs
      ARM: ux500: Don't register the STMPE/SKE when booting with ATAG support
      ARM: ux500: Remove BU21013 ROHM TS support when booting with only ATAGs
      ARM: ux500: Take out STUIB support when not booting with Device Tree
      ARM: ux500: Purge UIB framework when booting with ATAGs
      ARM: ux500: Remove ATAG booting support for MOP500
      ARM: ux500: Remove ATAG booting support for U8520
      ARM: ux500: Remove ATAG booting support for HREF
      ARM: ux500: Remove ATAG booting support for Snowball
      ARM: ux500: Fix trivial white-space error in the DBX500 DTSI file
      ARM: ux500: Provide a clock lookup for the Crypto driver
      ARM: ux500: Provide a clock lookup for the Hash driver
      ARM: ux500: Provide a Device Tree node for CPUFreq in the DBx500
      ARM: ux500: Enable CPUFreq on Snowball
      clk: ux500: Provide a look-up for the ARMSS clock

Linus Walleij (3):
      ARM: ux500: delete surplus PRCMU regulator defines
      ARM: ux500: skip redefined regulator names on v60plus board
      ARM: ux500: delete devices-common remnants

Sebastian Andrzej Siewior (1):
      dt: dbx5x0: remove mentor,musb binding

 .../devicetree/bindings/usb/ux500-usb.txt          |   2 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 141 ++++-
 arch/arm/boot/dts/ste-href.dtsi                    |  82 ---
 arch/arm/boot/dts/ste-hrefv60plus.dts              | 132 -----
 arch/arm/boot/dts/ste-snowball.dts                 |  85 +--
 arch/arm/mach-ux500/Makefile                       |   5 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |  50 --
 arch/arm/mach-ux500/board-mop500-sdi.c             |  51 --
 arch/arm/mach-ux500/board-mop500-stuib.c           | 120 ----
 arch/arm/mach-ux500/board-mop500-u8500uib.c        |  92 ---
 arch/arm/mach-ux500/board-mop500-uib.c             | 133 -----
 arch/arm/mach-ux500/board-mop500.c                 | 637 ---------------------
 arch/arm/mach-ux500/board-mop500.h                 |  16 -
 arch/arm/mach-ux500/cpu-db8500.c                   | 124 +---
 arch/arm/mach-ux500/cpu.c                          |  19 +-
 arch/arm/mach-ux500/devices-common.c               |  60 --
 arch/arm/mach-ux500/devices-common.h               | 149 -----
 arch/arm/mach-ux500/devices-db8500.c               |  94 ---
 arch/arm/mach-ux500/devices-db8500.h               | 110 ----
 arch/arm/mach-ux500/devices.h                      |   8 -
 arch/arm/mach-ux500/setup.h                        |   1 -
 arch/arm/mach-ux500/timer.c                        |   4 +-
 arch/arm/mach-ux500/usb.c                          | 135 -----
 drivers/clk/ux500/Makefile                         |   1 +
 drivers/clk/ux500/u8500_of_clk.c                   | 559 ++++++++++++++++++
 drivers/clk/ux500/u8540_clk.c                      |   2 +-
 drivers/mfd/db8500-prcmu.c                         |   1 -
 drivers/mfd/dbx500-prcmu-regs.h                    |   1 -
 drivers/usb/musb/ux500.c                           |   2 +-
 include/dt-bindings/mfd/dbx500-prcmu.h             |  83 +++
 include/linux/mfd/dbx500-prcmu.h                   |  70 +--
 include/linux/platform_data/clk-ux500.h            |   3 +
 32 files changed, 811 insertions(+), 2161 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-stuib.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-u8500uib.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-uib.c
 delete mode 100644 arch/arm/mach-ux500/devices-common.c
 delete mode 100644 arch/arm/mach-ux500/devices-common.h
 delete mode 100644 arch/arm/mach-ux500/usb.c
 create mode 100644 drivers/clk/ux500/u8500_of_clk.c
 create mode 100644 include/dt-bindings/mfd/dbx500-prcmu.h
