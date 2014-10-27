From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 27 Oct 2014 10:35:57 +0900
Subject: [PATCHv2 0/2] Support new Exynos4415 SoC based on Cortex-A9 quad cores
Message-ID: <1414373759-4362-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support new Exynos4415 Samsung SoC based on Cortex-A9 quad cores.
Exynos4415 is a System-On-Chip (SoC) that is based on 32-bit RISC processor
for Smartphone. It is desigend with the 28nm low-power high-K metal gate process
and provides the best performance features.

This patchset include some patches such as:
- Support booting of Exynos4415
- Supoort uart/mct/adc/gic/i2c/spi/power-domain/pmu/mshc/ehci/ohci/pwm/amba

Changes from v1:
- Remove legacy helper function to identify SoC
- Separate out the clock patches[2] from Exynos4415 patchset[1] and sent it [2]
- Separate out the pinctrl patch[3] from Exynos4415 patchset[1] and sent it [3]
 [1] [PATCH 0/5] Support new Exynos4415 SoC based on Cortex-A9 quad cores
     : https://lkml.org/lkml/2014/10/19/253
 [2] [PATCHv3 1/2] clk: samsung: exynos4415: Add clocks using common clock framework
     : https://lkml.org/lkml/2014/10/26/159
 [3] [PATCHv2] pinctrl: exynos: Add support for Exynos4415
     : https://lkml.org/lkml/2014/10/26/160

Chanwoo Choi (2):
  ARM: EXYNOS: Add EXYNOS4415 SoC ID
  ARM: dts: Add dts files for Exynos4415 SoC

 arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 613 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4415.dtsi         | 627 ++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/Kconfig              |   5 +
 arch/arm/mach-exynos/exynos.c             |   2 +
 4 files changed, 1247 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4415-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4415.dtsi

-- 
1.8.5.5
