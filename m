From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:13 +0900
Subject: [GIT PULL 2nd 0/5] Samsung updates for v3.14
Message-ID: <52B5DC91.90505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin

Here are 2nd round request for v3.14, previous my request is not pulled 
yet though because -rc5 is close. If any problems on my previous 
request, please kindly let me know.

In this round, Most of them are for exynos stuff, mainly cleanup 
<mach/regs-xxx.h>, MCT updates, fixes regarding MSHC, key map for 
exynos5250-snow and add exynos4412-tiny4412 DT board.

Note that, for multiplatform exynos patches will be submitted in Jan 
before upcoming merge window and since it will be small so I hope 
arm-soc takes them directly at that time, of course after some tests.

Thanks and Merry Christmas :-)
- Kukjin

---------------

Alex Ling (1):
       ARM: dts: add board dts file for EXYNOS4412 based TINY4412 board

Doug Anderson (2):
       ARM: dts: Add the missing "\" key in non-US keyboards for 
exynos5250-snow
       ARM: dts: Fix exynos5250-snow's search key to be L_META

Kukjin Kim (11):
       ARM: EXYNOS: cleanup <mach/regs-pmu.h>
       ARM: EXYNOS: remove inclusion <mach/regs-pmu.h> into another headers
       ARM: EXYNOS: local regs-pmu.h header file
       ARM: EXYNOS: cleanup <mach/regs-irq.h>
       ARM: EXYNOS: cleanup <mach/regs-clock.h>
       PM / devfreq: move definitions for exynos4_bus into drivers/devfreq
       ARM: EXYNOS: local definitions for pm.c into mach-exynos dir
       cpufreq: exynos: move definitions for exynos-cpufreq into 
drivers/cpufreq/
       ARM: EXYNOS: local definitions for cpuidle.c into mach-exynos dir
       ARM: EXYNOS: remove <mach/regs-clock.h> for exynos
       PM / devfreq: use inclusion <mach/map.h> instead of <plat/map-s5p.h>

Leela Krishna Amudala (2):
       ARM: dts: Add SPI nodes to the exynos5420 device tree file
       ARM: dts: add pwm DT nodes to Exynos5250 and Exynos5420

Mark Brown (4):
       ARM: dts: Add CODEC MCLK for SMDK5250
       ARM: dts: Leave Exynos5250 SPI controller disabled by default
       ARM: dts: Disable I2C controllers by default on Exynos5250
       ARM: dts: Rename Exynos5250 ChromeOS common file to have exynos 
prefix

Naveen Krishna Chatradhi (1):
       ARM: dts: Add device nodes for TMU blocks for exynos5420

Padmavathi Venna (1):
       ARM: dts: Add DMA controller node info on Exynos5420

Sachin Kamat (1):
       ARM: exynos_defconfig: Enable S2MPS11 voltage regulator

Seungwon Jeon (1):
       ARM: dts: add clock provider for mshc node for Exynos4412 SOC

Sylwester Nawrocki (2):
       ARM: EXYNOS: Consolidate selection of PM_GENERIC_DOMAINS for Exynos4
       ARM: EXYNOS: Kill exynos_pm_late_initcall()

Tomasz Figa (9):
       ARM: S3C64XX: Correct card detect type for HSMMC1 for MINI6410
       clk: samsung: exynos4: Fix definition of div_mmc_pre4 divider
       ARM: dts: Fix definition of MSHC device tree nodes for exynos4x12
       ARM: dts: Use MSHC controller for eMMC memory for exynos4412-trats2
       Documentation: devicetree: Update Exynos MCT bindings description
       ARM: dts: Drop interrupt controller properties from MCT nodes for 
exynos4 SoCs
       ARM: dts: Move MCT node to exynos4x12.dtsi
       ARM: dts: Simplify MCT interrupt map for exynos4 SoCs
       ARM: dts: Fix missing spaces after labels for exynos

Yuvaraj Kumar C D (1):
       ARM: dts: Fix status property of mmc nodes for snow board

  .../bindings/timer/samsung,exynos4210-mct.txt      |  54 ++-
  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/exynos4.dtsi                     |   4 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |  23 +-
  arch/arm/boot/dts/exynos4212.dtsi                  |  24 +-
  arch/arm/boot/dts/exynos4412-odroidx.dts           |   5 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |   5 +-
  arch/arm/boot/dts/exynos4412-tiny4412.dts          |  93 ++++++
  arch/arm/boot/dts/exynos4412-trats2.dts            |  20 +-
  arch/arm/boot/dts/exynos4412.dtsi                  |  35 +-
  arch/arm/boot/dts/exynos4x12.dtsi                  |  33 ++
  arch/arm/boot/dts/exynos5.dtsi                     |   4 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |  44 +--
  ...250-common.dtsi => exynos5250-cros-common.dtsi} |  25 +-
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  46 ++-
  arch/arm/boot/dts/exynos5250-snow.dts              |  14 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |  22 ++
  arch/arm/boot/dts/exynos5420.dtsi                  | 152 +++++++++
  arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
  arch/arm/configs/exynos_defconfig                  |   1 +
  arch/arm/mach-exynos/Kconfig                       |   4 +-
  arch/arm/mach-exynos/common.c                      |   8 +-
  arch/arm/mach-exynos/common.h                      |   6 -
  arch/arm/mach-exynos/cpuidle.c                     |  25 +-
  arch/arm/mach-exynos/hotplug.c                     |   2 +-
  arch/arm/mach-exynos/include/mach/pm-core.h        |   5 +-
  arch/arm/mach-exynos/include/mach/regs-clock.h     | 372 
---------------------
  arch/arm/mach-exynos/include/mach/regs-irq.h       |  19 --
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   2 +-
  arch/arm/mach-exynos/platsmp.c                     |   3 +-
  arch/arm/mach-exynos/pm.c                          |  29 +-
  arch/arm/mach-exynos/pm_domains.c                  |   9 +-
  arch/arm/mach-exynos/pmu.c                         |   3 +-
  arch/arm/mach-exynos/{include/mach => }/regs-pmu.h |  53 ---
  arch/arm/mach-s3c64xx/mach-mini6410.c              |  10 +
  arch/arm/plat-samsung/pm.c                         |   2 +
  arch/arm/plat-samsung/s5p-irq-pm.c                 |   3 +
  drivers/clk/samsung/clk-exynos4.c                  |   3 +-
  drivers/cpufreq/exynos-cpufreq.h                   |  22 ++
  drivers/cpufreq/exynos4210-cpufreq.c               |   2 -
  drivers/cpufreq/exynos4x12-cpufreq.c               |   2 -
  drivers/cpufreq/exynos5250-cpufreq.c               |   1 -
  drivers/devfreq/exynos/exynos4_bus.c               |   4 +-
  drivers/devfreq/exynos/exynos4_bus.h               | 110 ++++++
  44 files changed, 638 insertions(+), 668 deletions(-)
