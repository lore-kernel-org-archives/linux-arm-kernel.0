From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:48 -0700
Subject: [GIT PULL 2/7] ARM: SoC platform updates
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC platform changes (arch/arm/mach-*). This merge window, the bulk is
for a few platforms:

* Gemini:
- Legacy platform that Linus Walleij has converted to multiplatform
and DT, so a handful of various tweaks there, removal of some old
stale support, etc.

* Atmel AT91:
- Fixup of various power management related pieces
- Move of SoC detection to a drivers/soc driver instead

* ST Micro STM32:
- New SoC support: STM32H743

* TI platforms:
- More driver support for Davinci (SATA in particular)
- Removal of some old stale hwmod files (linkspace platform)

* Misc:
- A couple of smaller patches for i.MX, sunxi, hisi

----------------------------------------------------------------

The following changes since commit 34626f295943b370e40405eb77a5b9f7fe221c5f:

  Merge tag 'armsoc-fixes-nc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 17e310b8eef519c998b7ed80f11c212a86785dea:

  Merge tag 'davinci-for-v4.12/soc-3' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into next/soc

----------------------------------------------------------------

Al Cooper (1):
      ARM: brcmstb: Enable ZONE_DMA for non 64-bit capable peripherals

Alexandre Bailon (1):
      ARM: davinci: Add clock for CPPI 4.1 DMA engine

Alexandre Belloni (14):
      MAINTAINERS: Update AT91 entry
      MAINTAINERS: Add memory drivers to AT91 entry
      ARM: at91: pm: Cleanup headers
      ARM: at91: pm: Move at91_ramc_read/write to pm.c
      ARM: at91: pm: Move global variables into at91_pm_data
      ARM: at91: pm: Use struct at91_pm_data in pm_suspend.S
      ARM: at91: pm: Simplify at91rm9200_standby
      ARM: at91: pm: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.
      ARM: at91: pm: Tie the memory controller type to the ramc id
      ARM: at91: pm: Tie the USB clock mask to the pmc
      ARM: at91: pm: Merge all at91sam9*_pm_init
      ARM: at91: pm: Remove at91_pm_set_standby
      ARM: at91: pm: correct typo
      ARM: at91: move SoC detection to its own driver

Alexandre TORGUE (3):
      ARM: stm32: create dedicated kconfig for STM32 machine
      ARM: stm32: Introduce MACH_STM32H743 flag
      ARM: stm32: Add a new SOC - STM32H743

Arnd Bergmann (6):
      ARM: gemini: don't select SERIAL_OF_PLATFORM
      ARM: OMAP2+: mark omap_init_rng as __init
      Merge tag 'davinci-for-v4.12/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'omap-for-v4.12/soc-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'gemini-multiplat-2' of git://git.kernel.org/.../linusw/linux-nomadik into next/soc
      Merge tag 'arm-soc/for-4.12/soc' of http://github.com/Broadcom/stblinux into next/soc

Bartosz Golaszewski (3):
      ARM: davinci: allow having multiple pdata-quirks
      ARM: da850-evm: add a fixed regulator for the UI board IO expander
      ARM: davinci: add pdata-quirks for da850-evm vpif display

Danesh Petigara (1):
      ARM: brcmstb: Enable ARCH_HAS_HOLES_MEMORYMODEL

Florian Fainelli (1):
      ARM: brcmstb: Add entry for 7260

Geert Uytterhoeven (2):
      ARM: davinci: PM: Drop useless check for PM_SUSPEND_STANDBY
      ARM: OMAP: PM: Drop useless checks for PM_SUSPEND_STANDBY

Greg Ungerer (1):
      ARM: imx: set correct chip_select in platform setup

Kevin Hilman (4):
      ARM: davinci: board-da850-evm: add I2C ID for VPIF
      ARM: davinci: da8xx: add OF_DEV_AUXDATA() for vpif
      ARM: davinci: da8xx: add pdata-quirks for VPIF capture
      ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA

Linus Walleij (8):
      ARM: gemini: convert to MULTI_IRQ_HANDLER
      ARM: gemini: DT for the Cortina Gemini SoC platforms
      ARM: gemini: delete all boardfiles
      ARM: gemini: switch to sparse IRQs
      ARM: gemini: select ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR
      ARM: gemini: convert to ARMv4 multiplatform
      ARM: gemini: select gemini poweroff
      ARM: gemini: select the right GPIO block

Martin Kaiser (1):
      ARM: i.MX25: globally disable supervisor protect

Maxime Ripard (2):
      ARM: sunxi: Select PM_OPP
      MAINTAINERS: Update the Allwinner sunXi entry

Michael Heimpold (1):
      ARM: mxs: add support for I2SE Duckbill 2 boards

Olof Johansson (8):
      Merge tag 'gemini-multiplat-dt' of git://git.kernel.org/.../linusw/linux-nomadik into next/soc
      Merge tag 'stm32-soc-for-v4.12-1' of git://git.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'davinci-for-v4.12/soc-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'sunxi-core-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'imx-soc-4.12' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'hisi-armv7-soc-for-4.12' of git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'at91-ab-4.12-soc' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'davinci-for-v4.12/soc-3' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc

Roger Quadros (3):
      ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO
      ARM: DRA7: hwmod: Fix DCAN1 stuck in transition
      ARM: DRA7: hwmod_data: Prevent wait_target_disable error for usb_otg_ss

Sekhar Nori (2):
      ARM: OMAP2+: omap_hwmod: provide space for more hwmod flags
      ARM: davinci: add pata_bk3710 libata driver support

Tiberiu Breana (2):
      ARM: imx: Fix mmdc_pmu_write_accesses event definition
      ARM: imx: Add AXI address filter support for MMDC profiling

Tony Lindgren (5):
      ARM: OMAP2+: Remove mostly unused hwmod linkspace
      ARM: OMAP2+: Use list_for_each_entry for hwmod slave_ports
      ARM: OMAP2+: Remove unused CLOCKACT_TEST_ICLK
      ARM: OMAP2+: Make hwmod clkdm_name const
      Merge branch 'hwmod-cleanup' into omap-for-v4.12/soc

Wei Yongjun (1):
      ARM: hisi: fix error return code in hip04_smp_init()


 Documentation/arm/stm32/stm32h743-overview.txt  |  30 ++
 MAINTAINERS                                     |   9 +-
 arch/arm/Kconfig                                |  33 +--
 arch/arm/include/debug/brcmstb.S                |  18 +-
 arch/arm/mach-at91/Makefile                     |  34 ++-
 arch/arm/mach-at91/at91rm9200.c                 |  15 +-
 arch/arm/mach-at91/at91sam9.c                   |  91 +-----
 arch/arm/mach-at91/generic.h                    |   8 +-
 arch/arm/mach-at91/pm.c                         | 199 +++++++------
 arch/arm/mach-at91/pm.h                         |  24 +-
 arch/arm/mach-at91/pm_data-offsets.c            |  13 +
 arch/arm/mach-at91/pm_suspend.S                 |  31 +--
 arch/arm/mach-at91/sama5.c                      |  52 +---
 arch/arm/mach-at91/soc.c                        | 142 ----------
 arch/arm/mach-bcm/Kconfig                       |   2 +
 arch/arm/mach-davinci/board-da850-evm.c         |   4 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |   3 +-
 arch/arm/mach-davinci/board-dm646x-evm.c        |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c       |   3 +-
 arch/arm/mach-davinci/da830.c                   |   6 +
 arch/arm/mach-davinci/da850.c                   |   6 +
 arch/arm/mach-davinci/da8xx-dt.c                |   1 +
 arch/arm/mach-davinci/pdata-quirks.c            | 178 +++++++++++-
 arch/arm/mach-davinci/pm.c                      |   1 -
 arch/arm/mach-gemini/Kconfig                    |  53 +---
 arch/arm/mach-gemini/Makefile                   |  15 +-
 arch/arm/mach-gemini/Makefile.boot              |   9 -
 arch/arm/mach-gemini/board-dt.c                 |  62 +++++
 arch/arm/mach-gemini/board-nas4220b.c           | 106 -------
 arch/arm/mach-gemini/board-rut1xx.c             |  92 ------
 arch/arm/mach-gemini/board-wbd111.c             | 133 ---------
 arch/arm/mach-gemini/board-wbd222.c             | 133 ---------
 arch/arm/mach-gemini/common.h                   |  33 ---
 arch/arm/mach-gemini/devices.c                  | 118 --------
 arch/arm/mach-gemini/gpio.c                     | 231 ---------------
 arch/arm/mach-gemini/idle.c                     |  31 ---
 arch/arm/mach-gemini/include/mach/entry-macro.S |  33 ---
 arch/arm/mach-gemini/include/mach/global_reg.h  | 278 -------------------
 arch/arm/mach-gemini/include/mach/hardware.h    |  71 -----
 arch/arm/mach-gemini/include/mach/irqs.h        |  53 ----
 arch/arm/mach-gemini/include/mach/uncompress.h  |  42 ---
 arch/arm/mach-gemini/irq.c                      | 105 -------
 arch/arm/mach-gemini/mm.c                       |  82 ------
 arch/arm/mach-gemini/reset.c                    |  25 --
 arch/arm/mach-gemini/time.c                     | 239 ----------------
 arch/arm/mach-hisi/platmcpm.c                   |   2 +
 arch/arm/mach-imx/mach-imx25.c                  |   6 +
 arch/arm/mach-imx/mach-mx31_3ds.c               |   7 +-
 arch/arm/mach-imx/mach-mx31moboard.c            |   4 +-
 arch/arm/mach-imx/mach-pcm037_eet.c             |   4 +-
 arch/arm/mach-imx/mmdc.c                        |  20 +-
 arch/arm/mach-mxs/mach-mxs.c                    |   3 +-
 arch/arm/mach-omap1/pm.c                        |   1 -
 arch/arm/mach-omap2/clockdomains81xx_data.c     |  10 +
 arch/arm/mach-omap2/cm81xx.h                    |   1 +
 arch/arm/mach-omap2/devices.c                   |   2 +-
 arch/arm/mach-omap2/omap_hwmod.c                | 208 ++------------
 arch/arm/mach-omap2/omap_hwmod.h                |  23 +-
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c   |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |   4 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |   2 -
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |   2 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   5 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      |  34 +++
 arch/arm/mach-omap2/pm.c                        |   1 -
 arch/arm/mach-stm32/Kconfig                     |  26 ++
 arch/arm/mach-stm32/board-dt.c                  |   1 +
 arch/arm/mach-sunxi/Kconfig                     |   1 +
 drivers/soc/Kconfig                             |   1 +
 drivers/soc/Makefile                            |   1 +
 drivers/soc/atmel/Kconfig                       |   6 +
 drivers/soc/atmel/Makefile                      |   1 +
 drivers/soc/atmel/soc.c                         | 231 +++++++++++++++
 {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h |   0
 74 files changed, 887 insertions(+), 2571 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h743-overview.txt
 create mode 100644 arch/arm/mach-at91/pm_data-offsets.c
 delete mode 100644 arch/arm/mach-at91/soc.c
 delete mode 100644 arch/arm/mach-gemini/Makefile.boot
 create mode 100644 arch/arm/mach-gemini/board-dt.c
 delete mode 100644 arch/arm/mach-gemini/board-nas4220b.c
 delete mode 100644 arch/arm/mach-gemini/board-rut1xx.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd111.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd222.c
 delete mode 100644 arch/arm/mach-gemini/common.h
 delete mode 100644 arch/arm/mach-gemini/devices.c
 delete mode 100644 arch/arm/mach-gemini/gpio.c
 delete mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-gemini/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/global_reg.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-gemini/irq.c
 delete mode 100644 arch/arm/mach-gemini/mm.c
 delete mode 100644 arch/arm/mach-gemini/reset.c
 delete mode 100644 arch/arm/mach-gemini/time.c
 create mode 100644 arch/arm/mach-stm32/Kconfig
 create mode 100644 drivers/soc/atmel/Kconfig
 create mode 100644 drivers/soc/atmel/Makefile
 create mode 100644 drivers/soc/atmel/soc.c
 rename {arch/arm/mach-at91 => drivers/soc/atmel}/soc.h (100%)
