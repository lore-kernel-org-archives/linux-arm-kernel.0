From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 00:05:21 +0900
Subject: [GIT PULL 5/7] Samsung DT for v3.8
Message-ID: <50AB9C31.2020803@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

Here is Samsung DT for v3.8 and this is including DT for EXYNOS4X12 SoC, 
SMDK4412 board, pinctrl for exynos4x12, TMU, MFC, SATA and SATA PHY.

As I commented on [4/7], this branch merged pinctrl/samsung to support 
pinctrl for exynos4x12 without useless merge conflicts.

Please pull Samsung DT from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/dt-samsung

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit bab797f8e36a4dd0476eda5197182aeea44e23db:

   Merge remote-tracking branch 'pinctrl/samsung' into 
next/pinctrl-samsung (2012-11-19 10:00:41 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/dt-samsung

Amit Daniel Kachhap (2):
       ARM: EXYNOS: Add devicetree node for TMU driver for exynos4
       ARM: EXYNOS: Add devicetree node for TMU driver for exynos5

Arun Kumar K (1):
       ARM: EXYNOS: Add MFC device tree support

Kukjin Kim (2):
       Merge branch 'next/pinctrl-samsung' into next/dt-exynos4x12
       Merge branch 'next/dt-exynos4x12' into next/dt-samsung

Thomas Abraham (1):
       ARM: dts: add board dts file for EXYNOS4412 based SMDK board

Tomasz Figa (12):
       ARM: dts: Enable serial controllers on Origen and SMDKV310
       ARM: dts: Add support for EXYNOS4X12 SoCs
       ARM: EXYNOS: Skip wakeup-int setup if pinctrl driver is used on 
EXYNOS4X12
       gpio: samsung: Skip registration if pinctrl driver is present on 
EXYNOS4X12
       pinctrl: samsung: Add support for EXYNOS4X12
       ARM: dts: Add nodes for pin controllers for exynos4x12
       ARM: dts: Update for pinctrl-samsung driver for exynos4210-trats
       ARM: dts: Add nodes for GPIO keys available on Trats
       ARM: dts: Add node for i2c3 bus for exynos4210-trats
       ARM: dts: Add node for touchscreen voltage regulator for 
exynos4210-trats
       ARM: dts: Add node for touchscreen for exynos4210-trats
       ARM: dts: Remove broken-voltage property from sdhci node for 
exynos4210-trats

Vasanth Ananthan (1):
       ARM: EXYNOS: DT Support for SATA and SATA PHY

  .../devicetree/bindings/ata/exynos-sata-phy.txt    |   14 +
  .../devicetree/bindings/ata/exynos-sata.txt        |   17 +
  .../devicetree/bindings/media/s5p-mfc.txt          |   23 +
  .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
  arch/arm/boot/dts/Makefile                         |    1 +
  arch/arm/boot/dts/exynos4210-origen.dts            |   16 +
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   16 +
  arch/arm/boot/dts/exynos4210-trats.dts             |   87 ++-
  arch/arm/boot/dts/exynos4210.dtsi                  |    7 +
  arch/arm/boot/dts/exynos4212.dtsi                  |   28 +
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   45 +
  arch/arm/boot/dts/exynos4412.dtsi                  |   28 +
  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |  965 
++++++++++++++++++++
  arch/arm/boot/dts/exynos4x12.dtsi                  |   69 ++
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   20 +
  arch/arm/boot/dts/exynos5250.dtsi                  |   30 +
  arch/arm/mach-exynos/Kconfig                       |    1 +
  arch/arm/mach-exynos/clock-exynos4.c               |    4 +
  arch/arm/mach-exynos/clock-exynos5.c               |    7 +-
  arch/arm/mach-exynos/common.c                      |    7 +-
  arch/arm/mach-exynos/include/mach/irqs.h           |    3 +
  arch/arm/mach-exynos/include/mach/map.h            |    2 +
  arch/arm/mach-exynos/mach-exynos4-dt.c             |    4 +
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   24 +
  arch/arm/plat-samsung/devs.c                       |    1 +
  arch/arm/plat-samsung/include/plat/mfc.h           |   11 +
  arch/arm/plat-samsung/s5p-dev-mfc.c                |   34 +
  drivers/gpio/gpio-samsung.c                        |   43 +-
  drivers/pinctrl/pinctrl-exynos.c                   |  110 +++
  drivers/pinctrl/pinctrl-samsung.c                  |    2 +
  drivers/pinctrl/pinctrl-samsung.h                  |    1 +
  31 files changed, 1580 insertions(+), 41 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/ata/exynos-sata-phy.txt
  create mode 100644 Documentation/devicetree/bindings/ata/exynos-sata.txt
  create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.txt
  create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
  create mode 100644 arch/arm/boot/dts/exynos4412-smdk4412.dts
  create mode 100644 arch/arm/boot/dts/exynos4412.dtsi
  create mode 100644 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
