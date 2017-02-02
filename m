From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu,  2 Feb 2017 20:30:08 +0200
Subject: [GIT PULL 4/4] arm64: dts: exynos: DT64 for v4.11, third round
In-Reply-To: <20170202183008.23500-1-krzk@kernel.org>
References: <20170202183008.23500-1-krzk@kernel.org>
Message-ID: <20170202183008.23500-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This includes clk-v4.11-samsung-dphy tag from Sylwester (clock) and a pinctrl
header acked by Linus pinctrl header. The header goes through my tree but I provided
a separate tag also for Linus.

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 7547162ac351483df3641f64e99e10be329dd6a2:

  arm64: dts: exynos: Add clocks to Exynos5433 LPASS module (2017-01-26 22:04:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.11-3

for you to fetch changes up to 6629490aa027a8af3160e63cffcddc97c1602c96:

  arm64: dts: exynos: Add regulators for Vbus and Vbus-Boost (2017-02-02 19:54:05 +0200)

----------------------------------------------------------------
Samsung DeviceTree ARM64 update for v4.11, third round:
1. Add necessary initial configuration for clocks of display subsystem.
   Till now it worked mostly thanks to bootloader.
2. Use macro definitions instead of hard-coded values for pinctrl on Exynos7.
3. Enable USB 3.0 (DWC3) on Exynos7.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      Merge tag 'clk-v4.11-samsung-dphy' of git://linuxtv.org/snawrocki/samsung into next/dt64
      Merge tag 'samsung-pinctrl-4.11' into next/dt64

Marek Szyprowski (3):
      clk: samsung: exynos5433: Add IDs for PHYCLK_MIPIDPHY0_* clocks
      clk: samsung: exynos5433: Add data for 250MHz and 278MHz PLL rates
      arm64: dts: exynos: Add initial configuration for DISP clocks for TM2/TM2e

Pankaj Dubey (2):
      pinctrl: dt-bindings: samsung: Add Exynos7 specific pinctrl macro definitions
      arm64: dts: exynos: Use macros for pinctrl configuration on Exynos7

Vivek Gautam (2):
      arm64: dts: exynos: Add USB 3.0 controller node for Exynos7
      arm64: dts: exynos: Add regulators for Vbus and Vbus-Boost

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |  12 -
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      |  34 +++
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |  34 +++
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  49 +++-
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 302 +++++++++++----------
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  34 +++
 drivers/clk/samsung/clk-exynos5433.c               |   8 +-
 include/dt-bindings/clock/exynos5433.h             |   5 +-
 include/dt-bindings/pinctrl/samsung.h              |   8 +
 9 files changed, 319 insertions(+), 167 deletions(-)
