From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 22 Dec 2013 03:23:48 +0900
Subject: [GIT PULL 2nd 4/5] Samsung DT updates for v3.14
Message-ID: <52B5DCB4.5030104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that this tags/samsung-dt-2 is based on previous Samsung DT request 
+ Samsung 2nd fixes because of dependencies.

-----

The following changes since commit e0b51c2eae8ebf10d80530b7a306818252206325:

   ARM: dts: Update Samsung sysreg binding document (2013-12-16 04:47:38 
+0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-2

for you to fetch changes up to a22d060e3299ce672258d00070fa0ed398c035c5:

   ARM: dts: Rename Exynos5250 ChromeOS common file to have exynos 
prefix (2013-12-21 10:09:25 +0900)

----------------------------------------------------------------
Samsung DT 2nd updates for v3.14
- add DMA controller, SPI, and TMU DT nodes for exynos5420
- add PWM DT nodes for exynos5250 and exynos5420
- drop interrupt controller properties from MCT nodes
   because MCT is not an interrupt controller
- move MCT nodes to exynos4x12 from board because it is
   a per-processor interrupt and same 4212 and 4412
- use one cell for MCT interrupt map for exynos4 SoCs
- update Exynos MCT DT bindings accordingly
- fix missing spaces after labels for exynos
- fix mmc status property for exynos5250-snow
- add MCLK for codec for exynos5250-smdk5250
- disable SPI and I2C by default for exynos5250 SoC
   and enable into requiring some boards
- rename cros5250-common to exynos5250-cros-common

----------------------------------------------------------------
Alexander Shiyan (1):
       ARM: SAMSUNG: Fix switching FIFO in arch_enable_uart_fifo function

Doug Anderson (2):
       ARM: dts: Add the missing "\" key in non-US keyboards for 
exynos5250-snow
       ARM: dts: Fix exynos5250-snow's search key to be L_META

Kukjin Kim (1):
       Merge branch 'v3.14-next/fixes-samsung-2' into v3.14-next/dt-exynos-2

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

Sachin Kamat (4):
       ARM: dts: Add missing op_mode property to PMIC on Arndale
       ARM: dts: Add missing frequency property to exynos5250
       ARM: dts: Fix a typo in exynos5420-pinctrl.dtsi
       ARM: dts: Update display clock frequency for Origen-4412

Seungwon Jeon (1):
       ARM: dts: add clock provider for mshc node for Exynos4412 SOC

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

Tushar Behera (1):
       ARM: dts: Update display clock frequency for Origen-4210

Yuvaraj Kumar C D (1):
       ARM: dts: Fix status property of mmc nodes for snow board

  .../bindings/timer/samsung,exynos4210-mct.txt      |  54 +++++---
  arch/arm/boot/dts/exynos4.dtsi                     |   4 +-
  arch/arm/boot/dts/exynos4210-origen.dts            |   2 +-
  arch/arm/boot/dts/exynos4210.dtsi                  |  23 ++--
  arch/arm/boot/dts/exynos4212.dtsi                  |  24 +---
  arch/arm/boot/dts/exynos4412-odroidx.dts           |   5 +-
  arch/arm/boot/dts/exynos4412-origen.dts            |   7 +-
  arch/arm/boot/dts/exynos4412-trats2.dts            |  20 ++-
  arch/arm/boot/dts/exynos4412.dtsi                  |  35 +----
  arch/arm/boot/dts/exynos4x12.dtsi                  |  33 +++++
  arch/arm/boot/dts/exynos5.dtsi                     |   4 +-
  arch/arm/boot/dts/exynos5250-arndale.dts           |  46 ++-----
  ...250-common.dtsi => exynos5250-cros-common.dtsi} |  25 ++--
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  46 +++----
  arch/arm/boot/dts/exynos5250-snow.dts              |  14 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |  24 ++++
  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   2 +-
  arch/arm/boot/dts/exynos5420.dtsi                  | 152 
+++++++++++++++++++++
  arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
  arch/arm/mach-s3c64xx/mach-mini6410.c              |  10 ++
  arch/arm/plat-samsung/include/plat/uncompress.h    |   2 +
  drivers/clk/samsung/clk-exynos4.c                  |   3 +-
  22 files changed, 348 insertions(+), 189 deletions(-)
  rename arch/arm/boot/dts/{cros5250-common.dtsi => 
exynos5250-cros-common.dtsi} (97%)
