From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 03 Nov 2016 15:39:04 +0900
Subject: [PATCH v3 0/5] arm64: dts: Add the dts file for Exynos5433 and TM/TM2E
 board
Message-ID: <1478155149-28527-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the Device Tree file for Samsung 64-bit Exynos5433 SoC
and TM/TM2E board based on Exynos5433. The Exynos5433 has Octa-core CPUs
(quad Cortex-A57 and quad Cortex-A53). The TM2 and TM2E are the Samsung board
based on Exynos5433 SoC.

I tested the display controller by using the modetest tool.
But, Samsung s6e3ha2 panel driver has not yet posted. So, the TM2 dts file
don't include the panel Device Tree node. I'll post the s6e3ha2 panel driver
on separate patch with a dt patch.

Changes from v2:
(https://lkml.org/lkml/2016/8/24/426)
- Add new pctl_base and eint_base instead of virt_base on patch1.
- Modify the documentation of pinctrl-samsung.txt on patch1.
- Modify the cooling level for big.LITTLE cores.
- Use the GIC_SPI definition on dtsi file.
- Removes the unneeded 'regulator-always-on' property.
- Fix the kbuild report of the compatible string for TM2/TM2E patches.
- Two patches(exynos-mct, exynos5433-pmu) were merged.
- Add the reviewed-by tag of Javier Martinez Canillas on patch3/4/5
- Add the reviewed-by tag of Krzysztof Kozlowski on patch4/5
- Add the acked-by tag of Rob Herring on patch5
- Fix the minor issues.

Changes from v1:
(https://lkml.org/lkml/2016/8/16/61)
- Merge the cpufreq patch for exynos5433[3] on PM/cpufreq tree.
- Add new patch to support the multiple IORESOURCE_MAP for samsung pinctrl driver.
- Drop the SYSMMU Device-Tree node which will be posted by Marek Szyprowski.
- Fix the code clean issue by Krzysztof Kozlowski and Rob Herring's comment.
- Delete the unnecessary alias from exynos5433-tm2.dts.
- Expand the range of cooling level of CPU device.
- Update the binding method of 'Exynos5433 audio subsystem'

Depends on:
This patchset are based on v4.9-rc3.

Chanwoo Choi (5):
  pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank
  pinctrl: samsung: Add GPF support for Exynos5433
  arm64: dts: exynos: Add dts files for Samsung Exynos5433 64bit SoC
  arm64: dts: exynos: Add dts file for Exynos5433-based TM2 board
  arm64: dts: exynos: Add dts file for Exynos5433-based TM2E board

 .../bindings/arm/samsung/samsung-boards.txt        |    2 +
 .../bindings/pinctrl/samsung-pinctrl.txt           |   19 +
 arch/arm64/boot/dts/exynos/Makefile                |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  794 ++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  974 ++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   41 +
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |   23 +
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |   22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     |  296 +++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 1356 ++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   45 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h           |   11 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   40 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   10 +-
 14 files changed, 3598 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

-- 
1.9.1
