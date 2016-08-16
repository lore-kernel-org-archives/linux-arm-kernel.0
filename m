From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 16 Aug 2016 15:27:16 +0900
Subject: [PATCH 0/7] arm64: dts: Add the dts file for Exynos5433 and TM/TM2E
 board
Message-ID: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the Device Tree file for Samsung 64-bit Exynos5433 SoC
and TM/TM2E board based on Exynos5433. The Exynos5433 has Octa-core CPUs
(quad Cortex-A57 and quad Cortex-A53). The TM2 and TM2E are the Samsung board
based on Exynos5433 SoC.

I sent the Exynos5433 patches[3]. But it was not merged because of sending
the only SoC dtsi patch without board patches. So, I again send the Exynos5433
SoC patches with TM2/TM2E board dts files.

When making the patches, I get the guide from Krzysztof (Exynos SoC maintainer).
The maintainer requires that already developed and verified work should merge
them as one patch. So, this patchset include only three patches for Exynos5433
dtsi, TM2 dts and TM2E dts file.

I tested the display controller by using the modetest tool.
But, Samsung s6e3ha2 panel driver has not yet posted. So, the TM2 dts file
don't include the panel Device Tree node. I'll post the s6e3ha2 panel driver
on separate patch with a dt patch.

Depends on:
This patchset are based on v4.8-rc1[1] and TM2 sound patches[2].

[1] v4.8-rc1
[2] https://lkml.org/lkml/2016/7/5/470
  : [PATCH v4 0/4] ASoC: samsung: Sound support for Exynos5433 TM2(E) boards
[3] http://lkml.org/lkml/2015/3/17/843
  : [PATCH v7 0/9] arm64: Add the support for new Exynos5433 SoC

Chanwoo Choi (6):
  clocksource: exynos_mct: Add the support for Exynos 64bit SoC
  Documentation: bindings: Add Exynos5433 PMU compatible
  cpufreq: dt: Add exynos5433 compatible to use generic cpufreq driver
  arm64: dts: exynos: Add dts files for Samsung Exynos5433 64bit SoC
  arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board
  arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board

Joonyoung Shim (1):
  pinctrl: samsung: Add GPFx support of Exynos5433

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 .../bindings/arm/samsung/samsung-boards.txt        |    2 +
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 arch/arm64/boot/dts/exynos/Makefile                |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  794 ++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1003 +++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   41 +
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  306 ++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1580 ++++++++++++++++++++
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/clocksource/exynos_mct.c                   |    4 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |    1 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           |    5 +
 drivers/pinctrl/samsung/pinctrl-exynos.h           |   11 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   43 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    5 +
 18 files changed, 3839 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

-- 
1.9.1
