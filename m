From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:21:53 +0200
Subject: [GIT PULL 2/7] ARM: SoC platform updates
Message-ID: <CAK8P3a32dxyTmAx4nHp_-9jxYRAHufJ56+zzrMSujc1LePYeiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cc7a938f5f308eeb6f8fe3cec28e1800aa81facb:

  ARM: at91: select CONFIG_ARM_CPU_SUSPEND (2017-05-29 11:06:56 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 18cfd9429d8a82c49add8f3ca9d366599bfcac45:

  ARM: owl: smp: Drop bogus holding pen (2017-07-03 14:31:47 +0200)

----------------------------------------------------------------
ARM: SoC platform updates

SoC platform changes (arch/arm/mach-*). This merge window, the bulk is
for a few platforms:

- Andres F?rber adds initial support for the Actions Semi S500 (a.k.a.
  'owl') platform, a close relative of the S900 platform he adds for arm64.

- in mach-omap2, we remove more legacy code

- Rockchips gains support for the RV1108 SoC designed for camera
  applications.

- For Atmel, we gain support for MMU-less SoCs (SAME70/V71/S70/V70)

- Minor updates for other platforms, including davinci, s3c64xx,
  prima2, stm32, broadcom nsp, amlogic, pxa, imx and renesas

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: at91: pm: Add sama5d2 backup mode
      ARM: at91: pm: allow selecting standby and suspend modes
      ARM: at91: pm: fallback to slowclock when backup mode fails
      ARM: at91: Documentation: add armv7m families
      ARM: at91: Document armv7m compatibles
      ARM: at91: handle CONFIG_PM for armv7m configurations
      ARM: at91: remove atmel_nand_data

Alexandre TORGUE (1):
      ARM: stm32: Introduce MACH_STM32F469 flag

Andreas F?rber (11):
      ARM: Prepare Actions Semi S500
      MAINTAINERS: Add Actions Semi Owl section
      ARM: owl: Implement CPU enable-method for S500
      MAINTAINERS: Update Actions Semi section with SPS
      dt-bindings: power: Add Owl SPS power domains
      soc: actions: Add Owl SPS
      soc: actions: owl-sps: Factor out owl_sps_set_pg() for power-gating
      Merge branch 'v4.13/sps' into v4.13/arm+sps
      ARM: owl: smp: Implement SPS power-gating for CPU2 and CPU3
      ARM: owl: Drop custom machine
      ARM: owl: smp: Drop bogus holding pen

Andrey Smirnov (1):
      ARM: imx: Select GPCv2 for i.MX7

Andy Yan (2):
      ARM: debug: add low level debug uart for rv1108
      ARM: rockchip: enable support for RV1108 SoC

Arnd Bergmann (5):
      ARM: s3c64xx: Do not select ARM_AMBA from S3C64XX_PL080
      ARM: at91: fix at91_suspend_entering_slow_clock link error
      Merge tag 'socfpga_updates_for_v4.13' of
git://git.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'actions-arm-soc-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/soc
      Merge tag 'actions-arm-soc+sps-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/soc

Christian Lamparter (1):
      ARM: debug: qcom: add UART addresses to Kconfig help for IPQ4019

Dave Gerlach (3):
      ARM: OMAP: Wakeupgen: Add context save/restore for AM43XX
      ARM: OMAP2+: timer: Add suspend-resume callbacks for clkevent device
      ARM: OMAP2+: pm: Remove __init from omap_pm_clkdms_setup

Geert Uytterhoeven (1):
      ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ALWAYS_ON

Jon Mason (1):
      ARM: BCM: Enable thermal support for NSP SoCs

Kevin Hilman (1):
      ARM: davinci: fix const warnings

Leonard Crestez (2):
      ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
      ARM: imx6ull: Make suspend/resume work like on 6ul

Marek Vasut (1):
      ARM: socfpga: Increase max number of GPIOs

Markus Elfring (12):
      ARM: OMAP1: DMA: Improve a size determination in omap1_system_dma_init()
      ARM: OMAP1: DMA: Delete an error message for a failed memory
allocation in omap1_system_dma_init()
      ARM: OMAP1: DMA: Delete an unnecessary return statement in
omap1_show_dma_caps()
      ARM: OMAP1: Delete an error message for a failed memory
allocation in omap1_dm_timer_init()
      ARM: OMAP1: Fix a typo in a comment line
      ARM: OMAP2+: Delete an error message for a failed memory
allocation in two functions
      ARM: OMAP2+: Improve a size determination in sr_dev_init()
      ARM: OMAP2+: Use kcalloc() in sr_set_nvalues()
      ARM: OMAP2+: SmartReflex: Delete an error message for a failed
memory allocation in two functions
      ARM: pxa: Delete an error message for a failed memory allocation
in pxa_pm_init()
      ARM: pxa: Improve a size determination in pxa3xx_u2d_probe()
      ARM: pxa: Delete an error message for a failed memory allocation
in pxa3xx_u2d_probe()

Martin Blumenstingl (1):
      arm: meson: select the clock controller for Meson8

Masahiro Yamada (1):
      ARM: prima2: remove redundant select CPU_V7

Olof Johansson (14):
      Merge tag 'davinci-for-v4.13/soc' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'v4.13-rockchip-soc32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'samsung-soc-4.13' of
git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'arm-soc/for-4.13/soc' of
http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'omap-for-v4.13/omap1-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'amlogic-soc' of
git://git.kernel.org/.../khilman/linux-amlogic into next/soc
      Merge tag 'omap-for-v4.13/soc-v4-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'pxa-for-4.13' of https://github.com/rjarzmik/linux
into next/soc
      Merge tag 'davinci-for-v4.13/soc-2' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'qcom-soc-for-4.13' of
git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'renesas-soc-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'at91-ab-4.13-soc' of
git://git.kernel.org/.../abelloni/linux into next/soc
      Merge tag 'imx-soc-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'at91-4.12-fixes' of
git://git.kernel.org/.../abelloni/linux into next/soc

Petr Cvek (1):
      ARM: pxa: magician: Add support for ADS7846 touchscreen

Sebastian Reichel (3):
      ARM: OMAP4: hwmod data: add aes1
      ARM: OMAP4: hwmod data: add aes2
      ARM: OMAP4: hwmod data: add des

Suman Anna (3):
      ARM: davinci: da8xx: Create DSP device only when assigned memory
      ARM: davinci: da8xx: Add names to DSP IOMEM resources
      ARM: davinci: da8xx: Add DSP internal RAM memories as IOMEM resources

Szemz? Andr?s (3):
      ARM: at91: Add armv7m support
      ARM: at91: add armv7m SoC detection
      ARM: at91: debug: add samv7x support

Tero Kristo (7):
      ARM: OMAP2+: timer: add support for fetching fck handle from DT
      ARM: OMAP4: hwmod_data: add opt clks for dss_hdmi and dss_venc
      ARM: OMAP2+: PRCM: store also physical addresses for instances
      ARM: omap2+: clockdomain: add clkdm_xlate_address
      ARM: OMAP4: cminst: add support for clkdm_xlate_address
      ARM: OMAP2+: hwmod: populate clkctrl clocks for hwmods if available
      ARM: OMAP4: hwmod_data: add SHAM crypto accelerator

Tony Lindgren (12):
      ARM: OMAP2+: Remove unused legacy code for timer
      ARM: OMAP2+: Remove unused legacy code for opp
      ARM: OMAP2+: Remove unused legacy code for PMU
      ARM: OMAP2+: Remove unused legacy code for device init
      ARM: OMAP2+: Remove unused legacy code for McBSP
      ARM: OMAP2+: Remove unused legacy code for io.c
      ARM: OMAP2+: Remove unused legacy code for PRM
      ARM: OMAP2+: Remove unused legacy code for interconnects
      ARM: OMAP2+: Remove unused legacy code for watchdog
      ARM: OMAP2+: Remove unused legacy code for n8x0
      Merge branch 'omap-for-v4.13/legacy-v2' into omap-for-v4.13/soc-v3
      Merge branch 'omap-for-v4.13/clkctrl' into omap-for-v4.13/soc-v4

 Documentation/arm/Atmel/README                     |  38 +++-
 .../devicetree/bindings/arm/atmel-at91.txt         |  30 +++
 .../devicetree/bindings/power/actions,owl-sps.txt  |  17 ++
 MAINTAINERS                                        |  16 ++
 arch/arm/Kconfig                                   |   3 +
 arch/arm/Kconfig.debug                             |  41 ++++
 arch/arm/Makefile                                  |   1 +
 arch/arm/mach-actions/Kconfig                      |  16 ++
 arch/arm/mach-actions/Makefile                     |   3 +
 arch/arm/mach-actions/headsmp.S                    |  52 +++++
 arch/arm/mach-actions/platsmp.c                    | 171 ++++++++++++++++
 arch/arm/mach-at91/Kconfig                         |  17 +-
 arch/arm/mach-at91/Makefile                        |   4 +-
 arch/arm/mach-at91/Makefile.boot                   |   3 +
 arch/arm/mach-at91/generic.h                       |   2 +
 arch/arm/mach-at91/pm.c                            | 206 ++++++++++++++++---
 arch/arm/mach-at91/pm.h                            |   5 +
 arch/arm/mach-at91/pm_data-offsets.c               |   3 +
 arch/arm/mach-at91/pm_suspend.S                    |  73 +++++--
 arch/arm/mach-at91/sama5.c                         |  19 +-
 arch/arm/mach-at91/samv7.c                         |  25 +++
 arch/arm/mach-bcm/Kconfig                          |   2 +
 arch/arm/mach-davinci/board-dm646x-evm.c           |   4 +-
 arch/arm/mach-davinci/devices-da8xx.c              |  30 +++
 arch/arm/mach-davinci/include/mach/da8xx.h         |   5 +
 arch/arm/mach-davinci/pdata-quirks.c               |   4 +-
 arch/arm/mach-imx/Kconfig                          |   1 +
 arch/arm/mach-imx/cpu.c                            |   3 +
 arch/arm/mach-imx/mxc.h                            |   6 +
 arch/arm/mach-imx/pm-imx6.c                        |   6 +-
 arch/arm/mach-meson/Kconfig                        |   1 +
 arch/arm/mach-omap1/dma.c                          |   5 +-
 arch/arm/mach-omap1/timer.c                        |   4 +-
 arch/arm/mach-omap2/Makefile                       |   4 -
 arch/arm/mach-omap2/board-n8x0.c                   |  14 +-
 arch/arm/mach-omap2/clockdomain.c                  |   8 +
 arch/arm/mach-omap2/clockdomain.h                  |   2 +
 arch/arm/mach-omap2/cm.h                           |   7 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |   4 +-
 arch/arm/mach-omap2/cm33xx.c                       |   4 +-
 arch/arm/mach-omap2/cm3xxx.c                       |   3 +-
 arch/arm/mach-omap2/cm_common.c                    |  31 +--
 arch/arm/mach-omap2/cminst44xx.c                   |  29 ++-
 arch/arm/mach-omap2/devices.c                      | 175 ----------------
 arch/arm/mach-omap2/hsmmc.c                        |   5 +-
 arch/arm/mach-omap2/io.c                           |  59 ++----
 arch/arm/mach-omap2/mcbsp.c                        |  70 -------
 arch/arm/mach-omap2/omap-wakeupgen.c               |  68 ++++++-
 arch/arm/mach-omap2/omap_device.c                  |   5 +-
 arch/arm/mach-omap2/omap_hwmod.c                   | 168 +++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   3 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 146 +++++++++++++-
 arch/arm/mach-omap2/opp.c                          | 104 ----------
 arch/arm/mach-omap2/opp3xxx_data.c                 |  86 --------
 arch/arm/mach-omap2/opp4xxx_data.c                 |  79 --------
 arch/arm/mach-omap2/pm.c                           |   2 +-
 arch/arm/mach-omap2/pmu.c                          |  97 ---------
 arch/arm/mach-omap2/prcm-common.h                  |   7 +
 arch/arm/mach-omap2/prcm_mpu44xx.c                 |   4 +-
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h           |   4 +-
 arch/arm/mach-omap2/prm.h                          |   2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h                 |   4 +-
 arch/arm/mach-omap2/prm33xx.c                      |   4 +-
 arch/arm/mach-omap2/prm3xxx.c                      |  19 +-
 arch/arm/mach-omap2/prm44xx.c                      |  63 +-----
 arch/arm/mach-omap2/prm_common.c                   |  32 +--
 arch/arm/mach-omap2/prminst44xx.c                  |  16 +-
 arch/arm/mach-omap2/sr_device.c                    |  15 +-
 arch/arm/mach-omap2/timer.c                        | 200 +++++-------------
 arch/arm/mach-omap2/wd_timer.c                     |  28 ---
 arch/arm/mach-prima2/Kconfig                       |   1 -
 arch/arm/mach-pxa/include/mach/magician.h          |   1 +
 arch/arm/mach-pxa/magician.c                       |  84 +++++++-
 arch/arm/mach-pxa/pm.c                             |   4 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |   6 +-
 arch/arm/mach-rockchip/rockchip.c                  |   1 +
 arch/arm/mach-s3c64xx/Kconfig                      |   1 -
 arch/arm/mach-shmobile/pm-rmobile.c                |  19 +-
 arch/arm/mach-stm32/Kconfig                        |   5 +
 drivers/memory/atmel-ebi.c                         |   2 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/actions/Kconfig                        |  16 ++
 drivers/soc/actions/Makefile                       |   2 +
 drivers/soc/actions/owl-sps-helper.c               |  51 +++++
 drivers/soc/actions/owl-sps.c                      | 224 +++++++++++++++++++++
 drivers/soc/atmel/soc.c                            |  24 +++
 drivers/soc/atmel/soc.h                            |  26 +++
 include/dt-bindings/power/owl-s500-powergate.h     |  19 ++
 include/linux/platform_data/atmel.h                |  28 +--
 include/linux/soc/actions/owl-sps.h                |  11 +
 91 files changed, 1768 insertions(+), 1146 deletions(-)
