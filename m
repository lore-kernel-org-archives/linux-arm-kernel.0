From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 22:56:22 +0100
Subject: ARM: SoC fixes for 4.4-rc
Message-ID: <4945168.2B7gAcBDsf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to a405fd1b1fd2f96ab7c57a600d3c21f4eae6882c:

  Merge tag 'v4.4-rockchip-dts32-fixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into fixes (2015-11-27 17:41:48 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 4.4-rc

There is a small backlog of at91 patches here, the most significant is
the addition of some sama5d2 Xplained nodes that were waiting on an MFD include
file to get merged through another tree. We normally try to sort those out
before the merge window opens, but the maintainer wasn't aware of that here
and I decided to merge the changes this time as an exception.

On OMAP a series of audio changes for dra7 missed the merge window but turned
out to be necessary to fix a boot time imprecise external abort error and to
get audio working.

The other changes are the usual simple changes, here is a list sorted by
platform:

at91:
	removal of a useless defconfig option
	removal of some legacy DT pieces
	use of the proper watchdog compatible string
	update of the MAINTAINERS entries for some Atmel drivers
drivers/scpi:
	hide get_scpi_ops in module from built-in code
imx:
	add missing .irq_set_type for i.MX GPC irq_chip.
	fix the wrong spi-num-chipselects settings for Vybrid DSPI devices.
	fix a merge error in Vybrid dts regarding to ADC device property
keystone:
        fix the optional PDSP firmware loading
        fix linking RAM setup for QMs
        fix crash with clk_ignore_unused
mediatek:
	Enable SCPSYS power domain driver by default
mvebu:
	fix QNAP TS219 power-off in dts
	fix legacy get_irqnr_and_base for dove and orion5x
omap:
	fix l4 related boot time errors for dm81xx
	use lockless cldm/pwrdm api in omap4_boot_secondary
	remove t410 abort handler to avoid hiding other critical errors
	mark cpuidle tracepoints as _rcuidle
	fix module alias for omap-ocp2scp
pxa:
	palm: Fix typos in PWM lookup table code
renesas:
	missing __initconst annotation for r8a7793_boards_compat_dt
rockchip:
	disable mmc-tuning on the veyron-minnie board
	adding the init state for the over-temperature-protection
zx:
	only build power domain code when CONFIG_PM=y

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91/dt: remove leftovers clock definition
      ARM: at91/dt: remove bootargs

Anson Huang (1):
      ARM: imx: add platform irq type setting in gpc

Arnd Bergmann (10):
      ARM: zx: only build power domain code when CONFIG_PM=y
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      scpi: hide get_scpi_ops in module from built-in code
      Merge tag 'imx-fixes-4.4' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'v4.4-rc2' into fixes
      Merge tag 'keystone-fixes-for-4.4' of git://git.kernel.org/.../ssantosh/linux-keystone into fixes
      Merge tag 'omap-for-v4.4/fixes-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'renesas-fixes-for-v4.4' of git://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'mvebu-fixes-4.4-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'v4.4-rockchip-dts32-fixes1' of git://git.kernel.org/.../mmind/linux-rockchip into fixes

Axel Lin (1):
      bus: omap-ocp2scp: Fix module alias

Caesar Wang (1):
      ARM: dts: rockchip: Add OTP gpio pinctrl to rk3288 tsadc node

Cory Tusar (1):
      ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects.

Eddie Huang (1):
      soc: Mediatek: Enable SCPSYS power domain driver by default

Grygorii Strashko (1):
      ARM: OMAP4+: SMP: use lockless clkdm/pwrdm api in omap4_boot_secondary

Heiko Stuebner (1):
      ARM: dts: rockchip: temporarily remove emmc hs200 speed from rk3288 minnie

Helmut Klein (1):
      ARM: dts: Kirkwood: Fix QNAP TS219 power-off

Jisheng Zhang (1):
      ARM: OMAP2+: PM: Denote the cpuidle tracepoints as _rcuidle()

Lucas Stach (1):
      ARM: OMAP2+: remove custom abort handler for t410

Ludovic Desroches (1):
      ARM: at91/dt: sama5d2 Xplained: add several devices

Michal Morawiec (1):
      soc: ti: knav_qmss_queue: Fix linking RAM setup for queue managers

Murali Karicheri (2):
      soc: ti: use request_firmware_direct() as acc firmware is optional
      ARM: dts: keystone: k2l: fix kernel crash when clk_ignore_unused is not in bootargs

Neil Armstrong (1):
      arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data

Nicolas Ferre (2):
      ARM: at91/defconfig: remove CONFIG_SSB from Atmel defconfigs
      MAINTAINERS: Atmel drivers: change NAND and ISI entries

Nicolas Pitre (3):
      ARM: shmobile: r8a7793: proper constness with __initconst
      ARM: dove: Fix legacy get_irqnr_and_base
      ARM: orion5x: Fix legacy get_irqnr_and_base

Peter Ujfalusi (3):
      ARM: dts: dra7: Fix McASP3 node regarding to clocks
      ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
      ARM: OMAP: DRA7: hwmod: Add data for McASP3

Sanchayan Maity (1):
      ARM: dts: vfxxx: Fix erroneous property in esdhc0 node

Sudeep Holla (1):
      ARM: at91/dt: replace gpio-key,wakeup with wakeup-source property

Thierry Reding (1):
      ARM: pxa: palm: Fix typos in PWM lookup table code

Tony Lindgren (2):
      Merge branch 'x15-audio-fixes' into omap-for-v4.4/fixes
      Merge branch '81xx' into omap-for-v4.4/fixes

Wenyou Yang (1):
      ARM: at91/dt: sama5d4: change watchdog compatible

 Documentation/arm/keystone/Overview.txt          |  18 ----
 MAINTAINERS                                      |   5 +-
 arch/arm/boot/dts/animeo_ip.dts                  |   6 +-
 arch/arm/boot/dts/at91-foxg20.dts                |   2 +-
 arch/arm/boot/dts/at91-kizbox.dts                |  13 +--
 arch/arm/boot/dts/at91-kizbox2.dts               |   6 +-
 arch/arm/boot/dts/at91-kizboxmini.dts            |   4 +-
 arch/arm/boot/dts/at91-qil_a9260.dts             |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts      | 115 +++++++++++++++++++++--
 arch/arm/boot/dts/at91-sama5d3_xplained.dts      |   2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts      |  12 +--
 arch/arm/boot/dts/at91-sama5d4ek.dts             |  12 +--
 arch/arm/boot/dts/at91rm9200ek.dts               |   9 --
 arch/arm/boot/dts/at91sam9261ek.dts              |  19 +---
 arch/arm/boot/dts/at91sam9263ek.dts              |  13 +--
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi      |  13 +--
 arch/arm/boot/dts/at91sam9m10g45ek.dts           |  13 +--
 arch/arm/boot/dts/at91sam9n12ek.dts              |  11 +--
 arch/arm/boot/dts/at91sam9rlek.dts               |  13 +--
 arch/arm/boot/dts/at91sam9x5cm.dtsi              |  11 ---
 arch/arm/boot/dts/dra7.dtsi                      |   4 +-
 arch/arm/boot/dts/k2l-netcp.dtsi                 |   2 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts       |   4 +
 arch/arm/boot/dts/rk3288.dtsi                    |  10 +-
 arch/arm/boot/dts/sama5d35ek.dts                 |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                   |   2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi          |   2 +-
 arch/arm/boot/dts/usb_a9263.dts                  |   2 +-
 arch/arm/boot/dts/vfxxx.dtsi                     |   8 +-
 arch/arm/configs/at91_dt_defconfig               |   1 -
 arch/arm/configs/sama5_defconfig                 |   1 -
 arch/arm/mach-dove/include/mach/entry-macro.S    |   4 +-
 arch/arm/mach-imx/gpc.c                          |   1 +
 arch/arm/mach-omap2/omap-smp.c                   |   6 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |  66 +++++++------
 arch/arm/mach-omap2/omap_hwmod.h                 |   3 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c        |  56 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c       |   3 +
 arch/arm/mach-omap2/pdata-quirks.c               |  29 ------
 arch/arm/mach-omap2/pm34xx.c                     |   4 +-
 arch/arm/mach-orion5x/include/mach/entry-macro.S |   2 +-
 arch/arm/mach-pxa/palm27x.c                      |   2 +-
 arch/arm/mach-pxa/palmtc.c                       |   2 +-
 arch/arm/mach-shmobile/setup-r8a7793.c           |   2 +-
 arch/arm/mach-zx/Kconfig                         |   2 +-
 drivers/bus/omap-ocp2scp.c                       |   2 +-
 drivers/soc/mediatek/Kconfig                     |   1 +
 drivers/soc/ti/knav_qmss_queue.c                 |   8 +-
 include/linux/scpi_protocol.h                    |   2 +-
 50 files changed, 280 insertions(+), 254 deletions(-)
