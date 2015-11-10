From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:20 -0800
Subject: [GIT PULL 2/6] ARM: SoC cleanups for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Again we have a sizable (but not huge) cleanup branch with a net delta of about
-3k lines.

Main contents here is:

- A bunch of development/cleanup of a few PXA boards
- Removal of bockw platforms on shmobile, since the platform has now gone
  completely multiplatform. Whee!
- move of the 32kHz timer on OMAP to a proper timesource
- Misc cleanup of older OMAP material (incl removal of one board file)
- Switch over to new common PWM lookup support for several platforms

There's also a handful of other cleanups across the tree, but the above are
the major pieces.



Conflicts:

OMAP timer code has a treewide fix vs code deletion conflict. Delete
the code in HEAD, go with contents from branch.

----------------------------------------------------------------

The following changes since commit 97f0fe6cec0cac661e1fc89ed2071fc5ab646c76:

  Merge tag 'armsoc-fixes-nc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to d3dc3df6330e4b4d799bef4aac6f934b5e726b1c:

  Merge tag 'omap-for-v4.4/soc-clean-up' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/cleanup

----------------------------------------------------------------

Andrzej Hajda (1):
      ARM: shmobile: apmu: correct type of CPU id

Arnd Bergmann (5):
      Merge tag 'renesas-cleanup-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'efm32-for-4.4-rc1' of git://git.pengutronix.de/git/ukl/linux into next/cleanup
      Merge tag 'mvebu-cleanup-4.4-1' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge tag 'omap-for-v4.4/cleanup-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      ARM: pxa: remove incorrect __init annotation on pxa27x_set_pwrmode

Felipe Balbi (13):
      arm: omap2: timer: always define omap4_local_timer_init
      arm: omap2: timer: get rid of obfuscating macros
      arm: omap2: timer: add a gptimer argument to sync32k_timer_init()
      arm: omap2: timer: remove __omap_gptimer_init()
      arm: omap2: timer: provide generic sync32k_timer_init function
      arm: omap2: timer: move realtime_counter_init() around
      arm: omap2: timer: always call clocksource_of_init() when DT
      arm: omap2: timer: rename omap_sync32k_timer_init()
      clocksource: add TI 32.768 Hz counter driver
      arm: omap2+: select 32k clocksource driver
      arm: omap2: timer: limit hwmod usage to non-DT boots
      clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
      arm: omap2: board-generic: use omap4_local_timer_init for AM437x

Franklin S Cooper Jr (2):
      ARM: DRA7/AM335x/AM437x: hwmod: Remove elm address space from hwmod data
      ARM: DRA7/AM335x/AM437x: hwmod: Remove gpmc address space from hwmod data

Geert Uytterhoeven (10):
      ARM: shmobile: Remove unused declaration of r8a7778_add_standard_devices_dt()
      ARM: shmobile: Remove obsolete sh-gpio.h
      ARM: shmobile: Remove obsolete custom earlyprintk code
      ARM: shmobile: Remove obsolete intc.h
      ARM: shmobile: Remove obsolete legacy PM Domain leftovers
      ARM: shmobile: Remove obsolete earlytimer registration
      ARM: shmobile: Remove obsolete twd_local_timer declaration
      ARM: shmobile: smp: Make shmobile_smp_apmu_cpu_shutdown() static
      ARM: shmobile: r8a7778: Make r8a7778_init_irq_dt() static
      ARM: shmobile: r8a7779: Remove legacy PM Domain remainings

Gregory CLEMENT (1):
      ARM: mvebu: Use a CR_C constant instead of a hard-coded one

Jarkko Nikula (1):
      ARM: pxa: Remove unused clock_enable field from struct pxa2xx_spi_master

Javier Martinez Canillas (3):
      ARM: OMAP3: vc: Remove unused macros
      ARM: OMAP2+: Remove unneeded semicolons
      ARM: OMAP: Remove duplicated operand in OR operation

Julia Lawall (1):
      ARM: shmobile: R-Mobile: add missing of_node_put

Keerthy (1):
      ARM: OMAP: Change all cpu_is_* occurences to soc_is_* for id.c

Ladislav Michl (1):
      ARM: OMAP1: Remove board support for VoiceBlue board

Laurent Pinchart (2):
      ARM: shmobile: Remove legacy clock support leftovers
      ARM: OMAP2+: Remove legacy OMAP3 ISP instantiation

Lee Jones (1):
      ARM: shmobile: dt: Rename incorrect interrupt related binding

Lucas Stach (1):
      ARM: mvebu: remove the workaround imprecise abort fault handler

Marc Zyngier (1):
      ARM: Remove open-coded version of IRQCHIP_DECLARE

Olof Johansson (4):
      Merge tag 'renesas-cleanup2-for-v4.4' of git://git.kernel.org/.../horms/renesas into next/cleanup
      Merge tag 'mvebu-cleanup-4.4-2' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge tag 'pxa-for-4.4' of https://github.com/rjarzmik/linux into next/cleanup
      Merge tag 'omap-for-v4.4/soc-clean-up' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup

Petr Cvek (22):
      ARM: pxa: magician: Fix indentation in machine files
      ARM: pxa: magician: Print more specific error message for global GPIOs
      ARM: pxa: magician: Optimize debug messages for LCD power
      ARM: pxa: magician: Change description of LCD power GPIO
      ARM: pxa: magician: Add new discovered EGPIO pins
      ARM: pxa: magician: Rename abstract LCD GPIOs
      ARM: pxa: magician: Optimize powerup delays for Samsung LCD
      ARM: pxa: magician: Rename charger cable detection EGPIOs
      ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
      ARM: pxa: magician: Fix and add charging detection functions
      ARM: pxa: magician: Fix platform data for both PXA27x I2C controllers
      ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
      ARM: pxa: magician: Fix support for Intel Strata NOR Flash
      ARM: pxa: magician: Fix wrongly enabled USB host ports
      ARM: pxa: magician: Remove definition of the STUART port
      ARM: pxa: magician: Add debug message for backlight brightness function
      ARM: pxa: magician: Add missing regulator for PWM backlight
      ARM: pxa: magician: Move platform_add_devices() to the end of magician_init()
      ARM: pxa: magician: Change comments to be more informative
      ARM: pxa: magician: Add support for MAX1587A Vcore regulator
      ARM: pxa: magician: Add support for PXA27x UDC
      ARM: pxa: magician: Remove pdata for pasic3-leds

Robert Jarzmik (2):
      ARM: pxa: add resources to pxaficp_ir
      ARM: pxa: mioa701: add wm9713 codec

Simon Horman (1):
      ARM: shmobile: remove Makefile.boot

Stephen Boyd (1):
      ARM: Remove __ref on hotplug cpu die path

Suman Anna (3):
      ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
      ARM: DRA7: hwmod data: Remove spinlock hwmod addrs
      ARM: OMAP3: hwmod data: Remove legacy mailbox data and addrs

Tero Kristo (1):
      ARM: OMAP3: clock: remove un-used core dpll re-program code

Thierry Reding (17):
      ARM: pxa: colibri-pxa270-income: Use PWM lookup table
      ARM: pxa: ezx: Use PWM lookup table
      ARM: pxa: hx4700: Remove unused field initializers
      ARM: pxa: lpd270: Use PWM lookup table
      ARM: pxa: magician: Use PWM lookup table
      ARM: pxa: mainstone: Use PWM lookup table
      ARM: pxa: mioa701: Use PWM lookup table
      ARM: pxa: palm27x: Use PWM lookup table
      ARM: pxa: palmte2: Use PWM lookup table
      ARM: pxa: pcm990: Use PWM lookup table
      ARM: pxa: raumfeld: Use PWM lookup table
      ARM: pxa: viper: Use PWM lookup table
      ARM: pxa: palmtc: Use PWM lookup table
      ARM: pxa: cm-x300: Use PWM lookup table
      ARM: pxa: tavorevb: Use PWM lookup table
      ARM: pxa: z2: Use PWM lookup table
      ARM: pxa: zylonite: Use PWM lookup table

Tony Lindgren (3):
      ARM: OMAP2+: Rename cpu_is macros to soc_is
      Merge branch 'for-tony' of git://git.kernel.org/.../balbi/usb into omap-for-v4.4/soc
      Merge tag 'for-v4.4/omap-hwmod-cleanup-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.4/soc

Ulrich Hecht (12):
      ARM: shmobile: bockw: remove "reference" device tree
      ARM: shmobile: bockw: remove "reference" board file and config
      ARM: shmobile: remove paragraph on DT reference platforms
      ARM: shmobile: bockw: remove legacy board file and config
      ARM: shmobile: r8a7778: remove obsolete setup code
      ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
      ARM: shmobile: r8a7778: remove legacy clock implementation
      ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
      ARM: shmobile: bockw: remove legacy defconfig
      MAINTAINERS: remove references to dropped marzen and bockw defconfigs
      ARM: shmobile: bockw: remove legacy DTB build target
      ARM: shmobile: Kconfig: remove unused SHMOBILE_TIMER_HZ section

Uwe Kleine-K?nig (3):
      ARM: efm32: switch to properly namespaced location property
      ARM: efm32: switch to vendor,device compatible strings
      ARM: pxa: raumfeld: make some variables static


 .../devicetree/bindings/arm/shmobile.txt        |   6 -
 .../renesas-memory-controllers.txt              |   6 +-
 Documentation/spi/pxa2xx                        |   6 -
 MAINTAINERS                                     |   2 -
 arch/arm/Kconfig                                |  26 +-
 arch/arm/Kconfig.debug                          |   3 +-
 arch/arm/boot/dts/Makefile                      |   3 -
 arch/arm/boot/dts/efm32gg-dk3750.dts            |   8 +-
 arch/arm/boot/dts/efm32gg.dtsi                  |  32 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts   | 139 ----
 arch/arm/configs/bockw_defconfig                | 133 ----
 arch/arm/kernel/psci_smp.c                      |   4 +-
 arch/arm/mach-exynos/suspend.c                  |   3 +-
 arch/arm/mach-imx/gpc.c                         |   8 +-
 arch/arm/mach-mvebu/board-v7.c                  |  35 -
 arch/arm/mach-mvebu/pmsu.c                      |   4 +-
 arch/arm/mach-omap1/Kconfig                     |   7 -
 arch/arm/mach-omap1/Makefile                    |   1 -
 arch/arm/mach-omap1/board-voiceblue.c           | 296 --------
 .../mach-omap1/include/mach/board-voiceblue.h   |  19 -
 arch/arm/mach-omap2/Kconfig                     |   1 +
 arch/arm/mach-omap2/Makefile                    |   3 -
 arch/arm/mach-omap2/board-generic.c             |  12 +-
 arch/arm/mach-omap2/board-ldp.c                 |   2 +-
 arch/arm/mach-omap2/board-rx51.c                |   2 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c          | 122 ---
 arch/arm/mach-omap2/common.h                    |   3 +-
 arch/arm/mach-omap2/devices.c                   |  53 --
 arch/arm/mach-omap2/devices.h                   |  19 -
 arch/arm/mach-omap2/id.c                        |  30 +-
 arch/arm/mach-omap2/omap-hotplug.c              |   2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c            |  10 +-
 .../omap_hwmod_33xx_43xx_interconnect_data.c    |  20 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |  29 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |  10 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |   3 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  30 -
 arch/arm/mach-omap2/pm44xx.c                    |   2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c     |   2 +-
 arch/arm/mach-omap2/soc.h                       | 195 ++---
 arch/arm/mach-omap2/sram.c                      |  25 -
 arch/arm/mach-omap2/sram.h                      |  14 -
 arch/arm/mach-omap2/sram34xx.S                  | 346 ---------
 arch/arm/mach-omap2/timer.c                     | 162 ++--
 arch/arm/mach-omap2/vc.c                        |   4 -
 arch/arm/mach-prima2/hotplug.c                  |   2 +-
 arch/arm/mach-pxa/cm-x300.c                     |   9 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c       |   9 +-
 arch/arm/mach-pxa/devices.c                     |  20 +
 arch/arm/mach-pxa/ezx.c                         |   9 +-
 arch/arm/mach-pxa/hx4700.c                      |   3 -
 arch/arm/mach-pxa/icontrol.c                    |   2 -
 arch/arm/mach-pxa/include/mach/magician.h       |  70 +-
 arch/arm/mach-pxa/include/mach/pxa27x.h         |   2 +-
 arch/arm/mach-pxa/lpd270.c                      |   9 +-
 arch/arm/mach-pxa/magician.c                    | 680 ++++++++++-------
 arch/arm/mach-pxa/mainstone.c                   |  19 +-
 arch/arm/mach-pxa/mioa701.c                     |  11 +-
 arch/arm/mach-pxa/palm27x.c                     |   9 +-
 arch/arm/mach-pxa/palmtc.c                      |   9 +-
 arch/arm/mach-pxa/palmte2.c                     |   9 +-
 arch/arm/mach-pxa/pcm990-baseboard.c            |   9 +-
 arch/arm/mach-pxa/pxa27x.c                      |   2 +-
 arch/arm/mach-pxa/raumfeld.c                    |  21 +-
 arch/arm/mach-pxa/tavorevb.c                    |  13 +-
 arch/arm/mach-pxa/viper.c                       |   9 +-
 arch/arm/mach-pxa/z2.c                          |  15 +-
 arch/arm/mach-pxa/zylonite.c                    |   9 +-
 arch/arm/mach-qcom/platsmp.c                    |   2 +-
 arch/arm/mach-realview/hotplug.c                |   2 +-
 arch/arm/mach-shmobile/Kconfig                  |  73 --
 arch/arm/mach-shmobile/Makefile                 |  14 +-
 arch/arm/mach-shmobile/Makefile.boot            |  12 -
 arch/arm/mach-shmobile/board-bockw-reference.c  |  86 ---
 arch/arm/mach-shmobile/board-bockw.c            | 737 -------------------
 arch/arm/mach-shmobile/clock-r8a7778.c          | 342 ---------
 arch/arm/mach-shmobile/clock.c                  |  47 --
 arch/arm/mach-shmobile/clock.h                  |  42 --
 arch/arm/mach-shmobile/common.h                 |   5 -
 arch/arm/mach-shmobile/console.c                |  27 -
 arch/arm/mach-shmobile/intc.h                   | 295 --------
 arch/arm/mach-shmobile/platsmp-apmu.c           |   4 +-
 arch/arm/mach-shmobile/pm-r8a7779.c             |  99 ---
 arch/arm/mach-shmobile/pm-rmobile.c             |   4 +-
 arch/arm/mach-shmobile/pm-rmobile.h             |   9 -
 arch/arm/mach-shmobile/r8a7778.h                |  78 --
 arch/arm/mach-shmobile/r8a7779.h                |   8 -
 arch/arm/mach-shmobile/setup-r8a7778.c          | 563 +-------------
 arch/arm/mach-shmobile/sh-gpio.h                |  29 -
 arch/arm/mach-shmobile/timer.c                  |  21 -
 arch/arm/mach-spear/hotplug.c                   |   2 +-
 arch/arm/mach-tegra/hotplug.c                   |   2 +-
 arch/arm/mach-ux500/hotplug.c                   |   2 +-
 arch/arm/mach-vexpress/hotplug.c                |   2 +-
 drivers/clocksource/Kconfig                     |   8 +
 drivers/clocksource/Makefile                    |   1 +
 drivers/clocksource/timer-ti-32k.c              | 126 ++++
 include/linux/spi/pxa2xx_spi.h                  |   1 -
 98 files changed, 1002 insertions(+), 4433 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 delete mode 100644 arch/arm/configs/bockw_defconfig
 delete mode 100644 arch/arm/mach-omap1/board-voiceblue.c
 delete mode 100644 arch/arm/mach-omap1/include/mach/board-voiceblue.h
 delete mode 100644 arch/arm/mach-omap2/clkt34xx_dpll3m2.c
 delete mode 100644 arch/arm/mach-omap2/devices.h
 delete mode 100644 arch/arm/mach-omap2/sram34xx.S
 delete mode 100644 arch/arm/mach-shmobile/Makefile.boot
 delete mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-bockw.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7778.c
 delete mode 100644 arch/arm/mach-shmobile/clock.c
 delete mode 100644 arch/arm/mach-shmobile/clock.h
 delete mode 100644 arch/arm/mach-shmobile/console.c
 delete mode 100644 arch/arm/mach-shmobile/intc.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7778.h
 delete mode 100644 arch/arm/mach-shmobile/sh-gpio.h
 create mode 100644 drivers/clocksource/timer-ti-32k.c
