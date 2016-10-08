From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:32:35 +0200
Subject: [GIT PULL 5/8] ARM: SoC driver updates for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <1718020.slVJzg4Atj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-drivers

for you to fetch changes up to d6db68b2deaa0158d25b236edffcf6dd2117208f:

  bus: qcom-ebi2: depend on HAS_IOMEM (2016-10-02 22:23:57 -0700)

----------------------------------------------------------------
ARM: SoC driver updates for v4.9

Driver updates for ARM SoCs, including a couple of newly added drivers:

- The Qualcomm external bus interface 2 (EBI2), used in some of their
  mobile phone chips for connecting flash memory, LCD displays or
  other peripherals

- Secure monitor firmware for Amlogic SoCs, and an NVMEM driver for the
  EFUSE based on that firmware interface.

- Perf support for the AppliedMicro X-Gene performance monitor unit

- Reset driver for STMicroelectronics STM32

- Reset driver for SocioNext UniPhier SoCs

Aside from these, there are minor updates to SoC-specific bus,
clocksource, firmware, pinctrl, reset, rtc and pmic drivers.

----------------------------------------------------------------
Arnd Bergmann (14):
      Merge tag 'gpmc-omap-for-v4.9' of https://github.com/rogerq/linux into next/drivers
      Merge tag 'reset-for-4.9' of git://git.pengutronix.de/git/pza/linux into next/drivers
      Merge commit 'http://github.com/rogerq/linux gpmc-omap-v4.8-rc1' into next/drivers
      Merge tag 'amlogic-drivers' of git://git.kernel.org/.../khilman/linux-amlogic into next/drivers
      Merge tag 'v4.9-rockchip-drivers1' of git://git.kernel.org/.../mmind/linux-rockchip into next/drivers
      Merge tag 'at91-ab-4.9-drivers' of git://git.kernel.org/.../abelloni/linux into next/drivers
      Merge tag 'qcom-drivers-for-4.9' of git://git.kernel.org/.../agross/linux into next/drivers
      Merge tag 'tegra-for-4.9-bus' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'tegra-for-4.9-soc' of git://git.kernel.org/.../tegra/linux into next/drivers
      Merge tag 'v4.8-next-soc' of https://github.com/mbgg/linux-mediatek into next/drivers
      Merge tag 'samsung-drivers-4.9-2' of git://git.kernel.org/.../krzk/linux into next/drivers
      Merge tag 'xgene-drivers-for-4.9' of https://github.com/AppliedMicro/xgene-next into next/drivers
      Merge tag 'mvebu-drivers-4.9-1' of git://git.infradead.org/linux-mvebu into next/drivers
      Merge tag 'qcom-ebi2-arm-soc' of git://git.kernel.org/.../linusw/linux-integrator into next/drivers

Baoyou Xie (1):
      memory: omap-gpmc: make gpmc_clk_ticks_to_ns() static

Bjorn Andersson (5):
      soc: qcom: smd: Correct compile stub prototypes
      soc: qcom: smd: Simplify multi channel handling
      soc: qcom: smd: Request irqs after parsing properties
      soc: qcom: smd: Represent smd edges as devices
      soc: qcom: smd: Reset rx tail rather than tx

Carlo Caione (2):
      firmware: Amlogic: Add secure monitor driver
      nvmem: amlogic: Add Amlogic Meson EFUSE driver

Chanwoo Choi (2):
      clocksource: exynos_mct: Add the support for ARM64
      dt-bindings: EXYNOS: Add Exynos5433 PMU compatible

Elaine Zhang (1):
      soc: rockchip: support active_wakeup for rockchip power-domains

Gabriel Fernandez (1):
      ARM: dts: stm32f429: add missing #reset-cells of rcc

Henry Chen (1):
      soc: mediatek: PMIC wrap: Extend the waiting time to 10ms.

Jamie Lentin (2):
      clk: mvebu: Add clk support for the orion5x SoC mv88f5181
      pinctrl: mvebu: orion5x: Generalise mv88f5181l support for 88f5181

Jon Hunter (1):
      bus: tegra-aconnect: Use of_pm_clk_add_clk()

LABBE Corentin (1):
      memory: atmel-sdramc: fix a possible NULL dereference

Linus Walleij (4):
      memory: omap-gpmc: use devm_gpiochip_add_data()
      bus: qcom: add EBI2 device tree bindings
      bus: qcom: add EBI2 driver
      bus: qcom-ebi2: depend on HAS_IOMEM

Markus Elfring (1):
      memory: omap-gpmc: Delete an unnecessary check before the function call "gpiochip_free_own_desc"

Masahiro Yamada (1):
      reset: uniphier: add reset controller driver for UniPhier SoCs

Maxime Coquelin (3):
      dt-bindings: mfd: Add STM32F4 RCC numeric constants into DT include file
      dt-bindings: Document the STM32 reset bindings
      drivers: reset: Add STM32 reset driver

Neil Armstrong (2):
      media: rc: meson-ir: Add support for newer versions of the IR decoder
      rtc: rtc-pm8xxx: Add support for pm8018 rtc

Paul Gortmaker (1):
      firmware: qcom_scm: make it explicitly non-modular

Philipp Zabel (13):
      reset: socfpga: no need to store modrst_offset
      reset: warn on invalid input to reset_control_reset/assert/deassert/status
      reset: ath79: add missing include
      reset: ath79: add driver Kconfig option
      reset: berlin: add driver Kconfig option
      reset: lpc18xx: add driver Kconfig option
      reset: meson: add driver Kconfig option
      reset: pistachio: add driver Kconfig option
      reset: socfpga: add driver Kconfig option
      reset: stm32: add driver Kconfig option
      reset: sunxi: add driver Kconfig option
      reset: zynq: add driver Kconfig option
      reset: hi6220: allow to compile test driver on other architectures

Roger Quadros (1):
      memory: omap-gpmc: Fix build with CONFIG_OMAP_GPMC disabled

Stephen Boyd (1):
      soc: qcom: smem: Silence probe defer error

Tai Nguyen (3):
      MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
      Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
      perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver

Thierry Reding (1):
      bus: tegra-aconnect: Make symbol tristate

Vince Hsu (1):
      soc/tegra: pmc: Fix incorrect DPD request

Wei Yongjun (1):
      memory: atmel-ebi: use PTR_ERR_OR_ZERO() to simplify the code

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 .../devicetree/bindings/bus/qcom,ebi2.txt          |  138 ++
 .../devicetree/bindings/clock/mvebu-core-clock.txt |    1 +
 .../devicetree/bindings/clock/st,stm32-rcc.txt     |   42 +-
 .../devicetree/bindings/mfd/qcom-pm8xxx.txt        |    1 +
 .../devicetree/bindings/perf/apm-xgene-pmu.txt     |  112 ++
 .../bindings/pinctrl/marvell,orion-pinctrl.txt     |    4 +-
 .../devicetree/bindings/reset/st,stm32-rcc.txt     |    6 +
 .../devicetree/bindings/reset/uniphier-reset.txt   |   93 ++
 Documentation/perf/xgene-pmu.txt                   |   48 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/stm32f429.dtsi                   |    1 +
 drivers/bus/Kconfig                                |   14 +-
 drivers/bus/Makefile                               |    1 +
 drivers/bus/qcom-ebi2.c                            |  408 ++++++
 drivers/bus/tegra-aconnect.c                       |   22 +-
 drivers/clk/mvebu/orion.c                          |   70 +
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/clocksource/exynos_mct.c                   |    4 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/meson/Kconfig                     |    9 +
 drivers/firmware/meson/Makefile                    |    1 +
 drivers/firmware/meson/meson_sm.c                  |  248 ++++
 drivers/firmware/qcom_scm.c                        |   19 +-
 drivers/media/rc/meson-ir.c                        |   29 +-
 drivers/memory/atmel-ebi.c                         |   10 +-
 drivers/memory/atmel-sdramc.c                      |    4 +-
 drivers/memory/omap-gpmc.c                         |   41 +-
 drivers/nvmem/Kconfig                              |   10 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/meson-efuse.c                        |   93 ++
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/xgene_pmu.c                           | 1398 ++++++++++++++++++++
 drivers/pinctrl/mvebu/pinctrl-orion.c              |   23 +-
 drivers/reset/Kconfig                              |   65 +
 drivers/reset/Makefile                             |   20 +-
 drivers/reset/core.c                               |   12 +-
 drivers/reset/hisilicon/Kconfig                    |    3 +-
 drivers/reset/reset-ath79.c                        |    1 +
 drivers/reset/reset-socfpga.c                      |   19 +-
 drivers/reset/reset-stm32.c                        |  108 ++
 drivers/reset/reset-uniphier.c                     |  440 ++++++
 drivers/rtc/rtc-pm8xxx.c                           |    1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c               |    2 +-
 drivers/soc/qcom/smd.c                             |  265 ++--
 drivers/soc/qcom/smem.c                            |    3 +-
 drivers/soc/rockchip/pm_domains.c                  |  100 +-
 drivers/soc/tegra/pmc.c                            |   28 +-
 include/dt-bindings/mfd/stm32f4-rcc.h              |   98 ++
 include/linux/firmware/meson/meson_sm.h            |   31 +
 include/linux/omap-gpmc.h                          |    4 +-
 include/linux/soc/qcom/smd.h                       |   29 +-
 54 files changed, 3798 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/qcom,ebi2.txt
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
 create mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
 create mode 100644 Documentation/perf/xgene-pmu.txt
 create mode 100644 drivers/bus/qcom-ebi2.c
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 drivers/nvmem/meson-efuse.c
 create mode 100644 drivers/perf/xgene_pmu.c
 create mode 100644 drivers/reset/reset-stm32.c
 create mode 100644 drivers/reset/reset-uniphier.c
 create mode 100644 include/dt-bindings/mfd/stm32f4-rcc.h
 create mode 100644 include/linux/firmware/meson/meson_sm.h
