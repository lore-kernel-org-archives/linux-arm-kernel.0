From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 27 Nov 2014 16:34:57 +0900
Subject: [PATCH 00/19] arm64: Add the support for new 64-bit Exynos5433 SoC
Message-ID: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds new 64-bit Exynos5433 Samsung SoC which contains quad
Cortex-A57 and quad Cortex-A53. It is desigend with the 20nm low power process.

This patchset include some patches such as:
- Support booting of Exynos5433
- Support UART/MCT/GIC/HSI2C/SPI/PDMA/MSHC
- Support the clock control for Exynos5433 using common clk framework

This patchst is based on Exynos7 patchset[1] because Exynos5433 has similiar
feature with Exynos7. Exynos7 did already specify the dependent patchset list.

This patchset has the dependency as following list:
: The Exynos7 patchset[1] specified dependent patchset for 64-bit SoC.
 So, this patchset used same dependent patchset of Exynos7 patchset and Exynos7
 patchset about pinctrl patch. Additionally, SPI/MMC/PDMA patch [2-5] is used
 for kernel booting and mounting rootfs.

1. [PATCH v7 0/7] Enable support for Samsung Exynos7 SoC
   - [1] http://www.spinics.net/lists/linux-samsung-soc/msg38734.html
2. [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
   - [2] http://www.spinics.net/lists/linux-samsung-soc/msg38607.html
3. [PATCH V7] mmc: dw_mmc: Add IDMAC 64-bit address mode support
   - [3] https://lkml.org/lkml/2014/10/20/58
4. [PATCH] mmc: dw_mmc: exynos: Add support for exynos7
   - [4] http://www.spinics.net/lists/linux-mmc/msg28294.html
5. [PATCH] dmaengine: pl330: Correct device assignment
   - [5] https://lkml.org/lkml/2014/11/6/207

Chanwoo Choi (18):
  pinctrl: exynos: Add support for Exynos5433
  clk: samsung: Add binding documentation for Exynos5433 clock controller
  clk: samsung: exynos5433: Add clocks using common clock framework
  clk: samsung: exynos5433: Add MUX clocks of CMU_TOP domain
  clk: samsung: exynos5433: Add clocks for CMU_PERIC domain
  clk: samsung: exynos5433: Add clocks for CMU_PERIS domain
  clk: samsung: exynos5433: Add clocks for CMU_G2D domain
  clk: samsung: exynos5433: Add clocks for CMU_MIF domain
  clk: samsung: exynos5433: Add clocks for CMU_DISP domain
  clk: samsung: exynos5433: Add clocks for CMU_AUD domain
  clk: samsung: exynos5433: Add clocks for CMU_BUS{0|1|2} domains
  clk: samsung: exynos5433: Add missing clocks for CMU_FSYS domain
  clk: samsung: exynos5433: Add clocks for CMU_G3D domain
  clk: samsung: exynos5433: Add clocks for CMU_GSCL domain
  arm64: exynos5433: Enable ARMv8-based Exynos5433 SoC support
  arm64: dts: exynos: Add dts files for 64-bit Exynos5433 SoC
  arm64: dts: exynos: Add SPI/PDMA dt node for Exynos5433
  serial: samsung: Add the support for Exynos5433 SoC

Jaehoon Chung (1):
  arm64: dts: exynos: Add MSHC dt node for Exynos5433

 .../devicetree/bindings/clock/exynos5433-clock.txt |  167 +
 arch/arm64/Kconfig                                 |   10 +
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  698 ++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  684 ++++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5433.c               | 3409 ++++++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  163 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
 drivers/tty/serial/samsung.c                       |   56 +-
 include/dt-bindings/clock/exynos5433.h             |  867 +++++
 11 files changed, 6038 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5433.c
 create mode 100644 include/dt-bindings/clock/exynos5433.h

-- 
1.8.5.5
