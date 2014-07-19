From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Jul 2014 12:11:52 -0700
Subject: [GIT PULL] ARM: imx: SoC changes for 3.17
In-Reply-To: <20140718092140.GB5485@dragon>
References: <20140718092140.GB5485@dragon>
Message-ID: <20140719191152.GD4265@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 05:21:41PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> To avoid merge conflict, this pull request is based on imx-fixes-3.16-2
> I just sent you.  Please pull, thanks.
> 
> Shawn
> 
> The following changes since commit 03e97220b99b8b691ea5b130b7b4c135c9662792:
> 
>   ARM: clk-imx6q: parent lvds_sel input from upstream clock gates (2014-07-18 15:57:17 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.17
> 
> for you to fetch changes up to 4349c4298f676815bf7ad146cf37e76843054783:
> 
>   ARM: imx: clk-vf610: fix FlexCAN clock gating (2014-07-18 16:11:40 +0800)
> 
> ----------------------------------------------------------------
> The i.MX SoC changes for 3.17:
>  - Add devicetree support for i.MX1 and i.MX21 clock driver
>  - Use CLOCKSOURCE_OF_DECLARE() to initialize timer for DT targets
>  - Use of_clk_init() to initialize i.MX25 and i.MX27 clock driver in
>    device tree boot
>  - Remove i.MX1 camera support
>  - Remove i.MX27 IP Camera and Lite-Kit board support
>  - Add suspend and cpuidle support for i.mx6sx
>  - Clean up unused clk_register_clkdev() lookups
>  - Update imx-weim bus driver to support populating devices on a simple
>    bus
>  - Switch i.MX27 and i.MX6QDL clock driver to use macro for clock IDs
>  - Make i.MX51 a DT only platform and clean up the non-DT support code
>  - Support disabling supervisor protect via DT
>  - Random defconfig updates
> 
> ----------------------------------------------------------------
> Alexander Shiyan (22):
>       ARM: i.MX: Select HAVE_IMX_SRC for i.MX5 globally
>       ARM: i.MX1 clk: Add devicetree support
>       ARM: i.MX: Remove registration helper for i.MX1 USB UDC
>       ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.
>       ARM: i.MX: Remove excess variable
>       ARM: i.MX27 clk: Separate DT and non-DT init procedure
>       ARM: i.MX27 clk: Use of_clk_init() for DT case
>       ARM: i.MX clk: Move clock check function in common location
>       ARM: i.MX system: Simplify handling watchdog clock
>       ARM: i.MX system: Add a reset fallback if base address of watchdog is not set
>       ARM: i.MX: Remove Freescale i.MX27 IP Camera board support
>       ARM: i.MX21 clk: Clock initialization rework
>       ARM: i.MX21 clk: Remove clk_register_clkdev() for unused clocks
>       ARM: i.MX21 clk: Cleanup driver
>       ARM: i.MX21 clk: Add devicetree support
>       ARM: i.MX: Remove i.MX1 camera support
>       ARM: i.MX: Remove excess symbols ARCH_MX1, ARCH_MX25 and MACH_MX27
>       ARM: i.MX: Remove Freescale Logic Product Development i.MX27 Lite-Kit board support
>       ARM: i.MX27 clk: Introduce DT include for clock provider
>       ARM: i.MX27 clk: Remove unused definitions
>       ARM: i.MX27 clk: Add 26 MHz oscillator circuit clock gate
>       ARM: i.MX: Use CLOCKSOURCE_OF_DECLARE() for DT targets
> 
> Anson Huang (4):
>       ARM: imx: add suspend support for i.mx6sx
>       ARM: imx: add cpuidle support for i.mx6sx
>       ARM: imx: mem bit must be cleared before entering DSM mode
>       ARM: imx: add standby mode support for suspend
> 
> Arnd Bergmann (2):
>       ARM: imx: imx6sx uses imx6q cpuidle code
>       ARM: imx: build cpu_is_imx6sl function conditionally
> 
> Denis Carikli (2):
>       ARM i.MX25 clk: Fix gpt timer clock.
>       ARM: i.MX25 clk: Use of_clk_init() for DT case
> 
> Fabian Frederick (1):
>       ARM: imx: use PTR_ERR_OR_ZERO
> 
> Fabio Estevam (6):
>       ARM: imx: defconfig: Select CONFIG_FHANDLE
>       ARM: imx_v6_v7_defconfig: Select CONFIG_SOC_IMX6SX
>       ARM: clk-imx51-imx53: Remove clk_register_clkdev()
>       ARM: imx_v4_v5_defconfig: Add USB device options
>       ARM: mx6: Only check for 1.2GHz for mx6quad
>       ARM: imx: clk-imx6sx: register SSI/SSI_IPG as shared gate clocks
> 
> Liu Ying (1):
>       bus: imx-weim: populate devices on a simple bus
> 
> Paul Bolle (1):
>       ARM: imx: remove unused defines
> 
> Shawn Guo (24):
>       Merge tag 'imx-fixes-3.16-2' into imx/soc
>       ARM: imx: move EHCI platform defines out of platform_data header
>       ARM: imx5: move SOC_IMX5 and SOC_IMX51 into 'Device tree only'
>       ARM: imx5: drop option MACH_IMX51_DT
>       ARM: imx5: remove imx51 non-DT support files
>       ARM: imx5: remove i.MX5 non-DT device registration helpers
>       ARM: imx5: make mx51_clocks_init() a DT call
>       ARM: imx5: drop arguments from mx5_clocks_common_init()
>       ARM: imx5: tzic_init_irq() can directly be .init_irq hook
>       ARM: imx5: remove function imx51_soc_init()
>       ARM: imx5: call mxc_timer_init_dt() on imx51
>       ARM: imx5: retrieve iim base from device tree
>       ARM: imx5: remove header crm-regs-imx5.h
>       ARM: imx5: use dynamic mapping for CCM block
>       ARM: imx5: use dynamic mapping for DPLL block
>       ARM: imx5: reuse clock CCM mapping in pm code
>       ARM: imx5: use dynamic mapping for Cortex and GPC block
>       ARM: imx5: move init hooks into mach-imx5x.c
>       ARM: imx5: remove file mm-imx5.c
>       ARM: imx5: clean function declarations in mx51.h
>       ARM: imx5: remove mx51.h and mx53.h
>       ARM: imx6qdl: switch to use macro for clock ID
>       ARM: imx: mark .dt_compat as const
>       ARM: imx: drop PL310 errata 588369 and 727915
> 
> Silvio Fricke (2):
>       ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
>       ARM: imx_v6_v7_defconfig: Enable flexcan driver for can support
> 
> Stefan Agner (2):
>       ARM: imx_v6_v7_defconfig: add FSL_EDMA and PRINTK_TIME
>       ARM: imx: clk-vf610: fix FlexCAN clock gating
> 
> Steffen Trumtrar (2):
>       ARM: i.MX: allow disabling supervisor protect via DT
>       ARM: i.MX53: globally disable supervisor protect
> 
>  .../devicetree/bindings/clock/imx1-clock.txt       |  26 +
>  .../devicetree/bindings/clock/imx21-clock.txt      |  28 +
>  .../devicetree/bindings/clock/imx27-clock.txt      | 127 +---
>  .../devicetree/bindings/clock/imx6q-clock.txt      | 220 +-----
>  arch/arm/configs/imx_v4_v5_defconfig               |   5 +-
>  arch/arm/configs/imx_v6_v7_defconfig               |   9 +-
>  arch/arm/configs/multi_v7_defconfig                |   2 +-
>  arch/arm/configs/mxs_defconfig                     |   1 +
>  arch/arm/mach-imx/Kconfig                          |  59 +-
>  arch/arm/mach-imx/Makefile                         |  11 +-
>  arch/arm/mach-imx/clk-imx1.c                       | 151 ++--
>  arch/arm/mach-imx/clk-imx21.c                      | 299 ++++----
>  arch/arm/mach-imx/clk-imx25.c                      |  47 +-
>  arch/arm/mach-imx/clk-imx27.c                      | 452 +++++------
>  arch/arm/mach-imx/clk-imx31.c                      |   6 +-
>  arch/arm/mach-imx/clk-imx35.c                      |   6 +-
>  arch/arm/mach-imx/clk-imx51-imx53.c                | 256 +++----
>  arch/arm/mach-imx/clk-imx6q.c                      | 540 +++++++-------
>  arch/arm/mach-imx/clk-imx6sl.c                     |  11 +-
>  arch/arm/mach-imx/clk-imx6sx.c                     |  25 +-
>  arch/arm/mach-imx/clk-vf610.c                      |   8 +-
>  arch/arm/mach-imx/clk.c                            |  10 +
>  arch/arm/mach-imx/clk.h                            |   9 +
>  arch/arm/mach-imx/common.h                         |  32 +-
>  arch/arm/mach-imx/cpu-imx5.c                       |  25 +-
>  arch/arm/mach-imx/cpu.c                            |  13 +
>  arch/arm/mach-imx/cpuidle-imx6q.c                  |   6 +-
>  arch/arm/mach-imx/crm-regs-imx5.h                  | 600 ---------------
>  arch/arm/mach-imx/devices-imx51.h                  |  66 --
>  arch/arm/mach-imx/devices/Kconfig                  |   9 +-
>  arch/arm/mach-imx/devices/Makefile                 |   2 -
>  arch/arm/mach-imx/devices/devices-common.h         |  26 -
>  arch/arm/mach-imx/devices/platform-fec.c           |  12 -
>  arch/arm/mach-imx/devices/platform-fsl-usb2-udc.c  |   5 -
>  arch/arm/mach-imx/devices/platform-imx-i2c.c       |  26 -
>  arch/arm/mach-imx/devices/platform-imx-keypad.c    |  10 -
>  arch/arm/mach-imx/devices/platform-imx-ssi.c       |  20 -
>  arch/arm/mach-imx/devices/platform-imx-uart.c      |  22 -
>  arch/arm/mach-imx/devices/platform-imx2-wdt.c      |  18 -
>  arch/arm/mach-imx/devices/platform-imx_udc.c       |  75 --
>  arch/arm/mach-imx/devices/platform-mx1-camera.c    |  42 --
>  arch/arm/mach-imx/devices/platform-mxc-ehci.c      |   9 -
>  arch/arm/mach-imx/devices/platform-mxc_nand.c      |   5 -
>  arch/arm/mach-imx/devices/platform-mxc_rnga.c      |   5 +-
>  arch/arm/mach-imx/devices/platform-pata_imx.c      |  10 -
>  .../mach-imx/devices/platform-sdhci-esdhc-imx.c    |  24 -
>  arch/arm/mach-imx/devices/platform-spi_imx.c       |  27 -
>  arch/arm/mach-imx/ehci-imx25.c                     |   1 +
>  arch/arm/mach-imx/ehci-imx27.c                     |   1 +
>  arch/arm/mach-imx/ehci-imx31.c                     |   1 +
>  arch/arm/mach-imx/ehci-imx35.c                     |   1 +
>  arch/arm/mach-imx/ehci-imx5.c                      | 171 -----
>  arch/arm/mach-imx/ehci.h                           |  43 ++
>  arch/arm/mach-imx/gpc.c                            |   5 +-
>  arch/arm/mach-imx/hardware.h                       |   2 -
>  arch/arm/mach-imx/imx25-dt.c                       |   6 -
>  arch/arm/mach-imx/imx27-dt.c                       |   6 -
>  arch/arm/mach-imx/imx31-dt.c                       |   2 +-
>  arch/arm/mach-imx/imx35-dt.c                       |   2 +-
>  arch/arm/mach-imx/iomux-mx51.h                     | 827 ---------------------
>  arch/arm/mach-imx/mach-armadillo5x0.c              |   1 +
>  arch/arm/mach-imx/mach-cpuimx27.c                  |   1 +
>  arch/arm/mach-imx/mach-cpuimx35.c                  |   1 +
>  arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |   1 +
>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   1 +
>  arch/arm/mach-imx/mach-imx27ipcam.c                |  77 --
>  arch/arm/mach-imx/mach-imx27lite.c                 |  83 ---
>  arch/arm/mach-imx/mach-imx50.c                     |   5 +-
>  arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c}     |  45 +-
>  arch/arm/mach-imx/mach-imx53.c                     |  19 +-
>  arch/arm/mach-imx/mach-imx6q.c                     |   4 +-
>  arch/arm/mach-imx/mach-imx6sl.c                    |   2 +-
>  arch/arm/mach-imx/mach-imx6sx.c                    |  10 +-
>  arch/arm/mach-imx/mach-mx25_3ds.c                  |   1 +
>  arch/arm/mach-imx/mach-mx27_3ds.c                  |   1 +
>  arch/arm/mach-imx/mach-mx31_3ds.c                  |   1 +
>  arch/arm/mach-imx/mach-mx31lilly.c                 |   1 +
>  arch/arm/mach-imx/mach-mx31lite.c                  |   1 +
>  arch/arm/mach-imx/mach-mx31moboard.c               |   5 +-
>  arch/arm/mach-imx/mach-mx35_3ds.c                  |   1 +
>  arch/arm/mach-imx/mach-pca100.c                    |   1 +
>  arch/arm/mach-imx/mach-pcm037.c                    |   1 +
>  arch/arm/mach-imx/mach-pcm038.c                    |   1 +
>  arch/arm/mach-imx/mach-pcm043.c                    |   1 +
>  arch/arm/mach-imx/mach-vf610.c                     |   2 +-
>  arch/arm/mach-imx/mach-vpr200.c                    |   1 +
>  arch/arm/mach-imx/mm-imx5.c                        | 155 ----
>  arch/arm/mach-imx/mx1-camera-fiq-ksym.c            |  18 -
>  arch/arm/mach-imx/mx1-camera-fiq.S                 |  35 -
>  arch/arm/mach-imx/mx31moboard-devboard.c           |   5 +-
>  arch/arm/mach-imx/mx31moboard-marxbot.c            |   5 +-
>  arch/arm/mach-imx/mx31moboard-smartbot.c           |   5 +-
>  arch/arm/mach-imx/mx51.h                           | 346 ---------
>  arch/arm/mach-imx/mx53.h                           | 342 ---------
>  arch/arm/mach-imx/mxc.h                            |   7 +
>  arch/arm/mach-imx/pm-imx5.c                        |  98 ++-
>  arch/arm/mach-imx/pm-imx6.c                        |  67 +-
>  arch/arm/mach-imx/system.c                         |  24 +-
>  arch/arm/mach-imx/time.c                           |  55 +-
>  arch/arm/mach-imx/tzic.c                           |   9 +-
>  drivers/bus/imx-weim.c                             |   4 +-
>  include/dt-bindings/clock/imx1-clock.h             |  40 +
>  include/dt-bindings/clock/imx21-clock.h            |  80 ++
>  include/dt-bindings/clock/imx27-clock.h            | 108 +++
>  include/dt-bindings/clock/imx6qdl-clock.h          | 224 ++++++
>  include/dt-bindings/clock/vf610-clock.h            |   4 +-
>  include/linux/platform_data/camera-mx1.h           |  35 -
>  include/linux/platform_data/usb-ehci-mxc.h         |  46 --
>  include/linux/platform_data/usb-imx_udc.h          |  23 -
>  109 files changed, 1805 insertions(+), 4663 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.txt
>  delete mode 100644 arch/arm/mach-imx/crm-regs-imx5.h
>  delete mode 100644 arch/arm/mach-imx/devices-imx51.h
>  delete mode 100644 arch/arm/mach-imx/devices/platform-imx_udc.c
>  delete mode 100644 arch/arm/mach-imx/devices/platform-mx1-camera.c
>  delete mode 100644 arch/arm/mach-imx/ehci-imx5.c
>  create mode 100644 arch/arm/mach-imx/ehci.h
>  delete mode 100644 arch/arm/mach-imx/iomux-mx51.h
>  delete mode 100644 arch/arm/mach-imx/mach-imx27ipcam.c
>  delete mode 100644 arch/arm/mach-imx/mach-imx27lite.c
>  rename arch/arm/mach-imx/{imx51-dt.c => mach-imx51.c} (51%)
>  delete mode 100644 arch/arm/mach-imx/mm-imx5.c
>  delete mode 100644 arch/arm/mach-imx/mx1-camera-fiq-ksym.c
>  delete mode 100644 arch/arm/mach-imx/mx1-camera-fiq.S
>  delete mode 100644 arch/arm/mach-imx/mx51.h
>  delete mode 100644 arch/arm/mach-imx/mx53.h
>  create mode 100644 include/dt-bindings/clock/imx1-clock.h
>  create mode 100644 include/dt-bindings/clock/imx21-clock.h
>  create mode 100644 include/dt-bindings/clock/imx27-clock.h
>  create mode 100644 include/dt-bindings/clock/imx6qdl-clock.h
>  delete mode 100644 include/linux/platform_data/camera-mx1.h
>  delete mode 100644 include/linux/platform_data/usb-imx_udc.h

Nice diffstat. I would have liked to see the cleanups split off in a separate
preceding branch (and the soc updates build on top if needed), so please keep
that in mind in the future.

The slightly bigger hassle is the defconfig update, since you touched
multi_v7_defconfig: we tend to want to merge or apply that separately since
they tend to cause a lot of conflicts between our branches.

Still, I'll give you a pass this time, it's a small change so we can manage it.
Please separate more in the future though.

Merged.

Thanks,


-Olof
