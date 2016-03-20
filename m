From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:31:31 +0100
Subject: [GIT PULL 3/8] ARM: SoC platform updates for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <9585683.S0JH2Jxiqi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 307d40c56b0c86315859ee724b51748260f50e65:

  ARM: uniphier: rework SMP code to support new System Bus binding (2016-03-18 17:36:37 +0100)

----------------------------------------------------------------
ARM: SoC platform updates for v4.6

Newly added support for additional SoCs:

- Axis Artpec-6 SoC family
- Allwinner A83T SoC
- NXP i.MX6QP SoC
- ST Microelectronics stm32f469 microcontroller

New features:
- SMP support for Mediatek mt7623
- SMP support for Mediatek mt2701
- Big-endian support for NXP i.MX
- DaVinci now uses the new DMA engine dma_slave_map
- OMAP now uses the new DMA engine dma_slave_map
- earlyprintk support for palmchip uart on mach-tango
- delay timer support for orion

Other:
- Exynos PMU driver moved out to drivers/soc/
- Various smaller updates for Renesas, Xilinx, PXA, AT91, OMAP, uniphier

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: alpine: select the Alpine MSI controller driver

Arnd Bergmann (22):
      ARM: pxa: define clock registers as __iomem
      ARM: pxa: mark spitz_card_pwr_ctrl as __maybe_unused
      ARM: pxa: mark unused eseries code as __maybe_unused
      ARM: pxa: don't select GPIO_SYSFS for MIOA701
      ARM: pxa: always select one of the two CPU types
      ARM: pxa: move extern declarations to pm.h
      ARM: pxa: fix building without IWMMXT
      ARM: pxa: don't select RFKILL if CONFIG_NET is disabled
      ARM: s3c24xx: Avoid warning for inb/outb
      Merge tag 'v4.5-next-soc' of https://github.com/mbgg/linux-mediatek into next/soc
      Merge tag 'renesas-soc-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'davinci-for-v4.6/edma' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'zynq-soc-for-4.6' of https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'arm-soc/for-4.6/soc' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'arm-soc/for-4.6/maintainers' of http://github.com/Broadcom/stblinux into next/soc
      ARM: imx: select ARM_CPU_SUSPEND only for imx6
      Merge tag 'sunxi-core-for-4.6' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'pxa-for-4.6' of https://github.com/rjarzmik/linux into next/soc
      ARM: at91: avoid defining CONFIG_* symbols in source code
      Merge tag 'imx-soc-4.6' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'omap-for-v4.6/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'stm32-soc-for-v4.6-2' of git://git.kernel.org/.../mcoquelin/stm32 into next/soc

Bai Ping (1):
      ARM: imx: Add msl code support for imx6qp

Bartlomiej Zolnierkiewicz (2):
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5420
      ARM: EXYNOS: Use generic cpufreq driver for Exynos5422/5800

Dirk Behme (1):
      ARM: imx: Do L2 errata only if the L2 cache isn't enabled

Fabio Estevam (1):
      ARM: mx25: Add basic suspend/resume support

Florian Fainelli (2):
      ARM: BCM63xx: Remove unused pmb_dn variable
      MAINTAINERS: ARM: BCM63xx: Update git and mailing-lists

Frank Li (2):
      ARM: imx: select HAVE_ARM_ARCH_TIMER if selected i.MX7D
      ARM: imx7d: correct chip version information

Geert Uytterhoeven (6):
      ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
      ARM: shmobile: r8a7740: Remove mapping of L2 cache controller registers
      ARM: shmobile: r8a7740: Remove legacy machine_desc.map_io() callback
      ARM: shmobile: emev2: Remove legacy machine_desc.map_io() callback
      ARM: shmobile: emev2: Move declaration of emev2_smp_ops to emev2.h
      ARM: shmobile: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains

Geliang Tang (1):
      ARM: plat-samsung: use to_platform_device()

Henry Chen (2):
      soc: mediatek: PMIC wrap: Clear the vldclr if state machine stay on FSM_VLDCLR state.
      soc: mediatek: PMIC wrap: clear the STAUPD_TRIG bit of WDT_SRC_EN

Jean-Christophe Dubois (1):
      ARM: imx6: fix cleanup path in imx6q_suspend_init()

Johannes Berg (2):
      ARM: imx: use endian-safe readl/readw/writel/writew
      ARM: imx: enable big endian mode

John Crispin (1):
      ARM: mediatek: add MT7623 smp bringup code

Josh Cartwright (2):
      ARM: zynq: initialize slcr mapping earlier
      ARM: zynq: address L2 cache data corruption

Keerthy (2):
      ARM: AM43XX: hwmod: Add rtc hwmod
      ARM: OMAP: DRA7: Make use of omap_revision information for soc_is* calls

Kishon Vijay Abraham I (2):
      ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
      ARM: DRA7: hwmod: Add reset data for PCIe

Krzysztof Kozlowski (1):
      drivers: soc: samsung: Enable COMPILE_TEST

Lars Persson (2):
      arm: initial machine port for artpec-6 SoC
      ARM: mach-artpec: add entry to MAINTAINERS

Lee Jones (1):
      ARM: stm32: Identify a new SoC - STM32F469

Louis Yu (1):
      ARM: mediatek: add mt2701 smp bringup code

Mans Rullgard (1):
      ARM: debug: add support for Palmchip BK-310x UART

Masahiro Yamada (4):
      ARM: bcm: use const and __initconst for smp_operations
      ARM: s3c64xx: use "depends on" instead of "if" after prompt
      ARM: uniphier: add missing of_node_put()
      ARM: uniphier: rework SMP code to support new System Bus binding

Matthias Brugger (1):
      soc: mediatek: SCPSYS: use builtin_platform_driver

Maxime Coquelin (2):
      ARM: Kconfig: Introduce MACH_STM32F429 flag
      ARM: mach-stm32: Select pinctrl

Michal Simek (1):
      ARM: zynq: Move early printk virtual address to vmalloc area

Olof Johansson (3):
      Merge tag 'mvebu-drivers-4.6-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'stm32-soc-for-v4.6-1' of git://git.kernel.org/.../mcoquelin/stm32 into next/soc
      Merge tag 'samsung-soc-4.6-2' of git://git.kernel.org/.../krzk/linux into next/soc

Pankaj Dubey (12):
      ARM: EXYNOS: Remove unused static mapping of CMU for exynos5
      ARM: EXYNOS: Code cleanup in map.h
      ARM: EXYNOS: Correct header comment in Kconfig file
      ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
      ARM: EXYNOS: Split up exynos3250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos4 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5250 SoC specific PMU data
      ARM: EXYNOS: Split up exynos5420 SoC specific PMU data
      drivers: soc: Add support for Exynos PMU driver
      MAINTAINERS: Add maintainers entry for drivers/soc/samsung
      ARM: EXYNOS: Cleanup header files inclusion
      ARM: SAMSUNG: Remove unused register offset definition

Peter Ujfalusi (8):
      ARM: davinci: devices-da8xx: Add dma_slave_map to edma
      ARM: davinci: dm355: Add dma_slave_map to edma
      ARM: davinci: dm365: Add dma_slave_map to edma
      ARM: davinci: dm644x: Add dma_slave_map to edma
      ARM: davinci: dm646x: Add dma_slave_map to edma
      ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
      ARM: OMAP2+: DMA: Provide dma_slave_map to omap-dma for legacy boot
      ARM: DRA7: hwmod: Add data for eDMA tpcc, tptc0, tptc1

Philipp Zabel (1):
      ARM: imx: Make reset_control_ops const

Robert Jarzmik (5):
      ARM: pxa: pxa3xx device-tree support cleanup
      dma: mmp_pdma: Add the #dma-requests DT property documentation
      dmaengine: mmp-pdma: add number of requestors
      ARM: pxa: add the number of DMA requestor lines
      dmaengine: pxa_dma: fix the maximum requestor line

Russell King (1):
      ARM: orion: implement ARM delay timer

Sascha Hauer (1):
      soc: mediatek: SCPSYS: Fix double enabling of regulators

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI data for omap36xx

Sekhar Nori (1):
      ARM: DRA7: hwmod: Add custom reset handler for PCIeSS

Tony Lindgren (2):
      ARM: OMAP2+: Add rtc hwmod configuration for ti81xx
      Merge tag 'for-v4.6/omap-hwmod-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/soc

Vishnu Patekar (1):
      ARM: sunxi: Introduce Allwinner for A83T support

 Documentation/arm/sunxi/README                     |   1 -
 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 Documentation/devicetree/bindings/dma/mmp-dma.txt  |   2 +
 MAINTAINERS                                        |  16 +-
 arch/arm/Kconfig                                   |   9 +
 arch/arm/Kconfig.debug                             |   9 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/pxa27x.dtsi                      |   1 +
 arch/arm/boot/dts/pxa3xx.dtsi                      |   1 +
 arch/arm/configs/pxa_defconfig                     |   1 +
 arch/arm/include/debug/at91.S                      |   4 +-
 arch/arm/include/debug/imx.S                       |   3 +
 arch/arm/include/debug/palmchip.S                  |  11 +
 arch/arm/include/debug/zynq.S                      |   4 +-
 arch/arm/mach-alpine/Kconfig                       |   1 +
 arch/arm/mach-artpec/Kconfig                       |  20 +
 arch/arm/mach-artpec/Makefile                      |   1 +
 arch/arm/mach-artpec/board-artpec6.c               |  72 ++
 arch/arm/mach-bcm/bcm63xx_pmb.c                    |   2 -
 arch/arm/mach-bcm/platsmp.c                        |   2 +-
 arch/arm/mach-davinci/devices-da8xx.c              |  46 +
 arch/arm/mach-davinci/dm355.c                      |  20 +
 arch/arm/mach-davinci/dm365.c                      |  22 +
 arch/arm/mach-davinci/dm644x.c                     |  12 +
 arch/arm/mach-davinci/dm646x.c                     |  11 +
 arch/arm/mach-exynos/Kconfig                       |   4 +-
 arch/arm/mach-exynos/Makefile                      |   2 +-
 arch/arm/mach-exynos/common.h                      |   1 -
 arch/arm/mach-exynos/exynos.c                      |  17 +-
 arch/arm/mach-exynos/firmware.c                    |   2 -
 arch/arm/mach-exynos/include/mach/map.h            |  14 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |   3 +-
 arch/arm/mach-exynos/pm.c                          |   8 +-
 arch/arm/mach-exynos/pmu.c                         | 967 ---------------------
 arch/arm/mach-exynos/s5p-dev-mfc.c                 |   1 -
 arch/arm/mach-exynos/suspend.c                     |   4 +-
 arch/arm/mach-imx/3ds_debugboard.c                 |  30 +-
 arch/arm/mach-imx/Kconfig                          |   4 +-
 arch/arm/mach-imx/Makefile                         |   2 +-
 arch/arm/mach-imx/anatop.c                         |  18 +-
 arch/arm/mach-imx/avic.c                           |  30 +-
 arch/arm/mach-imx/common.h                         |   1 +
 arch/arm/mach-imx/cpu-imx27.c                      |   3 +-
 arch/arm/mach-imx/cpu-imx31.c                      |   2 +-
 arch/arm/mach-imx/cpu-imx35.c                      |   2 +-
 arch/arm/mach-imx/cpu.c                            |  16 +-
 arch/arm/mach-imx/epit.c                           |  22 +-
 arch/arm/mach-imx/headsmp.S                        |   2 +
 arch/arm/mach-imx/iomux-imx31.c                    |  12 +-
 arch/arm/mach-imx/iomux-v1.c                       |   4 +-
 arch/arm/mach-imx/iomux-v3.c                       |   6 +-
 arch/arm/mach-imx/mach-armadillo5x0.c              |   4 +-
 arch/arm/mach-imx/mach-imx25.c                     |   1 +
 arch/arm/mach-imx/mach-imx51.c                     |   5 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   8 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |   6 +-
 arch/arm/mach-imx/mach-mx31ads.c                   |  16 +-
 arch/arm/mach-imx/mach-mx31moboard.c               |   2 +-
 arch/arm/mach-imx/mach-qong.c                      |   6 +-
 arch/arm/mach-imx/mxc.h                            |   5 +
 arch/arm/mach-imx/pm-imx25.c                       |  37 +
 arch/arm/mach-imx/pm-imx27.c                       |   4 +-
 arch/arm/mach-imx/pm-imx3.c                        |   4 +-
 arch/arm/mach-imx/pm-imx5.c                        |  26 +-
 arch/arm/mach-imx/pm-imx6.c                        |   8 +-
 arch/arm/mach-imx/src.c                            |   2 +-
 arch/arm/mach-imx/system.c                         |  10 +-
 arch/arm/mach-imx/tzic.c                           |  34 +-
 arch/arm/mach-mediatek/platsmp.c                   |   8 +
 arch/arm/mach-omap1/dma.c                          |  45 +
 arch/arm/mach-omap2/dma.c                          | 117 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  13 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  14 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 129 ++-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  38 +
 arch/arm/mach-omap2/prm7xx.h                       |   1 +
 arch/arm/mach-omap2/soc.h                          |  23 +-
 arch/arm/mach-pxa/Kconfig                          |   3 +-
 arch/arm/mach-pxa/devices.c                        |   3 +-
 arch/arm/mach-pxa/eseries.c                        |   4 +-
 arch/arm/mach-pxa/gumstix.c                        |   6 +-
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h       |   8 +-
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h       |   2 +-
 arch/arm/mach-pxa/pm.h                             |   3 +
 arch/arm/mach-pxa/pxa-dt.c                         |  24 -
 arch/arm/mach-pxa/pxa25x.c                         |   2 +-
 arch/arm/mach-pxa/pxa27x.c                         |   8 +-
 arch/arm/mach-pxa/pxa3xx.c                         |  11 +-
 arch/arm/mach-pxa/spitz.c                          |   2 +-
 arch/arm/mach-pxa/zeus.c                           |   2 +-
 arch/arm/mach-s3c24xx/include/mach/io.h            |   2 +-
 arch/arm/mach-s3c24xx/include/mach/map.h           |  11 -
 arch/arm/mach-s3c64xx/Kconfig                      |   3 +-
 arch/arm/mach-shmobile/Kconfig                     |  13 +-
 arch/arm/mach-shmobile/emev2.h                     |   6 +
 arch/arm/mach-shmobile/setup-emev2.c               |  22 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  39 +-
 arch/arm/mach-shmobile/smp-emev2.c                 |   2 +
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 arch/arm/mach-sunxi/sunxi.c                        |   1 +
 arch/arm/mach-uniphier/platsmp.c                   |  26 +-
 arch/arm/mach-zynq/common.c                        |   3 +-
 arch/arm/mach-zynq/slcr.c                          |   4 +
 arch/arm/plat-orion/time.c                         |  13 +
 arch/arm/plat-pxa/include/plat/dma.h               |   2 +-
 arch/arm/plat-samsung/adc.c                        |   6 +-
 arch/arm/plat-samsung/include/plat/map-s3c.h       |   4 -
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   5 -
 drivers/clk/pxa/clk-pxa25x.c                       |  12 +-
 drivers/clk/pxa/clk-pxa27x.c                       |  34 +-
 drivers/clk/pxa/clk-pxa3xx.c                       |   3 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   2 +-
 drivers/dma/pxa_dma.c                              |  39 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  41 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |  60 +-
 drivers/soc/samsung/Kconfig                        |  13 +
 drivers/soc/samsung/Makefile                       |   2 +
 drivers/soc/samsung/exynos-pmu.c                   | 141 +++
 drivers/soc/samsung/exynos-pmu.h                   |  44 +
 drivers/soc/samsung/exynos3250-pmu.c               | 175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  | 222 +++++
 drivers/soc/samsung/exynos5250-pmu.c               | 195 +++++
 drivers/soc/samsung/exynos5420-pmu.c               | 280 ++++++
 include/linux/platform_data/mmp_dma.h              |   1 +
 .../linux/soc/samsung}/exynos-pmu.h                |   6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   6 +-
 129 files changed, 2145 insertions(+), 1392 deletions(-)
 create mode 100644 arch/arm/include/debug/palmchip.S
 create mode 100644 arch/arm/mach-artpec/Kconfig
 create mode 100644 arch/arm/mach-artpec/Makefile
 create mode 100644 arch/arm/mach-artpec/board-artpec6.c
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 arch/arm/mach-imx/pm-imx25.c
 create mode 100644 arch/arm/mach-shmobile/emev2.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
