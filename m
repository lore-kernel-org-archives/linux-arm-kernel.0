From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 24 Jun 2013 20:05:43 +0200
Subject: [PATCH v2 0/8] ARM: dts: Add camera and magnetometer support for
 TRATS2 board
Message-ID: <1372097151-18122-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series includes some fixes and extensions to the Exynos
dts files to add the camera and magnetometer sensor support for TRATS2
board. It depends on a patch from Tomasz adding initial TRATS2 board
dts file [1].

Changes since v1 (are also listed at individual patches, if any):
  - enabled pull down in cam-port-{a, b}-clk-idle nodes (1/8)
  - added node alias for i2c-gpio at 0 I2C controller node (7/8).

[1] http://www.spinics.net/lists/arm-kernel/msg253184.html

Jacek Anaszewski (1):
  ARM: dts: Add AK8975 device node for Exynos4412 TRATS2 board

Sylwester Nawrocki (7):
  ARM: dts: Correct camera pinctrl nodes for Exynos4x12 SoCs
  ARM: dts: Add pinctrl entries for Exynos4x12 FIMC-IS peripherals
  ARM: dts: Add ISP power domain node for Exynos4x12
  ARM: dts: Use generic DMA bindings for Exynos4 SPI devices
  ARM: dts: Add camera nodes for Exynos4 SoCs
  ARM: dts: Add camera subsystem nodes to exynos4x12.dtsi
  ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board

 arch/arm/boot/dts/exynos4.dtsi            |   80 +++++++++++++++++--
 arch/arm/boot/dts/exynos4412-trats2.dts   |  110 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi |   61 ++++++++++++--
 arch/arm/boot/dts/exynos4x12.dtsi         |  123 +++++++++++++++++++++++++++++
 4 files changed, 361 insertions(+), 13 deletions(-)

--
1.7.9.5
