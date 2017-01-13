From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 17:20:28 +0200
Subject: [GIT PULL 2/4] ARM: dts: exynos: DT for v4.11
In-Reply-To: <20170113152030.13586-1-krzk@kernel.org>
References: <20170113152030.13586-1-krzk@kernel.org>
Message-ID: <20170113152030.13586-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few improvements and Exynos4412 DTSI removal.

This pulls external dependecy from clock tree (one clock commit).

Best regards,
Krzysztof


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.11

for you to fetch changes up to bca9085e0ae93253bc93ce218c85ac7d7e7f1831:

  ARM: dts: exynos: remove Exynos4212 support (dead code) (2017-01-11 18:28:43 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.11:
1. Fixes for initial audio clocks configuration.
2. Enable sound on Odroid-X board.
3. Enable DMA for UART modules on Exynos5 SoCs.
4. Add CPU OPPs for Exynos4412 Prime (newer version of Exynos4412). This pulls
   necessary change in the clocks.
5. Remove Exynos4212. We do not have any mainline boards with it. This will
   simplify few bits later.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (2):
      clk: samsung: Add CPU clk configuration data for Exynos4412 Prime
      ARM: dts: exynos: Add CPU OPPs for Exynos4412 Prime

Krzysztof Kozlowski (1):
      Merge tag 'clk-v4.11-exynos4-pll' of git://linuxtv.org/snawrocki/samsung into next/dt

Marek Szyprowski (4):
      ARM: dts: exynos: Correct clocks for Exynos4 I2S module
      ARM: dts: exynos: Fix initial audio clocks configuration on Exynos4 boards
      ARM: dts: exynos: Enable DMA support for UART modules on Exynos5 SoCs
      ARM: dts: exynos: remove Exynos4212 support (dead code)

Markus Reichl (1):
      ARM: dts: exynos: Cleanup Odroid-X2 and enable sound on Odroid-X

 arch/arm/boot/dts/exynos4.dtsi                     |   6 +-
 arch/arm/boot/dts/exynos4212.dtsi                  | 133 -----
 arch/arm/boot/dts/exynos4412-itop-elite.dts        |  25 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  28 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   5 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  13 +
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |  25 +-
 ...os4x12-pinctrl.dtsi => exynos4412-pinctrl.dtsi} |   4 +-
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  41 ++
 arch/arm/boot/dts/exynos4412.dtsi                  | 577 +++++++++++++++++++-
 arch/arm/boot/dts/exynos4x12.dtsi                  | 594 ---------------------
 arch/arm/boot/dts/exynos5250.dtsi                  |   8 +
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   8 +
 drivers/clk/samsung/clk-exynos4.c                  |   4 +
 15 files changed, 685 insertions(+), 794 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4212.dtsi
 rename arch/arm/boot/dts/{exynos4x12-pinctrl.dtsi => exynos4412-pinctrl.dtsi} (99%)
 create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
