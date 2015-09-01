From: olof@lixom.net (Olof Johansson)
Date: Mon, 31 Aug 2015 17:07:06 -0700
Subject: [GIT PULL 3/7] ARM: SoC platform updates for v4.3
In-Reply-To: <1441066030-23225-1-git-send-email-olof@lixom.net>
References: <1441066030-23225-1-git-send-email-olof@lixom.net>
Message-ID: <1441066030-23225-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New or improved SoC support:

- Addition of support for Atmel's SAMA5D2 SoC
- Addition of Freescale i.MX6UL
- Improved support of TI's DM814x platform
- Misc fixes and improvements for RockChip platforms
- Marvell MVEBU suspend/resume support

A few driver changes that ideally would belong in the drivers branch are
also here (acked by appropriate maintainers):

- Power key input driver for Freescale platforms (svns)
- RTC driver updates for Freescale platforms (svns/mxc)
- Clk fixes for TI DM814/816X

+ a bunch of other changes for various platforms


Conflicts:

arch/arm/mach-at91/sama5.c:

Change/add with cleanup branch. Keep array declaration from HEAD, add
sama5d2 entry from branch.

----------------------------------------------------------------

The following changes since commit 597e2b048c61a26437706c85e0ad4323b6df8c41:

  Merge branch 'next/cleanup' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 1ec6f701707e4e97e451ff8b662360f1262a6c59:

  Merge tag 'v4.3-rockchip32-soc3' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into next/soc

----------------------------------------------------------------

Anson Huang (1):
      ARM: imx: add low-level debug support for i.mx6ul

Arun Chandran (1):
      ARM: zynq: Fix earlyprintk in big endian mode

Caesar Wang (4):
      ARM: rockchip: fix the CPU soft reset
      ARM: rockchip: ensure CPU to enter WFI/WFE state
      ARM: rockchip: fix the SMP code style
      ARM: rockchip: fix broken build

Chris Zhong (2):
      ARM: rockchip: add support holding 24Mhz osc during suspend
      ARM: rockchip: remove some useless macro in pm.h

Dinh Nguyen (1):
      ARM: socfpga: add reset for the Arria 10 platform

Doug Anderson (1):
      ARM: rockchip: restore dapswjdp after suspend

Fabio Estevam (2):
      ARM: imx: mach-imx6ul: Fix allmodconfig build
      ARM: rockchip: pm: Fix PTR_ERR() argument

Frank Li (4):
      ARM: imx: add i.mx6ul msl support
      rtc: snvs: use syscon to access register
      Document: dt: fsl: snvs: change support syscon
      Document: devicetree: input: imx: i.mx snvs power device tree bindings

Fugang Duan (2):
      ARM: imx6ul: add fec bits to GPR syscon definition
      ARM: imx6ul: add fec MAC refrence clock and phy fixup init

Gregory CLEMENT (3):
      ARM: mvebu: Use __init for the PM initialization functions
      ARM: mvebu: Add standby support
      ARM: mvebu: Warn about the wake-up sources not taken into account in suspend

Gregory Fong (2):
      ARM: BCM: Enable ARM erratum 798181 for BRCMSTB
      ARM: brcmstb: select ARCH_DMA_ADDR_T_64BIT for LPAE

Heiko Stuebner (3):
      ARM: rockchip: rename osc_switch_to_32k variable
      ARM: rockchip: set correct stabilization thresholds in suspend
      ARM: rockchip: enable PMU_GPIOINT_WAKEUP_EN when entering shallow suspend

Hiraku Toyooka (1):
      ARM: socfpga: add smp_ops.cpu_kill to make kexec/kdump available

Jun Nie (1):
      ARM: zx: Add power domains for ZX296702

Keerthy (6):
      ARM: OMAP4: PRM: Remove hardcoding of PRM_IO_PMCTRL_OFFSET register
      ARM: AM43xx: Add the PRM IRQ register offsets
      ARM: dts: AM4372: Add PRCM IRQ entry
      ARM: OMAP: PRM: Remove hardcoding of IRQENABLE_MPU_2 and IRQSTATUS_MPU_2 register offsets
      ARM: OMAP4+: PRM: Add AM437x specific data
      ARM: PRM: AM437x: Enable IO wakeup feature

Krzysztof Kozlowski (1):
      soc: mediatek: Drop owner assignment from platform_driver

Lokesh Vutla (1):
      ARM: OMAP2+: hwmod: add support for lock and unlock hooks

Markus Elfring (1):
      ARM: OMAP2: Delete an unnecessary check

Masahiro Yamada (3):
      MAINTAINERS: add entries for UniPhier device trees and drivers
      clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in Makefile
      ARM: uniphier: drop v7_invalidate_l1 call at secondary entry

Matthias Brugger (2):
      ARM: mediatek: Add regmap to mediatek Kconfig
      soc: mediatek: Fix SCPSYS compilation

Nadav Haklai (1):
      ARM: mvebu: prepare set_cpu_coherent() for future extension

Nathan Lynch (1):
      ARM: zynq: reserve space for jump target in secondary trampoline

Nicolas Ferre (1):
      ARM: at91/soc: add basic support for new sama5d2 SoC

Nishanth Menon (1):
      ARM: DRA7: Provide proper IO map table

Olof Johansson (13):
      Merge tag 'v4.3-rockchip32-soc1' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'sti-soc-for-v4.3-1' of https://git.kernel.org/.../mcoquelin/sti into next/soc
      Merge tag 'renesas-soc-for-v4.3' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'omap-for-v4.3/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'pxa-for-4.3-v2' of https://github.com/rjarzmik/linux into next/soc
      Merge tag 'v4.2-next-soc' of https://github.com/mbgg/linux-mediatek into next/soc
      Merge tag 'socfpga_updates_for_v4.3' of git://git.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'zynq-soc-for-4.3' of https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'mvebu-soc-4.3-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'v4.3-rockchip32-soc2' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'imx-soc-4.3' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'omap-for-v4.3/soc-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'v4.3-rockchip32-soc3' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc

Paul Walmsley (1):
      Merge branch 'prcm-a-for-v4.3' into hwmod-prcm-for-v4.3

Peter Griffin (2):
      ARM: STi: Add code to release secondary cores from holding pen.
      ARM: STi: Remove platform call to trace_hardirqs_off()

Philippe Reynes (3):
      rtc: mxc: use a second rtc clock
      dt-binding: document the binding for mxc rtc
      rtc: mxc: add support of device tree

Rob Herring (1):
      memory: kill off set_irq_flags usage

Robert Jarzmik (1):
      ARM: pxa: transition to dmaengine phase 1

Robin Gong (1):
      input: keyboard: imx: add snvs power key driver

Sascha Hauer (3):
      soc: mediatek: Add infracfg misc driver support
      dt-bindings: soc: Add documentation for the MediaTek SCPSYS unit
      soc: Mediatek: Add SCPSYS power domain driver

Sekhar Nori (2):
      ARM: OMAP2+: sparse: add missing static declaration
      ARM: OMAP2+: sparse: add missing function declarations

Shawn Guo (2):
      input: snvs_pwrkey: use "wakeup-source" as deivce tree property name
      rtc: snvs: select option REGMAP_MMIO

Soren Brinkmann (1):
      MAINTAINERS: Update Zynq git tree location

Stephen Rothwell (1):
      clk: ti: fix for definition movement

Sudeep Holla (1):
      ARM: davinci: cp_intc: use IRQCHIP_SKIP_SET_WAKE instead of irq_set_wake callback

Suman Anna (1):
      ARM: OMAP2+: Remove module references from IOMMU machine layer

Thomas Betker (1):
      ARM: zynq: Set bit 22 in PL310 AuxCtrl register (6395/1)

Thomas Petazzoni (3):
      ARM: mvebu: do not check machine in mvebu_pm_init()
      ARM: mvebu: prepare mvebu_pm_store_bootinfo() to support multiple SoCs
      ARM: mvebu: prepare pm-board.c for the introduction of Armada 38x support

Tony Lindgren (11):
      ARM: OMAP2+: Clean up omap4_local_timer_init
      ARM: OMAP2+: Fix dm814x DT_MACHINE_START
      ARM: OMAP2+: Fix scm compatible for dm814x
      ARM: OMAP2+: Add minimal clockdomains for dm814x
      ARM: OMAP2+: Add custom prwdm_operations for 81xx to support dm814x
      ARM: OMAP2+: Add support for initializing dm814x clocks
      Merge tag 'for-v4.3/omap-hwmod-prcm-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.3/soc
      ARM: OMAP2+: Prepare dm81xx hwmod code for adding minimal dm814x support
      ARM: OMAP2: Add minimal dm814x hwmod support
      Merge branch 'dm814x-soc' into omap-for-v4.3/soc
      ARM: OMAP2+: Fix power domain operations regression caused by 81xx

Ulrich Hecht (2):
      ARM: shmobile: Basic r8a7793 SoC support
      ARM: shmobile: gose: enable R-Car Gen2 regulator quirk

Vaishali Thakkar (2):
      ARM: pxa: Use module_platform_driver
      ARM: pxa: Use setup_timer

Vignesh R (1):
      ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm to SW_WKUP


 Documentation/arm/Atmel/README                  |   5 +
 .../devicetree/bindings/arm/atmel-at91.txt      |   2 +
 .../devicetree/bindings/crypto/fsl-sec4.txt     |  91 ++-
 .../devicetree/bindings/input/snvs-pwrkey.txt   |   1 +
 .../devicetree/bindings/rtc/rtc-mxc.txt         |  26 +
 .../devicetree/bindings/soc/mediatek/scpsys.txt |  41 ++
 MAINTAINERS                                     |   5 +-
 arch/arm/Kconfig.debug                          |  15 +
 arch/arm/boot/dts/am4372.dtsi                   |   1 +
 arch/arm/include/debug/at91.S                   |   5 +-
 arch/arm/include/debug/imx-uart.h               |  13 +
 arch/arm/include/debug/zynq.S                   |   2 +-
 arch/arm/mach-at91/Kconfig                      |  12 +
 arch/arm/mach-at91/sama5.c                      |   3 +
 arch/arm/mach-at91/soc.h                        |   3 +
 arch/arm/mach-bcm/Kconfig                       |   2 +
 arch/arm/mach-davinci/cp_intc.c                 |  12 +-
 arch/arm/mach-imx/Kconfig                       |   8 +
 arch/arm/mach-imx/Makefile                      |   1 +
 arch/arm/mach-imx/cpu.c                         |   3 +
 arch/arm/mach-imx/mach-imx6ul.c                 |  88 +++
 arch/arm/mach-imx/mxc.h                         |   6 +
 arch/arm/mach-mediatek/Kconfig                  |   1 +
 arch/arm/mach-mvebu/coherency.c                 |  29 +-
 arch/arm/mach-mvebu/common.h                    |   4 +-
 arch/arm/mach-mvebu/pm-board.c                  |  30 +-
 arch/arm/mach-mvebu/pm.c                        |  79 ++-
 arch/arm/mach-omap2/Makefile                    |   3 +-
 arch/arm/mach-omap2/board-generic.c             |   6 +-
 arch/arm/mach-omap2/clockdomain.h               |   3 +-
 arch/arm/mach-omap2/clockdomains7xx_data.c      |   2 +-
 arch/arm/mach-omap2/clockdomains81xx_data.c     |  23 +-
 arch/arm/mach-omap2/common.h                    |   1 +
 arch/arm/mach-omap2/control.c                   |   1 +
 arch/arm/mach-omap2/io.c                        |  70 ++-
 arch/arm/mach-omap2/iomap.h                     |  63 ++
 arch/arm/mach-omap2/omap-iommu.c                |  13 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c       |   2 +-
 arch/arm/mach-omap2/omap3-restart.c             |   1 +
 arch/arm/mach-omap2/omap4-restart.c             |   1 +
 arch/arm/mach-omap2/omap54xx.h                  |   8 +
 arch/arm/mach-omap2/omap_hwmod.c                |  16 +-
 arch/arm/mach-omap2/omap_hwmod.h                |   7 +-
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c   |   2 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      | 571 ++++++++++++-------
 arch/arm/mach-omap2/pdata-quirks.c              |   6 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c     | 126 +++-
 arch/arm/mach-omap2/prcm-common.h               |   8 +
 arch/arm/mach-omap2/prcm43xx.h                  |   7 +
 arch/arm/mach-omap2/prm44xx.c                   |  61 +-
 arch/arm/mach-omap2/prm_common.c                |   1 +
 arch/arm/mach-omap2/timer.c                     |  18 +-
 arch/arm/mach-pxa/devices.c                     |  37 ++
 arch/arm/mach-pxa/pxa25x.c                      |   1 +
 arch/arm/mach-pxa/pxa27x.c                      |   1 +
 arch/arm/mach-pxa/pxa3xx.c                      |   1 +
 arch/arm/mach-pxa/sharpsl_pm.c                  |   6 +-
 arch/arm/mach-pxa/tosa-bt.c                     |  15 +-
 arch/arm/mach-rockchip/platsmp.c                |  56 +-
 arch/arm/mach-rockchip/pm.c                     |  78 ++-
 arch/arm/mach-rockchip/pm.h                     |  12 +-
 arch/arm/mach-shmobile/Kconfig                  |   5 +
 arch/arm/mach-shmobile/Makefile                 |   2 +
 .../mach-shmobile/regulator-quirk-rcar-gen2.c   |   3 +-
 arch/arm/mach-shmobile/setup-r8a7793.c          |  33 ++
 arch/arm/mach-socfpga/core.h                    |   1 +
 arch/arm/mach-socfpga/platsmp.c                 |  13 +
 arch/arm/mach-socfpga/socfpga.c                 |  26 +
 arch/arm/mach-sti/headsmp.S                     |   1 +
 arch/arm/mach-sti/platsmp.c                     |  57 +-
 arch/arm/mach-sti/smp.h                         |   2 +
 arch/arm/mach-uniphier/platsmp.c                |   8 +-
 arch/arm/mach-zx/Kconfig                        |   1 +
 arch/arm/mach-zx/Makefile                       |   2 +-
 arch/arm/mach-zx/zx296702-pm-domain.c           | 202 +++++++
 arch/arm/mach-zynq/common.c                     |   4 +-
 arch/arm/mach-zynq/headsmp.S                    |   2 +-
 arch/arm/plat-pxa/dma.c                         |  22 +-
 arch/arm/plat-pxa/include/plat/dma.h            |  15 +
 drivers/clk/ti/Makefile                         |   2 +-
 drivers/clk/ti/clk-814x.c                       |  33 ++
 drivers/clk/ti/clk-816x.c                       |   2 +-
 drivers/clk/zynq/Makefile                       |   2 +-
 drivers/input/keyboard/Kconfig                  |  11 +
 drivers/input/keyboard/Makefile                 |   1 +
 drivers/input/keyboard/snvs_pwrkey.c            | 227 ++++++++
 drivers/memory/omap-gpmc.c                      |   5 +-
 drivers/rtc/Kconfig                             |   1 +
 drivers/rtc/rtc-mxc.c                           |  60 +-
 drivers/rtc/rtc-snvs.c                          | 132 ++---
 drivers/soc/mediatek/Kconfig                    |  19 +
 drivers/soc/mediatek/Makefile                   |   2 +
 drivers/soc/mediatek/mtk-infracfg.c             |  91 +++
 drivers/soc/mediatek/mtk-pmic-wrap.c            |   1 -
 drivers/soc/mediatek/mtk-scpsys.c               | 488 ++++++++++++++++
 include/dt-bindings/power/mt8173-power.h        |  15 +
 include/linux/clk/ti.h                          |   3 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h     |   8 +
 include/linux/soc/mediatek/infracfg.h           |  26 +
 100 files changed, 2728 insertions(+), 517 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
 create mode 100644 arch/arm/mach-imx/mach-imx6ul.c
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 create mode 100644 arch/arm/mach-zx/zx296702-pm-domain.c
 create mode 100644 drivers/clk/ti/clk-814x.c
 create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
 create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
 create mode 100644 include/dt-bindings/power/mt8173-power.h
 create mode 100644 include/linux/soc/mediatek/infracfg.h
