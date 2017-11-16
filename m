From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Nov 2017 23:00:39 +0100
Subject: [GIT PULL 1/3] ARM: SoC platform updates for 4.15
Message-ID: <CAK8P3a3k-SfpRFD4XvynBwJT3i7m7uvi6EgNHQSd64MTwPEtvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  ssh://git at gitolite.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-soc

for you to fetch changes up to fa32475ad56d339178c9be12678906f2b39e3b47:

  Merge tag 'actions-arm-soc-for-4.15' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions
into next/soc (2017-11-07 16:32:04 +0100)

----------------------------------------------------------------
ARM: SoC platform updates for 4.15

Most of the commits are for defconfig changes, to enable newly added
drivers or features that people have started using. For the changed
lines lines, we have mostly cleanups, the affected platforms are
OMAP, Versatile, EP93xx, Samsung, Broadcom, i.MX, and Actions.

The largest single change is the introduction of the TI "sysc" bus
driver, with the intention of cleaning up more legacy code.

Two new SoC platforms get added this time:
- Allwinner R40 is a modernized version of the A20 chip, now
  with a Quad-Core ARM Cortex-A7. According to the manufacturer,
  it is intended for "Smart Hardware"
- Broadcom Hurricane 2 (Aka Strataconnect BCM5334X) is a family
  of chips meant for managed gigabit ethernet switches, based
  around a Cortex-A9 CPU.

Finally, we gain SMP support for two platforms: Renesas R-Car E2
and Amlogic Meson8/8b, which were previously added but only supported
uniprocessor operation.

----------------------------------------------------------------
There are a few simple merge conflicts in the first
two pull requests, the resolution should be obvious,
just note the alphabetical ordering in those files.
----------------------------------------------------------------

Adam Ford (1):
      ARM: davinci_all_defconfig: enable MTD_CMDLINE_PARTS

Alex Elder (1):
      arm64: defconfig: re-enable Qualcomm DB410c USB

Alexandre Torgue (1):
      ARM: configs: stm32: Update default configuration for v4.14-rc1

Andreas F?rber (2):
      ARM: owl: smp: Use __pa_symbol()
      ARM: owl: smp: Drop owl_secondary_boot()

Antoine Tenart (1):
      arm64: defconfig: enable the Marvell 10G PHY as a module

Anup Patel (1):
      ARM: multi_v7_defconfig: Select RPMSG_VIRTIO as module

Arnd Bergmann (33):
      ARM: shmobile: rcar-gen2: fix non-SMP build
      bus: ti-sysc: mark PM functions as __maybe_unused
      Merge tag 'ep93xx-for-arm-soc-1' of
git://git.kernel.org/.../linusw/linux-integrator into next/soc
      Merge tag 'renesas-defconfig-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-soc-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'arm-soc/for-4.15/soc' of
http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'integrator-pciv3-delete' of
git://git.kernel.org/.../linusw/linux-integrator into next/soc
      Merge tag 'renesas-arm64-defconfig-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'vexpress-updates-4.15' of
git://git.kernel.org/.../sudeep.holla/linux into next/soc
      Merge tag 'renesas-soc2-for-v4.15' of
https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'hisi-defconfig-for-4.15' of
git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'davinci-for-v4.15/defconfig' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'omap-for-v4.15/soc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'samsung-defconfig-4.15' of
git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'samsung-soc-4.15' of
git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'zynq-soc-for-4.15' of
https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'qcom-arm64-defconfig-for-4.15' of
git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'qcom-defconfig-for-4.15' of
git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'stm32-defconfig-for-v4.15-1' of
git://git.kernel.org/.../atorgue/stm32 into next/soc
      Merge tag 'omap-for-v4.15/ti-sysc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'sunxi-core-for-4.15' of
https://git.kernel.org/.../sunxi/linux into next/soc
      Merge tag 'tegra-for-4.15-arm64-defconfig' of
git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'mvebu-arm64-4.15-1' of
git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'imx-defconfig-4.15' of
git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'amlogic-defconfig' of
git://git.kernel.org/.../khilman/linux-amlogic into next/soc
      Merge tag 'keystone_config_4.15' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/soc
      Merge tag 'arm-soc/for-4.15/defconfig' of
http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'arm-soc/for-4.15/soc-part2' of
http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'arm-soc/for-4.15/maintainers' of
http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'imx-soc-4.15' of
git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'amlogic-soc' of
git://git.kernel.org/.../khilman/linux-amlogic into next/soc
      Merge tag 'omap-for-v4.15/coccinelle-signed' of
ssh://gitolite.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'actions-arm-soc-for-4.15' of
ssh://gitolite.kernel.org/.../afaerber/linux-actions into next/soc

Arvind Yadav (1):
      ARM: mxs: constify platform_suspend_ops

Bhumika Goyal (2):
      ARM: omap1: add const and initconst to omap_lcd_config
      ARM: OMAP2+: make omap_dma_dev_info __initdata

Biju Das (1):
      ARM: multi_v7_defconfig: Enable BQ32000 RTC driver

Bjorn Andersson (3):
      ARM: qcom_defconfig: Resync with new Kconfig options
      ARM: qcom_defconfig: Disable DEBUG_GPIO
      ARM: qcom_defconfig: Enable Z2 Tablet related options

Carlo Caione (1):
      dt-bindings: Amlogic: Add Meson8 and Meson8b SMP related documentation

Danilo Krummrich (1):
      clk: bcm2835: remove remains from stub clk driver

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Select CONFIG_MUX_MMIO
      ARM: imx_v6_v7_defconfig: Select the CEC driver
      cpufreq: imx6q: Move speed grading check to cpufreq driver

Fabrizio Castro (1):
      ARM: debug-ll: Add support for r8a7745

Florian Fainelli (6):
      Merge tag 'bcm2835-soc-next-2017-08-24' into soc/next
      ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping
      MAINTAINERS: Update Broadcom iProc regexp with Hurricane 2
      ARM: bcm: Add support for Broadcom Hurricane 2 SoC
      ARM: debug: Add Hurricane 2 UART2 debug addresses
      ARM: multi_v7_defconfig: Enable CONFIG_ARCH_BCM_HR2

Geert Uytterhoeven (3):
      arm64: defconfig: Enable Renesas R8A77995 SoC
      ARM: Add definition for monitor mode
      ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15

Gregory CLEMENT (2):
      arm64: defconfig: enable NAND on Armada 7K/8K SoCs
      arm64: defconfig: enable RTC on Armada 7K/8K SoCs

H Hartley Sweeten (4):
      ARM: ep93xx: switch to SPARSEMEM
      ARM: ep93xx: simone: let the mmc_spi driver handle the card detect
      ARM: ep93xx: tidy up TS-72xx Watchdog resources
      ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards

Icenowy Zheng (3):
      dt-bindings: add compatible string for Allwinner V3s SoC
      ARM: sunxi: fix the core number of V3s in sunxi README
      ARM: sunxi: add support for R40 SoC

Jerome Brunet (1):
      ARM: meson: enable MESON_IRQ_GPIO in Kconfig for meson8b

Kefeng Wang (1):
      arm64: defconfig: Enable hisilicon hibmc drm driver

Leonard Crestez (1):
      ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1

Linus L?ssing (1):
      ARM: multi_v7_defconfig: Enable USB3503 driver

Linus Walleij (2):
      ARM: integrator: Delete the V3 PCI driver
      ARM: defconfig: select the right SX150X driver

Marco Franchi (4):
      ARM: imx: imx31moboard: Include "board-mx31moboard.h" header file
      ARM: imx: 3ds-debugboard: Include "3ds_debugboard.h" header file
      ARM: imx: cpuidle-imx5: Include "cpuidle.h" header file
      ARM: imx: mach-mx31lite: Make mx31lite_map_io static

Marek Szyprowski (3):
      ARM: exynos_defconfig: Enable UAS support for Odroid HC1 board
      ARM: multi_v7_defconfig: Enable UAS support for Odroid HC1 board
      ARM: EXYNOS: Remove Exynos4212 related dead code

Markus Elfring (14):
      ARM: vexpress/spc: Delete an error message for a failed memory allocation
      ARM: s3c24xx: Remove printk for failed memory allocation in iotiming get
      ARM: s3c24xx: Simplify size used for kzalloc in iotiming get
      ARM: s3c2410: Fix typos in a comments
      ARM: s3c64xx: Remove printk for failed memory allocation in samsung_bl_set
      ARM: s3c64xx: Delete an unnecessary return statement in samsung_bl_set
      ARM: SAMSUNG: Remove printk for failed memory allocation
      ARM: SAMSUNG: Simplify size used for kzalloc
      ARM: OMAP: Delete an error message for a failed memory
allocation in two functions
      ARM: OMAP: Improve a size determination in two functions
      ARM: OMAP: Use kcalloc() in omap_system_dma_probe()
      ARM: OMAP: Fix typos in two comment lines in _omap_dm_timer_request()
      ARM: OMAP3: Use common error handling code in omap3xxx_hwmod_init()
      ARM: OMAP3: Delete an unnecessary variable initialisation in
omap3xxx_hwmod_init()

Martin Blumenstingl (4):
      ARM: multi_v7_defconfig: enable the Meson MX SDIO/MMC controller
      ARM: smp_scu: add a helper for powering on a specific CPU
      ARM: smp_scu: allow the platform code to read the SCU CPU status
      ARM: meson: Add SMP bringup code for Meson8 and Meson8b

Masahiro Yamada (2):
      arm64: defconfig: enable CONFIG_GPIO_UNIPHIER
      ARM: multi_v7_defconfig: enable CONFIG_GPIO_UNIPHIER

Miquel Raynal (1):
      arm64: defconfig: enable Marvell CP110 comphy

Nicolas Dechesne (2):
      arm64: defconfig: Enable QCOM_IOMMU
      arm64: defconfig: Enable QCOM_IOMMU

Phil Elwell (1):
      ARM: bcm2836: Send event when onlining other cores

Pierre-Yves MORDRET (3):
      ARM: configs: stm32: Add DMAMUX support in STM32 defconfig
      ARM: configs: stm32: Add I2C F7 support in STM32 defconfig
      ARM: configs: stm32: Add MDMA support in STM32 defconfig

Robin Murphy (1):
      arm64: Add ThunderX drivers to defconfig

Sergei Shtylyov (1):
      arm64: defconfig: enable R8A77970 SoC

Soren Brinkmann (1):
      MAINTAINERS: Remove myself as reviewer

Stefan Wahren (1):
      irqchip: bcm2836: Move SMP startup code to arch/arm (v2)

Stephen Boyd (1):
      ARM: qcom_defconfig: Enable configs for USB on apq8064/msm8974

Suman Anna (1):
      ARM: davinci_all_defconfig: enable CMA options

Tony Lindgren (28):
      ARM: dts: Add missing dma hwmods property for omap3
      ARM: dts: Configure pmu without interrupt for omap4430
      ARM: dts: Add missing properties for omap4 control modules
      ARM: dts: Add missing hwmods property for omap4 dma
      ARM: dts: Add missing smartreflex node and binding for omap4
      ARM: dts: Add missing onewire node for omap4
      ARM: dts: Add missing hsi node for omap4
      ARM: dts: Add missing wdt3 node for omap4
      ARM: dts: Add missing dma hwmod property for omap5
      ARM: dts: Add missing hwmod related nodes for am33xx
      ARM: dts: Add missing hwmod related properties for dra7
      ARM: OMAP2+: Fix MMC address space mismatch for am33xx and am43xx
      ARM: OMAP2+: Fix overwriting of clkctrl and modulemode values
      ARM: OMAP2+: Drop unused omap_init_hdq
      ARM: OMAP2+: Drop unused omap_hwmod_mux_info
      dt-bindings: bus: Minimal TI sysc interconnect target module binding
      ARM: dts: Add nodes for missing omap4 interconnect target modules
      ARM: dts: Configure SmartReflex only to idle the interconnect
target module
      Merge branch 'omap-for-v4.15/fixes-dt' into omap-for-v4.15/ti-sysc
      ARM: OMAP2+: Parse module IO range from dts for legacy "ti,hwmods" support
      ARM: OMAP2+: Populate legacy resources for dma and smartreflex
      bus: ti-sysc: Add minimal TI sysc interconnect target driver
      ARM: OMAP3: Remove legacy IRQ for PRM
      ARM: OMAP4: Remove legacy IRQ for PRM
      ARM: OMAP2+: Drop omap_hwmod_irq_info
      ARM: OMAP2+: Drop omap_hwmod_dma_info
      ARM: OMAP2+: Drop legacy struct omap_hwmod_addr_space
      bus: ti-sysc: Fix unbalanced pm_runtime_enable by adding remove

Tuomas Tynkkynen (1):
      arm64: defconfig: Enable Tegra PCI controller

Vignesh R (1):
      ARM: configs: keystone: Enable TIECAP PWM driver

Vishal Mahaveer (2):
      ARM: DRA722: remove redundant definition of 1.0 device
      ARM: DRA722: Add support for DRA71x Silicon Rev 2.1

Wei Yongjun (1):
      ARM: OMAP2+: omap_device: fix error return code in
omap_device_copy_resources()

Wolfram Sang (1):
      arm64: defconfig: enable thermal driver for Renesas R-Car Gen3

 Documentation/arm/sunxi/README                     |  11 +-
 .../devicetree/bindings/arm/amlogic/pmu.txt        |  18 +
 .../devicetree/bindings/arm/amlogic/smp-sram.txt   |  32 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   2 +
 .../devicetree/bindings/arm/omap/ctrl.txt          |   2 +
 Documentation/devicetree/bindings/arm/sunxi.txt    |   2 +
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |  93 +++
 Documentation/devicetree/bindings/hsi/omap-ssi.txt |  13 +-
 .../bindings/memory-controllers/ti/emif.txt        |   6 +-
 .../devicetree/bindings/power/ti-smartreflex.txt   |  47 ++
 MAINTAINERS                                        |   2 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/Kconfig.debug                             |  20 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/am33xx.dtsi                      |  10 +-
 arch/arm/boot/dts/dra7.dtsi                        |  34 +
 arch/arm/boot/dts/omap3.dtsi                       |   1 +
 arch/arm/boot/dts/omap4.dtsi                       | 256 +++++-
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 arch/arm/configs/davinci_all_defconfig             |   4 +-
 arch/arm/configs/exynos_defconfig                  |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   2 +
 arch/arm/configs/keystone_defconfig                |   2 +
 arch/arm/configs/lpc32xx_defconfig                 |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   7 +
 arch/arm/configs/qcom_defconfig                    |  42 +-
 arch/arm/configs/stm32_defconfig                   |  11 +-
 arch/arm/include/asm/smp_scu.h                     |  12 +
 arch/arm/include/debug/brcmstb.S                   |   3 +
 arch/arm/include/uapi/asm/ptrace.h                 |   1 +
 arch/arm/kernel/smp_scu.c                          |  43 +-
 arch/arm/mach-actions/Makefile                     |   4 +-
 arch/arm/mach-actions/headsmp.S                    |  52 --
 arch/arm/mach-actions/platsmp.c                    |   2 +-
 arch/arm/mach-bcm/Kconfig                          |   9 +
 arch/arm/mach-bcm/Makefile                         |   8 +
 arch/arm/mach-bcm/bcm_hr2.c                        |  25 +
 arch/arm/mach-bcm/board_bcm2835.c                  |  11 +-
 arch/arm/mach-bcm/platsmp.c                        |  38 +
 arch/arm/mach-bcm/platsmp.h                        |  10 +
 arch/arm/mach-ep93xx/simone.c                      |  54 +-
 arch/arm/mach-ep93xx/ts72xx.c                      |  46 +-
 arch/arm/mach-ep93xx/ts72xx.h                      |   3 -
 arch/arm/mach-exynos/Kconfig                       |   5 -
 arch/arm/mach-exynos/common.h                      |  11 +-
 arch/arm/mach-exynos/exynos.c                      |   2 -
 arch/arm/mach-exynos/firmware.c                    |   5 -
 arch/arm/mach-exynos/pm.c                          |   3 +-
 arch/arm/mach-exynos/suspend.c                     |   4 -
 arch/arm/mach-imx/3ds_debugboard.c                 |   2 +-
 arch/arm/mach-imx/cpuidle-imx5.c                   |   1 +
 arch/arm/mach-imx/mach-imx6q.c                     |  97 +--
 arch/arm/mach-imx/mach-mx31lite.c                  |   2 +-
 arch/arm/mach-imx/mx31moboard-devboard.c           |   1 +
 arch/arm/mach-imx/mx31moboard-marxbot.c            |   1 +
 arch/arm/mach-integrator/Makefile                  |   2 -
 arch/arm/mach-integrator/integrator_ap.c           |   2 -
 arch/arm/mach-integrator/pci_v3.c                  | 900 ---------------------
 arch/arm/mach-integrator/pci_v3.h                  |   9 -
 arch/arm/mach-meson/Kconfig                        |   2 +
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/platsmp.c                      | 440 ++++++++++
 arch/arm/mach-mxs/pm.c                             |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   2 +-
 arch/arm/mach-omap1/board-fsample.c                |   2 +-
 arch/arm/mach-omap1/board-h2.c                     |   2 +-
 arch/arm/mach-omap1/board-h3.c                     |   2 +-
 arch/arm/mach-omap1/board-htcherald.c              |   2 +-
 arch/arm/mach-omap1/board-innovator.c              |   4 +-
 arch/arm/mach-omap1/board-nokia770.c               |   2 +-
 arch/arm/mach-omap1/board-osk.c                    |   2 +-
 arch/arm/mach-omap1/board-palmte.c                 |   2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |   2 +-
 arch/arm/mach-omap1/board-palmz71.c                |   2 +-
 arch/arm/mach-omap1/board-perseus2.c               |   2 +-
 arch/arm/mach-omap1/board-sx1.c                    |   2 +-
 arch/arm/mach-omap2/Kconfig                        |   1 +
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/common.h                       |   1 -
 arch/arm/mach-omap2/dma.c                          |   2 +-
 arch/arm/mach-omap2/hdq1w.c                        |  22 -
 arch/arm/mach-omap2/id.c                           |   5 +-
 arch/arm/mach-omap2/omap4-common.c                 |  24 -
 arch/arm/mach-omap2/omap_device.c                  | 294 +++----
 arch/arm/mach-omap2/omap_device.h                  |   4 -
 arch/arm/mach-omap2/omap_hwmod.c                   | 569 +++----------
 arch/arm/mach-omap2/omap_hwmod.h                   |  88 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   2 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   2 -
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  27 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  15 -
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   6 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 130 ---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  39 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  61 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 548 -------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  20 -
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  57 --
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  44 -
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  41 -
 arch/arm/mach-omap2/prcm-common.h                  |   1 -
 arch/arm/mach-omap2/prm.h                          |   2 -
 arch/arm/mach-omap2/prm3xxx.c                      |  14 +-
 arch/arm/mach-omap2/prm44xx.c                      |  21 +-
 arch/arm/mach-omap2/prm_common.c                   |  12 +-
 arch/arm/mach-omap2/soc.h                          |   2 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           |   8 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |   8 +-
 arch/arm/mach-s3c64xx/dev-backlight.c              |  10 +-
 arch/arm/mach-shmobile/Makefile                    |   1 +
 arch/arm/mach-shmobile/common.h                    |   2 +
 arch/arm/mach-shmobile/headsmp-apmu.S              |  39 +
 arch/arm/mach-shmobile/platsmp-apmu.c              |   2 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c           |  20 +-
 arch/arm/mach-sunxi/sunxi.c                        |   1 +
 arch/arm/mach-vexpress/spc.c                       |   8 +-
 arch/arm/plat-omap/dma.c                           |  12 +-
 arch/arm/plat-omap/dmtimer.c                       |  10 +-
 arch/arm/plat-samsung/adc.c                        |  12 +-
 arch/arm/plat-samsung/devs.c                       |  33 +-
 arch/arm/plat-samsung/platformdata.c               |   4 +-
 arch/arm64/configs/defconfig                       |  17 +
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/ti-sysc.c                              | 583 +++++++++++++
 drivers/clk/bcm/clk-bcm2835-aux.c                  |   1 -
 drivers/clk/bcm/clk-bcm2835.c                      |  30 -
 drivers/cpufreq/imx6q-cpufreq.c                    |  85 +-
 drivers/irqchip/irq-bcm2836.c                      |  79 +-
 include/linux/clk/bcm2835.h                        |  24 -
 include/linux/irqchip/irq-bcm2836.h                |  70 ++
 132 files changed, 2344 insertions(+), 3252 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic/smp-sram.txt
 create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/power/ti-smartreflex.txt
 delete mode 100644 arch/arm/mach-actions/headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm_hr2.c
 create mode 100644 arch/arm/mach-bcm/platsmp.h
 delete mode 100644 arch/arm/mach-integrator/pci_v3.c
 delete mode 100644 arch/arm/mach-integrator/pci_v3.h
 create mode 100644 arch/arm/mach-meson/platsmp.c
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
 create mode 100644 arch/arm/mach-shmobile/headsmp-apmu.S
 create mode 100644 drivers/bus/ti-sysc.c
 delete mode 100644 include/linux/clk/bcm2835.h
 create mode 100644 include/linux/irqchip/irq-bcm2836.h
