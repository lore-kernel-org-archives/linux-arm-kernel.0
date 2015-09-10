From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 10 Sep 2015 16:47:56 -0700
Subject: [GIT PULL] ARM: SoC: late fixes and dependencies
Message-ID: <7hpp1p3kgj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please consider our late/final pull request for v4.3 merge window.

Kevin (on behalf of the arm-soc team)



The following changes since commit ba5d183bced6cb60b2838a0bf04665c1c1e4bff1:

  Merge tag 'tegra-for-4.3-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into next/defconfig (2015-08-20 18:59:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to c6e59bdac940e63cfabd40a89d342eb470b009b9:

  Merge tag 'qcom-soc-for-4.3-rc2' of git://codeaurora.org/quic/kernel/agross-msm into next/late (2015-09-09 16:15:34 -0700)

----------------------------------------------------------------
ARM: SoC: late fixes and dependencies

This is a collection of a few late fixes and other misc. stuff that
had dependencies on things being merged from other trees.

The bulk of the changes are for samsung/exynos SoCs for some changes
that needed a few minor reworks so ended up a bit late.  The others
are mainly for qcom SoCs: a couple fixes and some DTS updates.

There's one conflict with drivers/cpufreq/exynos-cpufreq.c because
it's now been completely removed, but there were some fixes that hit
mainline in the meantime.

----------------------------------------------------------------
Alexis Ballier (1):
      ARM: dts: enable SPI1 for exynos4412-odroidu3

Anand Moon (1):
      ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3

Andy Gross (4):
      Merge tag 'qcom-dt-for-4.3' into v4.2-rc2
      Merge tag 'qcom-soc-for-4.3' into v4.2-rc2
      soc: qcom: smem: Fix errant private access
      soc: qcom: smd: Use correct remote processor ID

Axel Lin (2):
      reset: Add (devm_)reset_control_get stub functions
      reset: ath79: Fix missing spin_lock_init

Bartlomiej Zolnierkiewicz (5):
      cpufreq: exynos: remove exynos5250 specific cpufreq driver support
      clk: exynos4x12: add cpu clock configuration data and instantiate cpu clock
      cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support
      ARM: dts: add CPU OPP and regulator supply property for exynos4x12
      ARM: EXYNOS: switch to using generic cpufreq driver for exynos4x12

Bjorn Andersson (1):
      soc: qcom: smd: Correct fBLOCKREADINTR handling

Chanho Park (1):
      ARM: dts: add exynos5422-cpus.dtsi to correct cpu order

Chanwoo Choi (3):
      ARM: EXYNOS: Add exynos3250 compatible to use generic cpufreq driver
      ARM: dts: Add CPU OPP and regulator supply property for exynos3250
      ARM: dts: Add CPU cooling binding for exynos3250 boards

Javier Martinez Canillas (4):
      ARM: multi_v7_defconfig: Remove old Samsung USB PHY configs
      ARM: multi_v7_defconfig: Enable NTC Thermistors support
      ARM: exynos_defconfig: Enable NTC Thermistors support
      ARM: multi_v7_defconfig: Enable max77802 regulator

Jonas Rabenstein (1):
      cpufreq: exynos: Remove unselectable rule for arm-exynos-cpufreq.o

Kevin Hilman (5):
      Merge tag 'reset-for-4.3-fixes' of git://git.pengutronix.de/git/pza/linux into drivers/reset
      Merge branch 'drivers/reset' into next/late
      Merge branch 'next/defconfig' into next/late
      Merge tag 'qcom-dt-for-4.3-rc2' of git://codeaurora.org/quic/kernel/agross-msm into next/late
      Merge tag 'qcom-soc-for-4.3-rc2' of git://codeaurora.org/quic/kernel/agross-msm into next/late

Kishon Vijay Abraham I (1):
      ARM: multi_v7_defconfig: Enable PBIAS regulator

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable cpufreq-dt driver

Marek Szyprowski (1):
      ARM: dts: add iommu property to JPEG device for exynos4

Michal Suchanek (1):
      ARM: dts: Add SPI CS on exynos5250-snow

Olof Johansson (5):
      Merge tag 'samsung-clk-driver' of git://git.kernel.org/.../kgene/linux-samsung into next/late
      Merge tag 'samsung-late-dt' of git://git.kernel.org/.../kgene/linux-samsung into next/late
      Merge tag 'samsung-soc' of git://git.kernel.org/.../kgene/linux-samsung into next/late
      Merge tag 'samsung-late-cpufreq-driver' of git://git.kernel.org/.../kgene/linux-samsung into next/late
      Merge tag 'samsung-defconfig-new' of git://git.kernel.org/.../kgene/linux-samsung into next/late

Stephen Boyd (10):
      ARM: dts: qcom: Label serial nodes for aliasing and stdout-path
      ARM: dts: qcom: apq8064-cm-qs600: Use stdout-path
      ARM: dts: qcom: apq8064-ifc6410: Use stdout-path
      ARM: dts: qcom: apq8074-dragonboard: Use stdout-path
      ARM: dts: qcom: apq8084-ifc6540: Use stdout-path
      ARM: dts: qcom: apq8084-mtp: Use stdout-path
      ARM: dts: qcom: ipq8064-ap148: Use stdout-path
      ARM: dts: qcom: msm8660-surf: Use stdout-path
      ARM: dts: qcom: msm8960-cdp: Use stdout-path
      ARM: dts: qcom: msm8974-sony-xperia-honami: Use stdout-path

Thomas Abraham (2):
      ARM: EXYNOS: switch to using generic cpufreq driver for exynos5250
      ARM: dts: add CPU OPP and regulator supply property for exynos5250

 Documentation/devicetree/bindings/reset/ath79-reset.txt          |   20 +
 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt      |   84 +++
 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt  |    2 +-
 Documentation/devicetree/bindings/reset/st,sti-powerdown.txt     |    4 +-
 Documentation/devicetree/bindings/reset/st,sti-softreset.txt     |    4 +-
 Documentation/devicetree/bindings/reset/zynq-reset.txt           |   68 +++
 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt           |  117 +++++
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt          |   85 +++
 MAINTAINERS                                                      |    1 +
 arch/arm/boot/dts/exynos3250-monk.dts                            |   19 +
 arch/arm/boot/dts/exynos3250-rinato.dts                          |   19 +
 arch/arm/boot/dts/exynos3250.dtsi                                |   18 +-
 arch/arm/boot/dts/exynos4.dtsi                                   |    1 +
 arch/arm/boot/dts/exynos4210-origen.dts                          |    4 +
 arch/arm/boot/dts/exynos4210-trats.dts                           |    4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts                  |  618 +++++++++++-----------
 arch/arm/boot/dts/exynos4210.dtsi                                |   12 +
 arch/arm/boot/dts/exynos4212.dtsi                                |   81 +++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi                  |    4 +
 arch/arm/boot/dts/exynos4412-odroidu3.dts                        |    8 +
 arch/arm/boot/dts/exynos4412-origen.dts                          |    4 +
 arch/arm/boot/dts/exynos4412-trats2.dts                          |    7 +
 arch/arm/boot/dts/exynos4412.dtsi                                |   83 +++
 arch/arm/boot/dts/exynos5250-arndale.dts                         |    4 +
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi                        | 1600 ++++++++++++++++++++++++++++----------------------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts                        |    4 +
 arch/arm/boot/dts/exynos5250-snow.dts                            |    5 +
 arch/arm/boot/dts/exynos5250-spring.dts                          |    4 +
 arch/arm/boot/dts/exynos5250.dtsi                                |   25 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts                        |    6 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi                        | 1411 +++++++++++++++++++++++++------------------------
 arch/arm/boot/dts/exynos5420.dtsi                                |    3 +-
 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi                    |   59 +++
 arch/arm/boot/dts/exynos5422-cpus.dtsi                           |   81 +++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi               |   47 ++
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts                      |   28 +
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts                       |   44 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                              |   91 +++-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                   |    8 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts                       |    8 +
 arch/arm/boot/dts/qcom-apq8084-mtp.dts                           |    8 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                              |    2 +-
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts                         |    8 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                              |    2 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts                          |    8 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                              |   13 +-
 arch/arm/boot/dts/qcom-msm8960-cdp.dts                           |  310 +++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi                              |   51 +-
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts            |    8 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                              |   34 +-
 arch/arm/boot/dts/stih407-family.dtsi                            |    2 +-
 arch/arm/boot/dts/stih415.dtsi                                   |    2 +-
 arch/arm/boot/dts/stih416.dtsi                                   |    2 +-
 arch/arm/configs/exynos_defconfig                                |    5 +
 arch/arm/configs/multi_v7_defconfig                              |    6 +-
 arch/arm/mach-exynos/Kconfig                                     |    2 +
 arch/arm/mach-exynos/exynos.c                                    |    4 +
 arch/mips/Kconfig                                                |    1 +
 arch/mips/boot/dts/qca/ar9132.dtsi                               |    8 +
 drivers/clk/samsung/clk-exynos3250.c                             |   32 +-
 drivers/clk/samsung/clk-exynos4.c                                |   50 ++
 drivers/clk/samsung/clk-exynos5250.c                             |   31 ++
 drivers/cpufreq/Kconfig.arm                                      |   49 --
 drivers/cpufreq/Makefile                                         |    4 -
 drivers/cpufreq/exynos-cpufreq.c                                 |  237 ---------
 drivers/cpufreq/exynos-cpufreq.h                                 |   89 ----
 drivers/cpufreq/exynos4x12-cpufreq.c                             |  236 ---------
 drivers/cpufreq/exynos5250-cpufreq.c                             |  210 --------
 drivers/reset/Makefile                                           |    3 +
 drivers/reset/reset-ath79.c                                      |  129 +++++
 drivers/reset/reset-lpc18xx.c                                    |  258 +++++++++
 drivers/reset/reset-socfpga.c                                    |   19 +-
 drivers/reset/reset-zynq.c                                       |  155 ++++++
 drivers/reset/sti/reset-stih407.c                                |    4 +-
 drivers/reset/sti/reset-stih415.c                                |    4 +-
 drivers/reset/sti/reset-stih416.c                                |    4 +-
 drivers/soc/qcom/Kconfig                                         |   31 ++
 drivers/soc/qcom/Makefile                                        |    3 +
 drivers/soc/qcom/smd-rpm.c                                       |  244 +++++++++
 drivers/soc/qcom/smd.c                                           | 1327 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/smem.c                                          |  769 +++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos3250.h                           |    1 +
 include/dt-bindings/clock/exynos5250.h                           |    1 +
 include/dt-bindings/{reset-controller => reset}/stih407-resets.h |    0
 include/dt-bindings/{reset-controller => reset}/stih415-resets.h |    0
 include/dt-bindings/{reset-controller => reset}/stih416-resets.h |    0
 include/linux/reset.h                                            |   14 +
 include/linux/soc/qcom/smd-rpm.h                                 |   35 ++
 include/linux/soc/qcom/smd.h                                     |   46 ++
 include/linux/soc/qcom/smem.h                                    |   11 +
 90 files changed, 6471 insertions(+), 2696 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 arch/arm/boot/dts/exynos5422-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
 create mode 100644 drivers/reset/reset-ath79.c
 create mode 100644 drivers/reset/reset-lpc18xx.c
 create mode 100644 drivers/reset/reset-zynq.c
 create mode 100644 drivers/soc/qcom/smd-rpm.c
 create mode 100644 drivers/soc/qcom/smd.c
 create mode 100644 drivers/soc/qcom/smem.c
 rename include/dt-bindings/{reset-controller => reset}/stih407-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih415-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih416-resets.h (100%)
 create mode 100644 include/linux/soc/qcom/smd-rpm.h
 create mode 100644 include/linux/soc/qcom/smd.h
 create mode 100644 include/linux/soc/qcom/smem.h
