From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Feb 2016 14:19:59 -0800
Subject: [GIT PULL] ARM: SoC fixes for v4.5-rc
Message-ID: <20160207221959.GA11382@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit 36f90b0a2ddd60823fe193a85e60ff1906c2a9b3:

  Linux 4.5-rc2 (2016-01-31 18:12:16 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 381a65c21aa1fcf4f3fafe70027b79b303bdb71d:

  ARM: multi_v7_defconfig: enable DW_WATCHDOG (2016-02-04 13:25:33 -0800)

----------------------------------------------------------------
ARM: SoC fixes for v4.5-rc

The first real batch of fixes for this release cycle, so there are a few more
than usual.

Most of these are fixes and tweaks to board support (DT bugfixes, etc). I've
also picked up a couple of small cleanups that seemed innocent enough that
there was little reason to wait (const/__initconst and Kconfig deps).

Quite a bit of the changes on OMAP were due to fixes to no longer write to
rodata from assembly when ARM_KERNMEM_PERMS was enabled, but there were also
other fixes.

Kirkwood had a bunch of gpio fixes for some boards. OMAP had RTC fixes
on OMAP5, and Nomadik had changes to MMC parameters in DT.

All in all, mostly the usual mix of various fixes.

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: Fix wl12xx missing clocks that cause hangs
      ARM: dts: LogicPD Torpedo: Revert Duplicative Entries

Alexandre Belloni (2):
      ARM: dts: at91: at91sam9n12ek: fix panel compatible string
      ARM: dts: at91: sama5d4 xplained: properly mux phy interrupt

Amitoj Kaur Chawla (1):
      bus: vexpress-config: Add missing of_node_put

Dave Gerlach (1):
      ARM: dts: AM33xx: Add ti,mbox-send-noirq to wkup_m3 mailbox

Dinh Nguyen (1):
      ARM: multi_v7_defconfig: enable DW_WATCHDOG

Dmitry Lifshitz (6):
      ARM: dts: am57xx: sbc-am57x: fix SB-SOM EEPROM I2C address
      ARM: dts: am57xx: cl-som-am57x: set HOST mode for USB2
      ARM: dts: am57xx: cl-som-am57x: update SPI Flash frequency
      ARM: dts: am57xx: sbc-am57x: fix UART3 pinmux
      ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
      ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings

Felipe Balbi (1):
      ARM: omap2plus_defconfig: enable SPLIT and DWARF4

Geert Uytterhoeven (2):
      ARM: mvebu: kirkwood: Add compatible property to "partitions" node
      ARM: mvebu: ix4-300d: Add compatible property to "partitions" node

Grygorii Strashko (2):
      ARM: dts: am4372: fix irq type for arm twd and global timer
      ARM: dts: am437x: pixcir_tangoc: use correct flags for irq types

H. Nikolaus Schaller (1):
      ARM: dts: omap5-board-common: enable rtc and charging of backup battery

Jon Hunter (1):
      ARM64: tegra: Add chosen node for tegra132 norrin

Keerthy (1):
      ARM: dts: AM4372: Add ti,mbox-send-noirq to wkup_m3 mailbox

Linus Walleij (1):
      ARM: nomadik: fix up SD/MMC DT settings

Masahiro Yamada (5):
      bus: uniphier-system-bus: revive tristate prompt
      ARM: realview: use const and __initconst for smp_operations
      ARM: tango: use const and __initconst for smp_operations
      ARM: tango: use "depends on" instead of "if" after prompt
      ARM: realview: use "depends on" instead of "if" after prompt

Mohamed Jamsheeth Hajanajubudeen (1):
      ARM: dts: at91: sama5d4: fix instance id of DBGU

Neil Armstrong (1):
      ARM: OMAP: Add PWM dmtimer platform data quirks

Nicolas Ferre (2):
      ARM: dts: at91: sama5d2 xplained: add phy address and IRQ for macb0
      ARM: dts: at91: sama5d4 xplained: fix phy0 IRQ type

Olof Johansson (4):
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'omap-for-v4.5/fixes-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'mvebu-fixes-4.5-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'vexpress-for-v4.5/fixes-rc2' of git://git.kernel.org/.../sudeep.holla/linux into fixes

Robin Murphy (1):
      arm64: dts: Add missing DMA Abort interrupt to Juno

Roger Shimizu (5):
      ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wxl/wsxl
      ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wvl/vl
      ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wxl/wsxl
      ARM: dts: kirkwood: gpio-leds fixes for linkstation ls-wvl/vl
      ARM: dts: orion5x: gpio pin fixes for linkstation lswtgl

Suman Anna (1):
      ARM: OMAP2+: Remove legacy mailbox device instantiation

Tony Lindgren (8):
      ARM: dts: Fix omap5 PMIC control lines for RTC writes
      ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
      ARM: OMAP2+: Fix l2dis_3630 for rodata
      ARM: OMAP2+: Fix save_secure_ram_context for rodata
      ARM: OMAP2+: Fix l2_inv_api_params for rodata
      ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for rodata
      ARM: omap2plus_defconfig: Enable ARM_KERNMEM_PERMS and few loadable modules
      Merge branch 'enable-devices' into omap-for-v4.5/fixes

Wenyou Yang (1):
      ARM: dts: at91: sama5d4ek: add phy address and IRQ for macb0

 arch/arm/boot/dts/am33xx.dtsi                    |  1 +
 arch/arm/boot/dts/am4372.dtsi                    |  5 +-
 arch/arm/boot/dts/am437x-gp-evm.dts              |  4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts             |  2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts        | 12 ++---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts           |  8 ++--
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  1 +
 arch/arm/boot/dts/at91-sama5d2_xplained.dts      | 12 ++++-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts      |  8 +++-
 arch/arm/boot/dts/at91-sama5d4ek.dts             | 11 +++++
 arch/arm/boot/dts/at91sam9n12ek.dts              |  2 +-
 arch/arm/boot/dts/kirkwood-lswvl.dts             | 25 +++++-----
 arch/arm/boot/dts/kirkwood-lswxl.dts             | 31 ++++++------
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts |  1 +
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi       |  9 +---
 arch/arm/boot/dts/omap5-board-common.dtsi        | 33 +++++++++++++
 arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts |  8 ++--
 arch/arm/boot/dts/sama5d4.dtsi                   |  2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi       | 37 +++++++-------
 arch/arm/configs/multi_v7_defconfig              |  1 +
 arch/arm/configs/omap2plus_defconfig             | 10 ++++
 arch/arm/mach-omap2/devices.c                    | 28 -----------
 arch/arm/mach-omap2/pdata-quirks.c               | 23 +++++++++
 arch/arm/mach-omap2/sleep34xx.S                  | 61 ++++++++++++------------
 arch/arm/mach-omap2/sleep44xx.S                  | 25 ++++++----
 arch/arm/mach-realview/Kconfig                   |  3 +-
 arch/arm/mach-realview/platsmp-dt.c              |  2 +-
 arch/arm/mach-tango/Kconfig                      |  3 +-
 arch/arm/mach-tango/platsmp.c                    |  2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi           |  1 +
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts   |  2 +
 drivers/bus/Kconfig                              |  2 +-
 drivers/bus/vexpress-config.c                    |  4 +-
 33 files changed, 230 insertions(+), 149 deletions(-)
