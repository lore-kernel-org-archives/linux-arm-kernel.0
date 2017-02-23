From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Feb 2017 00:06:43 +0100
Subject: [GIT PULL 2/7] ARM: SoC platform updates
In-Reply-To: <8729461.VkrRdW7LzJ@wuerfel>
References: <8729461.VkrRdW7LzJ@wuerfel>
Message-ID: <6258829.iCqC3CGGSZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a121103c922847ba5010819a3f250f1f7fc84ab8:

  Linux 4.10-rc3 (2017-01-08 14:18:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to af1d09eefa72089300ddde13bbaf9af1a82c6be1:

  Merge tag 'davinci-for-v4.11/soc-2' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into next/soc (2017-02-16 17:15:39 +0100)

----------------------------------------------------------------
ARM: SoC platform updates

In the SoC branch we normally collect classic arch/arm/mach-* contents, i.e.
C code changes for SoC platforms. This release cycle the diffstat is quite
nice, in that we're removing 3x the amount of code that's being added.

The main reason for this is that there's a removal of camera drivers for
Freescale i.MX chips (driver was removed so the device registration isn't
needed any more). There's also removal of display initialization code for OMAP
that is no longer needed.

The rest are mostly minor tweaks and cleanups; constification on Samsung
platforms, cleanup of ux500 platform data, purge of other unused platform
data/device seutp on i.MX and other good stuff.

New SoC support this cycle is for two Allwinner platforms, H2+ and V3s.

----------------------------------------------------------------
Aaro Koskinen (3):
      ARM: OMAP1: USB: tidy up logging output
      ARM: OMAP1: USB: make omap_otg_init() static
      ARM: OMAP1: USB: delete redundant CPU class checks

Alexandre Belloni (1):
      ARM: at91: pm: remove useless extern definition

Andrew Jeffery (1):
      ARM: aspeed: Select pinctrl drivers

Andrew Murray (1):
      ARM: OMAP: clock: Remove unused mpurate cmdline option

Arnd Bergmann (8):
      ARM: imx: remove unused device definitions
      ARM: pxa: ezx: fix a910 camera data
      ARM: pxa: include linux/leds.h
      ARM: mv78xx0: fix possible PCI buffer overflow
      Merge tag 'mvebu-soc-4.11-2' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'sunxi-core-for-4.11' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'arm-soc/for-4.11/maintainers' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'davinci-for-v4.11/soc-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc

Bartosz Golaszewski (7):
      ARM: davinci: da850: coding style fix
      ARM: davinci: da850: fix da850_set_pll0rate()
      bus: da850-mstpri: fix my e-mail address
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for SATA
      ARM: davinci: da850: add con_id for the SATA clock
      ARM: davinci: da850: model the SATA refclk
      ARM: davinci: remove BUG_ON() from da850_register_sata()

Bhumika Goyal (1):
      soc: dove: constify reset_control_ops structures

Chris Packham (1):
      arm: mvebu: support for SMP on 98DX3336 SoC

Dmitry Torokhov (1):
      ARM: tegra: paz00: Fix __initdata placement

Eric Anholt (1):
      MAINTAINERS: Update for the current location of the bcm2835 tree.

Fabio Estevam (6):
      ARM: mach-mx31_3ds: Remove camera support
      ARM: mx31moboard-marxbot: Remove camera support
      ARM: mx31moboard-smartbot: Remove camera support
      ARM: mach-mx35_3ds: Remove camera support
      ARM: mach-pcm037: Remove camera support
      ARM: mach-mx27_3ds: Remove camera support

Florian Fainelli (1):
      ARM: ep93xx: Disable TS-72xx watchdog before uncompressing

Geert Uytterhoeven (6):
      ARM: shmobile: apmu: Add more register documentation
      ARM: shmobile: apmu: Add debug resource reset for secondary CPU boot
      ARM: shmobile: apmu: Allow booting secondary CPU cores in debug mode
      ARM: shmobile: r8a7791: Allow booting secondary CPU cores in debug mode
      ARM: shmobile: rcar-gen2: Remove unused rcar_gen2_read_mode_pins()
      ARM: shmobile: rcar-gen2: Add more register documentation

Icenowy Zheng (2):
      ARM: sunxi: add support for H2+ SoC
      arm: sunxi: add support for V3s SoC

Kefeng Wang (1):
      arm: hisi: drop extern hip01_cpu_die

Kevin Hilman (1):
      ARM: davinci: add skeleton for pdata-quirks

Krzysztof Kozlowski (9):
      ARM: EXYNOS: Constify list of retention registers
      ARM: EXYNOS: Annotate iomem and pm_data pointers __ro_after_init
      ARM: s3c24xx: Constify few integer tables
      ARM: s3c64xx: Annotate external clock frequencies __ro_after_init
      ARM: SAMSUNG: Constify array of wake irqs passed to samsung_sync_wakemask
      ARM: s3c24xx: Constify wake_irqs
      ARM: s3c64xx: Constify wake_irqs
      ARM: EXYNOS: Remove Exynos4415 arch code (SoC not supported anymore)
      dt-bindings: video: exynos7-decon: Remove obsolete samsung,power-domain property

Laurent Pinchart (2):
      ARM: OMAP2+: Remove unused omap_display_init() function
      ARM: OMAP2+: Make the omapdss_find_dss_of_node() function static

Linus Walleij (2):
      ARM: ux500: simplify secondary boot
      ARM: ux500: cut some platform data

Lokesh Vutla (1):
      ARM: OMAP2+: omap_hwmod: Add support for earlycon

Olof Johansson (14):
      Merge tag 'renesas-soc-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'ux500-dev-for-armsoc' of git://git.kernel.org/.../linusw/linux-stericsson into next/soc
      Merge tag 'samsung-soc-4.11' of git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'at91-ab-4.11-soc' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'aspeed-4.11-soc' of git://git.kernel.org/.../joel/aspeed into next/soc
      Merge tag 'omap-for-v4.11/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'hisi-armv7-soc-for-4.11' of git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'pxa-for-4.11' of https://github.com/rjarzmik/linux into next/soc
      Merge tag 'renesas-soc2-for-v4.11' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'tegra-for-4.11-soc' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'mvebu-soc-4.11-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'imx-cleanup-4.11' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'samsung-soc-4.11-2' of git://git.kernel.org/.../krzk/linux into next/soc
      ARM: ux500: remove deleted file from Makefile

Sekhar Nori (1):
      Merge branch 'v4.11/fixes-non-critical' into v4.11/soc

Stefan Schmidt (1):
      MAINTAINERS: transfer maintainership for the EZX platform

Sylwester Nawrocki (2):
      ARM: s3c64xx: Drop initialization of unused struct s3c_audio_pdata fields
      ARM: s3c24xx: Drop unused struct s3c_audio_pdata entries

Tony Lindgren (2):
      MAINTAINERS: Add Aaro Koskinen as TI omap1 SoC co-maintainer
      Merge branch 'omap-for-v4.11/omap1' into omap-for-v4.11/soc

Wei Yongjun (1):
      ARM: ux500: remove duplicated include from cpu-db8500.c

 Documentation/arm/sunxi/README                     |   8 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 .../bindings/arm/marvell/98dx3236-resume-ctrl.txt  |  16 ++
 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../bindings/display/exynos/exynos7-decon.txt      |   2 +-
 MAINTAINERS                                        |  29 ++-
 arch/arm/mach-aspeed/Kconfig                       |   4 +
 arch/arm/mach-at91/pm.c                            |   2 +-
 arch/arm/mach-at91/pm.h                            |   2 -
 arch/arm/mach-davinci/Makefile                     |   2 +-
 arch/arm/mach-davinci/da850.c                      |  24 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |  10 +
 arch/arm/mach-davinci/devices-da8xx.c              |  30 ++-
 arch/arm/mach-davinci/include/mach/common.h        |   2 +
 arch/arm/mach-davinci/include/mach/da8xx.h         |   1 +
 arch/arm/mach-davinci/pdata-quirks.c               |  39 ++++
 arch/arm/mach-ep93xx/include/mach/uncompress.h     |  12 +
 arch/arm/mach-exynos/Kconfig                       |   5 -
 arch/arm/mach-exynos/exynos.c                      |   5 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/suspend.c                     |  11 +-
 arch/arm/mach-hisi/core.h                          |   1 -
 arch/arm/mach-imx/devices/platform-flexcan.c       |   9 -
 .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |  10 -
 arch/arm/mach-imx/mach-mx27_3ds.c                  | 107 ---------
 arch/arm/mach-imx/mach-mx31_3ds.c                  | 160 -------------
 arch/arm/mach-imx/mach-mx35_3ds.c                  | 103 --------
 arch/arm/mach-imx/mach-pcm037.c                    | 115 ---------
 arch/arm/mach-imx/mx31moboard-marxbot.c            |  92 --------
 arch/arm/mach-imx/mx31moboard-smartbot.c           |  74 ------
 arch/arm/mach-mv78xx0/pcie.c                       |   2 +-
 arch/arm/mach-mvebu/platsmp.c                      |  75 ++++++
 arch/arm/mach-omap1/clock.c                        |  20 --
 arch/arm/mach-omap1/clock.h                        |   2 -
 arch/arm/mach-omap1/include/mach/usb.h             |   2 -
 arch/arm/mach-omap1/usb.c                          |  51 ++--
 arch/arm/mach-omap2/clock.c                        |  61 -----
 arch/arm/mach-omap2/clock.h                        |   4 -
 arch/arm/mach-omap2/display.c                      | 258 +--------------------
 arch/arm/mach-omap2/display.h                      |   7 -
 arch/arm/mach-omap2/omap_hwmod.c                   |  33 +++
 arch/arm/mach-pxa/ezx.c                            |  56 ++---
 arch/arm/mach-pxa/idp.c                            |   1 +
 arch/arm/mach-s3c24xx/bast-irq.c                   |   4 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           |   2 +-
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 |   2 +-
 arch/arm/mach-s3c64xx/common.c                     |   3 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |  19 --
 arch/arm/mach-s3c64xx/pm.c                         |   2 +-
 arch/arm/mach-shmobile/platsmp-apmu.c              |  41 ++--
 arch/arm/mach-shmobile/pm-rcar-gen2.c              |  40 +++-
 arch/arm/mach-shmobile/rcar-gen2.h                 |   2 -
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  18 --
 arch/arm/mach-shmobile/smp-r8a7791.c               |  14 +-
 arch/arm/mach-sunxi/sunxi.c                        |   2 +
 arch/arm/mach-tegra/board-paz00.c                  |   2 +-
 arch/arm/mach-ux500/Makefile                       |   1 -
 arch/arm/mach-ux500/board-mop500-audio.c           |  77 ------
 arch/arm/mach-ux500/board-mop500.h                 |  17 --
 arch/arm/mach-ux500/cpu-db8500.c                   |  17 --
 arch/arm/mach-ux500/platsmp.c                      |  45 ++--
 arch/arm/mach-ux500/ste-dma40-db8500.h             |  85 -------
 arch/arm/plat-samsung/devs.c                       |  19 --
 arch/arm/plat-samsung/include/plat/wakeup-mask.h   |   2 +-
 arch/arm/plat-samsung/wakeup-mask.c                |   2 +-
 drivers/bus/da8xx-mstpri.c                         |   2 +-
 drivers/cpufreq/davinci-cpufreq.c                  |   2 +-
 drivers/soc/dove/pmu.c                             |   2 +-
 68 files changed, 424 insertions(+), 1449 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236-resume-ctrl.txt
 create mode 100644 arch/arm/mach-davinci/pdata-quirks.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
 delete mode 100644 arch/arm/mach-ux500/board-mop500.h
 delete mode 100644 arch/arm/mach-ux500/ste-dma40-db8500.h
