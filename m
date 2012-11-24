From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 25 Nov 2012 02:14:48 +0530
Subject: [PATCH v2 0/5] ARM: Exynos: Enable device tree support for MCT
 controller
Message-ID: <1353789893-2460-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Includes changes suggested by Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

This patch series adds device tree support for Exynos4/5 MCT controller. This
series depends on the device tree and smp support patches for Exynos4x12 posted
by Tomasz Figa. This patch series has been tested on Exynos4210 based Origen
board, Exynos4412 based SMDK board and Exynos5250 based SMDK board.

Thomas Abraham (5):
  ARM: Exynos: add a register base address variable in mct controller driver
  ARM: Exynos: prepare an array of MCT interrupt numbers and use it
  ARM: Exynos: add device tree support for MCT controller driver
  ARM: Exynos: remove static io-remapping of mct registers for Exynos5
  ARM: dts: add mct device tree node for all supported Exynos SoC's

 .../bindings/timer/samsung,exynos4210-mct.txt      |   69 ++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |    8 +
 arch/arm/boot/dts/exynos4212.dtsi                  |   10 +
 arch/arm/boot/dts/exynos4412.dtsi                  |    8 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   21 +++
 arch/arm/mach-exynos/common.c                      |    5 -
 arch/arm/mach-exynos/include/mach/irqs.h           |    6 -
 arch/arm/mach-exynos/include/mach/map.h            |    1 -
 arch/arm/mach-exynos/include/mach/regs-mct.h       |   53 ------
 arch/arm/mach-exynos/mct.c                         |  175 +++++++++++++-------
 10 files changed, 232 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h

-- 
1.7.4.4
