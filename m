From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:23 -0700
Subject: [GIT PULL 2/7] ARM: SoC platform updates for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Improved and new platform support for various SoCs:

- New SoC support:
- Broadcom BCM23550
- Freescale i.MX7Solo
- Qualcomm MDM9615
- Renesas r8a7792
- Conversion of clps711x to multiplatform
- debug uart improvements for Atmel platforms
- Tango platform improvements: HOTPLUG_CPU, Suspend-to-ram
- OMAP tweaks and improvements to hwmod
- OMAP support for kexec on SMP



Conflicts:

arch/arm/Kconfig:
Remove/change conflict. Contents moved to arch/arm/mach-clps711x/Kconfig.
Either add CLPS711X_TIMER and GPIOLIB selects there, or we'll send a fix to
do it later.

arch/arm/mach-bcm/board_bcm21664.c:
Remove/remove conflict. Delete both sides.

arch/arm/mach-imx/mach-imx51.c:
Add/remove conflict. Remove of_platform_populate(), keep
imx_aips_allow_unprivileged_access().

drivers/net/ethernet/freescale/fec.h:
Add/add conflict. Keep both sides, but bump one to (1 << 14).

----------------------------------------------------------------

The following changes since commit 02dde306d1113b6e161eb77946159d9ec41f725b:

  Merge branch 'next/cleanup' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 4756f881ba303e4dada613feeacf44d26c3e35b9:

  Merge tag 'samsung-soc-4.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/soc

----------------------------------------------------------------

Alexander Shiyan (6):
      ARM: i.MX: Fix FIQ interrupt handling for TZIC
      ARM: i.MX: Disable supervisor protect for i.MX51
      ARM: clps711x: Reduce static map size
      ARM: clps711x: Add basic DT support
      ARM: clps711x: Remove boards support
      ARM: clps711x: Switch to MULTIPLATFORM

Alexandre Belloni (2):
      ARM: at91: debug: use DEBUG_UART_VIRT
      ARM: at91: debug: add default DEBUG_LL addresses

Andrea Gelmini (7):
      ARM: OMAP1: Fix typo in fiq.c
      ARM: OMAP1: Fix typo in mtd-xip.h
      ARM: OMAP2+: Fix typo in cm3xxx.c
      ARM: OMAP2+: Fix typo in mux34xx.c
      ARM: OMAP2+: Fix typo in omap4-common.c
      ARM: OMAP2+: Fix typo in omap_device.c
      ARM: OMAP2+: Fix typo in sdrc.h

Arnd Bergmann (8):
      Merge ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB changes into next/soc
      ARM: tango: fix CONFIG_HOTPLUG_CPU=n build
      Merge tag 'omap-for-v4.8/soc-pt2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'hisi-armv7-soc-for-4.8-v3' of git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'arm-soc/for-4.8/soc-part2' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'arm-soc/for-4.8/maintainers-part2' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'sti-soc-for-v4.8' of git://git.kernel.org/.../pchotard/sti into next/soc
      Merge tag 'samsung-soc-4.8-3' of git://git.kernel.org/.../krzk/linux into next/soc

Ben Dooks (16):
      ARM: bcm: fix missing include of kona_l2_cache.h
      ARM: imx: fix missing includes
      ARM: imx: fix missing include of common.h
      ARM: imx6: fix static declaration in include/soc/imx/cpuidle.h
      ARM: EXYNOS: Fixup debug macros for big-endian
      ARM: SAMSUNG: Fixup endian issues in CPU detection
      ARM: EXYNOS: Fixups for big-endian operation
      ARM: EXYNOS: Fixup endian in pm/pmu
      ARM: SAMSUNG: Fixup usage of __raw IO in PM
      ARM: EXYNOS: Fixup for __raw operations in suspend.c
      ARM: imx6: fix missing <soc/imx/cpuidle.h> in cpuidle-imx6q.c
      ARM: at91: fix warnings in pm.c
      ARM: keystone: fix missing keystone.h in pm_domain.c
      ARM: OMAP: make ti81xx_rtc_hwmod static
      ARM: SAMSUNG: Fix missing s5p_init_cpu() declaration
      ARM: hisi: make unexported symbols static

Chris Brand (3):
      ARM: bcm21664: Remove reset code
      ARM: Add support for Broadcom BCM23550 SoC
      ARM: BCM23550 SMP support

Florian Fainelli (2):
      ARM: debug: Enable DEBUG_BCM_5301X for Northstar Plus SoCs
      MAINTAINERS: Change L to M for Broadcom ARM/ARM64 SoC entries

Franklin S Cooper Jr (2):
      clk: ti: am335x/am4372: Add tbclk to pwm node
      ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and eCAP hwmod entries

Geert Uytterhoeven (12):
      ARM: shmobile: pm-rmobile: Postpone call to pm_genpd_init()
      ARM: shmobile: rcar-gen2: Use ICRAM1 for jump stub on all SoCs
      soc: renesas: rcar-sysc: Document r8a7796 support
      soc: renesas: Add r8a7796 SYSC PM Domain Binding Definitions
      soc: renesas: rcar-sysc: Add support for R-Car M3-W power areas
      soc: renesas: rcar-sysc: Fix uninitialized error code in rcar_sysc_pd_init()
      soc: renesas: rcar-sysc: Make rcar_sysc_init() init the PM domains
      soc: renesas: rcar-sysc: Move SYSC interrupt config to rcar-sysc driver
      soc: renesas: rcar-sysc: Improve SYSC interrupt config in legacy wrapper
      ARM: shmobile: rcar-gen2: Obtain extal frequency from DT
      ARM: shmobile: rcar-gen2: Correct arch timer frequency on R-Car V2H
      ARM: shmobile: apmu: Move #ifdef CONFIG_SMP to cover more functions

Jean Guyomarc'h (1):
      ARM: mach-imx6q: fix spelling mistake in error message

Jiancheng Xue (1):
      ARM: hisi: consolidate the hisilicon machine entries

Jon Mason (4):
      MAINTAINERS: Fix nsp false-positives
      MAINTAINERS: Add NS2 entry
      MAINTAINERS: Update BCM63XX entry
      MAINTAINERS: Update BCM281XX/BCM11XXX/BCM216XX entry

Joonyoung Shim (1):
      ARM: EXYNOS: Fix UART address selection for DEBUG_LL

Keerthy (2):
      ARM: AM43XX: hwmod: Fix RSTST register offset for pruss
      ARM: dts: am43xx: Remove wrongly defined RSTST offset for PER Domain

Krzysztof Kozlowski (2):
      MAINTAINERS: Extend Samsung SoC entry with S3C/S5P drivers
      ARM: SAMSUNG: Constify iomem address passed to s5p_init_cpu

Lucas Stach (1):
      ARM: imx6: disable deeper idle states when FEC is active w/o HW workaround

Magnus Damm (4):
      ARM: shmobile: apmu: Add APMU DT support via Enable method
      ARM: shmobile: smp: Add function to prioritize DT SMP
      ARM: shmobile: r8a7790: Prioritize DT APMU support
      ARM: shmobile: r8a7791: Prioritize DT APMU support

Marc Gonzalez (3):
      ARM: tango: add HOTPLUG_CPU support
      Update ARM/TANGO section
      ARM: tango: add Suspend-to-RAM support

Masahiro Yamada (1):
      ARM: uniphier: remove empty DT machine descriptor

Michael Turquette (1):
      arm: meson: explicitly select clk drivers

Neil Armstrong (2):
      ARM: qcom: Add support for MDM9615
      ARM: oxnas: Change OX810SE default driver config

Nicolas Ferre (1):
      ARM: at91: Documentation: update the sama5d2 entry

Olof Johansson (11):
      Merge tag 'renesas-soc-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'at91-ab-4.8-soc' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'arm-soc/for-4.8/soc' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'keystone_for_4.8' of git://git.kernel.org/.../ssantosh/linux-keystone into next/soc
      Merge tag 'at91-ab-4.8-soc2' of git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'davinci-for-v4.8' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'qcom-soc-for-4.8' of git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'imx-soc-4.8' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'omap-for-v4.8/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'samsung-soc-4.8-2' of git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'renesas-soc2-for-v4.8' of git://git.kernel.org/.../horms/renesas into next/soc

Patrice Chotard (1):
      ARM: sti: Implement dummy L2 cache's write_sec

Peter Griffin (1):
      ARM: STi: Update machine _namestr to be more generic.

Peter Ujfalusi (10):
      ARM: OMAP: rx51-video: Do not set TV connector_type
      ARM/video: omap2: Move omap_display_init declaration to mach-omap2/display.h
      video/platform_data: omapdss: Create new header file for platform data
      ARM: OMAP2: Use the platform_data header for omapdss
      ARM: OMAP3: hwmod data: Fix McBSP2/3 sidetone data
      ARM: OMAP3: McBSP: New callback for McBSP2/3 ICLK idle configuration
      ARM: OMAP3: pdata-quirks: Add support for McBSP2/3 sidetone handling
      ASoC: omap-mcbsp: Rename omap_mcbsp_sysfs_remove() to omap_mcbsp_cleanup()
      ASoC: omap-mcbsp: sidetone: Use the new callback for iclk handling
      ARM: OMAP2+: McBSP: Remove the old iclk allow/deny idle code

Petr Kulhavy (2):
      ARM: davinci: da850: add clocks for mcbsp0 and 1
      ARM: davinci: remove unused davinci-i2s pdata

Rafa? Mi?ecki (1):
      MAINTAINERS: Update entry for BCM5301X ARM

Sekhar Nori (1):
      ARM: davinci: fix build break because of undeclared dm365_evm_snd_data

Sergei Shtylyov (2):
      soc: renesas: rcar-sysc: add R8A7792 support
      ARM: shmobile: r8a7792: basic SoC support

Shawn Guo (1):
      ARM: imx6q: export cpuidle functions needed by fec driver

Simon Horman (1):
      Merge branch 'rcar-sysc-for-v4.8' into HEAD

Stefan Agner (1):
      ARM: imx: add support for i.MX 7Solo

Tero Kristo (5):
      ARM: OMAP2+: omap_device: create clock alias purely from DT data
      ARM: OMAP2+: hwmod: fetch main_clk based on hwmod name
      ARM: OMAP2+: timer: change order of hwmod data handling
      ARM: OMAP2+: clockdomain: add usecounting support to autoidle APIs
      ARM: AM33xx: fix module_wait_ready without clkctrl register

Thierry Reding (1):
      ARM: s3c64xx: smartq: Avoid sparse warnings

Tomi Valkeinen (1):
      ARM: DRA7: hwmod: remove DSS addresses from hwmod

Tony Lindgren (8):
      Merge branch 'peter/for-4.8_omapdss_part1' of https://github.com/omap-audio/linux-audio into omap-for-v4.8/soc
      Merge commit 'c0053bd50af5' into omap-for-v4.8/soc
      ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for kexec
      ARM: OMAP4+: Prevent CPU1 related hang with kexec
      ARM: OMAP4+: Reset CPU1 properly for kexec
      ARM: OMAP4+: Allow kexec on SMP variants
      ARM: OMAP2+: Fix build if CONFIG_SMP is not set
      ARM: OMAP2+: Fix build with CONFIG_SMP and CONFIG_PM is not set

Vignesh R (1):
      ARM: DRA7: hwmod: Remove QSPI address space entry from hwmod


 Documentation/arm/Atmel/README                  |  10 +-
 .../devicetree/bindings/net/fsl-fec.txt         |   3 +
 .../bindings/power/renesas,rcar-sysc.txt        |   1 +
 MAINTAINERS                                     |  42 ++--
 arch/arm/Kconfig                                |  14 --
 arch/arm/Kconfig.debug                          |  65 ++++--
 arch/arm/Makefile                               |   1 -
 arch/arm/include/debug/at91.S                   |  10 +-
 arch/arm/include/debug/clps711x.S               |   4 +-
 arch/arm/include/debug/exynos.S                 |   6 +-
 arch/arm/include/debug/samsung.S                |   8 +
 arch/arm/mach-at91/pm.c                         |   5 +-
 arch/arm/mach-bcm/Kconfig                       |  12 +-
 arch/arm/mach-bcm/Makefile                      |   5 +-
 arch/arm/mach-bcm/board_bcm21664.c              |  43 ----
 arch/arm/mach-bcm/board_bcm23550.c              |  25 +++
 arch/arm/mach-bcm/kona_l2_cache.c               |   1 +
 arch/arm/mach-bcm/platsmp.c                     |  58 ++++++
 arch/arm/mach-clps711x/Kconfig                  |  53 ++---
 arch/arm/mach-clps711x/Makefile                 |  14 +-
 arch/arm/mach-clps711x/Makefile.boot            |   5 -
 arch/arm/mach-clps711x/board-dt.c               |  82 ++++++++
 arch/arm/mach-clps711x/common.c                 |   4 +-
 arch/arm/mach-clps711x/include/mach/clps711x.h  | 204 -------------------
 arch/arm/mach-clps711x/include/mach/hardware.h  |  53 -----
 .../arm/mach-clps711x/include/mach/uncompress.h |  55 -----
 arch/arm/mach-davinci/board-dm355-evm.c         |   4 +-
 arch/arm/mach-davinci/board-dm365-evm.c         |   8 +-
 arch/arm/mach-davinci/board-dm644x-evm.c        |   4 +-
 arch/arm/mach-davinci/board-neuros-osd2.c       |   4 +-
 arch/arm/mach-davinci/da850.c                   |  16 ++
 arch/arm/mach-davinci/davinci.h                 |   8 +-
 arch/arm/mach-davinci/dm355.c                   |   3 +-
 arch/arm/mach-davinci/dm365.c                   |   6 +-
 arch/arm/mach-davinci/dm644x.c                  |   3 +-
 arch/arm/mach-davinci/psc.h                     |   2 +
 arch/arm/mach-exynos/common.h                   |   5 +-
 arch/arm/mach-exynos/exynos.c                   |   1 +
 arch/arm/mach-exynos/firmware.c                 |  18 +-
 arch/arm/mach-exynos/headsmp.S                  |   3 +
 arch/arm/mach-exynos/platsmp.c                  |   4 +-
 arch/arm/mach-exynos/pm.c                       |   6 +-
 arch/arm/mach-exynos/pm_domains.c               |   6 +-
 arch/arm/mach-exynos/suspend.c                  |  12 +-
 arch/arm/mach-hisi/hisilicon.c                  |  28 ---
 arch/arm/mach-hisi/platsmp.c                    |   4 +-
 arch/arm/mach-imx/avic.c                        |  19 +-
 arch/arm/mach-imx/cpuidle-imx6q.c               |  20 ++
 arch/arm/mach-imx/devices/devices.c             |   3 +
 arch/arm/mach-imx/devices/platform-gpio-mxc.c   |   1 +
 arch/arm/mach-imx/irq-common.c                  |   6 +-
 arch/arm/mach-imx/mach-imx51.c                  |   2 +
 arch/arm/mach-imx/mach-imx6q.c                  |   2 +-
 arch/arm/mach-imx/mach-imx7d.c                  |   1 +
 arch/arm/mach-imx/tzic.c                        |   6 +-
 arch/arm/mach-keystone/pm_domain.c              |   2 +
 arch/arm/mach-meson/Kconfig                     |   3 +
 arch/arm/mach-omap1/ams-delta-fiq.c             |   2 +-
 arch/arm/mach-omap1/include/mach/mtd-xip.h      |   2 +-
 arch/arm/mach-omap2/Makefile                    |   9 +-
 arch/arm/mach-omap2/board-ldp.c                 |   3 +-
 arch/arm/mach-omap2/board-rx51-video.c          |   4 +-
 arch/arm/mach-omap2/clockdomain.c               |  36 ++--
 arch/arm/mach-omap2/clockdomain.h               |   2 +
 arch/arm/mach-omap2/cm33xx.c                    |   3 +
 arch/arm/mach-omap2/cm3xxx.c                    |   2 +-
 arch/arm/mach-omap2/common.h                    |   8 +-
 arch/arm/mach-omap2/cpuidle44xx.c               |   2 +-
 arch/arm/mach-omap2/display.c                   |   2 +-
 arch/arm/mach-omap2/display.h                   |   5 +
 arch/arm/mach-omap2/dss-common.c                |   2 +-
 arch/arm/mach-omap2/io.c                        |   3 +
 arch/arm/mach-omap2/mcbsp.c                     |  31 +--
 arch/arm/mach-omap2/mux34xx.c                   |   4 +-
 arch/arm/mach-omap2/omap-headsmp.S              |  18 +-
 arch/arm/mach-omap2/omap-hotplug.c              |   6 +
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |  31 ++-
 arch/arm/mach-omap2/omap-smp.c                  |  98 ++++++---
 arch/arm/mach-omap2/omap4-common.c              |  16 +-
 arch/arm/mach-omap2/omap_device.c               |  19 +-
 arch/arm/mach-omap2/omap_hwmod.c                |  82 ++++++--
 .../omap_hwmod_33xx_43xx_common_data.h          |  18 --
 .../omap_hwmod_33xx_43xx_interconnect_data.c    |  64 ------
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |  85 +-------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c      |   9 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |  24 +--
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |  54 -----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  41 ----
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      |   2 +-
 arch/arm/mach-omap2/pdata-quirks.c              |  18 ++
 arch/arm/mach-omap2/pm.c                        |   8 +-
 arch/arm/mach-omap2/powerdomain.c               |  20 +-
 arch/arm/mach-omap2/prcm43xx.h                  |   1 +
 arch/arm/mach-omap2/prm33xx.h                   |   2 -
 arch/arm/mach-omap2/sdrc.h                      |   4 +-
 arch/arm/mach-omap2/timer.c                     |   3 +-
 arch/arm/mach-oxnas/Kconfig                     |   2 +-
 arch/arm/mach-qcom/Kconfig                      |   4 +
 arch/arm/mach-qcom/board.c                      |   1 +
 arch/arm/mach-s3c64xx/mach-smartq.c             |   1 +
 arch/arm/mach-shmobile/Kconfig                  |   4 +
 arch/arm/mach-shmobile/Makefile                 |   1 +
 arch/arm/mach-shmobile/common.h                 |   1 +
 arch/arm/mach-shmobile/platsmp-apmu.c           |  94 ++++++++-
 arch/arm/mach-shmobile/platsmp.c                |   6 +
 arch/arm/mach-shmobile/pm-r8a7779.c             |   6 +-
 arch/arm/mach-shmobile/pm-rcar-gen2.c           |  19 +-
 arch/arm/mach-shmobile/pm-rmobile.c             |   2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c          |   1 +
 arch/arm/mach-shmobile/setup-r8a7791.c          |   1 +
 arch/arm/mach-shmobile/setup-r8a7792.c          |  35 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |  45 ++--
 arch/arm/mach-sti/board-dt.c                    |  11 +-
 arch/arm/mach-tango/Makefile                    |   1 +
 arch/arm/mach-tango/platsmp.c                   |  35 ++++
 arch/arm/mach-tango/pm.c                        |  32 +++
 arch/arm/mach-tango/smc.h                       |   5 +-
 arch/arm/mach-uniphier/Makefile                 |   1 -
 arch/arm/mach-uniphier/uniphier.c               |  30 ---
 arch/arm/plat-samsung/cpu.c                     |  10 +-
 arch/arm/plat-samsung/include/plat/cpu.h        |   1 +
 arch/arm/plat-samsung/pm-common.c               |   8 +-
 drivers/clk/ti/clk-33xx.c                       |   3 +
 drivers/clk/ti/clk-43xx.c                       |   6 +
 drivers/net/ethernet/freescale/fec.h            |   2 +
 drivers/net/ethernet/freescale/fec_main.c       |  12 ++
 drivers/soc/renesas/Makefile                    |   2 +
 drivers/soc/renesas/r8a7792-sysc.c              |  34 ++++
 drivers/soc/renesas/r8a7796-sysc.c              |  48 +++++
 drivers/soc/renesas/rcar-sysc.c                 |  45 +++-
 drivers/soc/renesas/rcar-sysc.h                 |   2 +
 include/dt-bindings/power/r8a7796-sysc.h        |  36 ++++
 include/linux/platform_data/asoc-ti-mcbsp.h     |   4 +-
 include/linux/platform_data/omapdss.h           |  42 ++++
 include/linux/soc/renesas/rcar-sysc.h           |   2 +-
 include/soc/imx/cpuidle.h                       |  25 +++
 include/video/omapdss.h                         |  31 +--
 sound/soc/omap/mcbsp.c                          |  21 +-
 sound/soc/omap/mcbsp.h                          |   3 +-
 sound/soc/omap/omap-mcbsp.c                     |   5 +-
 140 files changed, 1267 insertions(+), 1149 deletions(-)
 create mode 100644 arch/arm/mach-bcm/board_bcm23550.c
 create mode 100644 arch/arm/mach-clps711x/board-dt.c
 delete mode 100644 arch/arm/mach-clps711x/include/mach/clps711x.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
 create mode 100644 arch/arm/mach-tango/pm.c
 delete mode 100644 arch/arm/mach-uniphier/uniphier.c
 create mode 100644 drivers/soc/renesas/r8a7792-sysc.c
 create mode 100644 drivers/soc/renesas/r8a7796-sysc.c
 create mode 100644 include/dt-bindings/power/r8a7796-sysc.h
 create mode 100644 include/linux/platform_data/omapdss.h
 create mode 100644 include/soc/imx/cpuidle.h
