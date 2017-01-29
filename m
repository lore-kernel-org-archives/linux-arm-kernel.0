From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 29 Jan 2017 22:06:29 +0200
Subject: [GIT PULL 4/4] arm64: dts: exynos: for v4.11, 2nd round
In-Reply-To: <20170129200630.22083-1-krzk@kernel.org>
References: <20170129200630.22083-1-krzk@kernel.org>
Message-ID: <20170129200630.22083-4-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

This adds proper clocks to LPASS node on Exynos5433 which is needed
by Marek's patchset:
 - [PATCH v2 0/8] Pad retentions support for Exynos5433
   https://lkml.kernel.org/r/1485419634-28331-1-git-send-email-m.szyprowski () samsung ! com


Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>

Best regards,
Krzysztof


The following changes since commit e4e381133241a27d732e78be09973b89a193eaf7:

  arm64: dts: exynos: Enable HDMI/TV path on Exynos5433-TM2 (2017-01-11 18:20:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.11-2

for you to fetch changes up to 7547162ac351483df3641f64e99e10be329dd6a2:

  arm64: dts: exynos: Add clocks to Exynos5433 LPASS module (2017-01-26 22:04:20 +0200)

----------------------------------------------------------------
Samsung DeviceTree ARM64 update for v4.11, second round:
1. Use proper drive strengths on Exynos7.
2. Fix significant current leak on Exynos5433-based TM2/TM2E due
   to disabled regulator.
2. Add touchkey to TM2, set display clocks for Ultra HD modes.
3. Cleanups and minor fixes for Exynos5433, TM2 and TM2E.

----------------------------------------------------------------
Andrzej Hajda (2):
      arm64: dts: exynos: configure TV path clocks for Ultra HD modes
      arm64: dts: exynos: set LDO7 regulator as always on

Jaechul Lee (1):
      arm64: dts: exynos: Add TM2 touchkey node

Javier Martinez Canillas (1):
      arm64: dts: exynos: Remove unneeded unit names in Exynos5433 nodes

Marek Szyprowski (2):
      arm64: dts: exynos: Disable pull down for audio pins in Exynos5433 SoCs
      arm64: dts: exynos: Add clocks to Exynos5433 LPASS module

Pankaj Dubey (1):
      arm64: dts: exynos: Fix drive strength of sd0_xxx pin definitions

 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi    | 10 +++++-----
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 16 ++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts         | 13 +++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            |  8 +++++---
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi       | 14 +++++++-------
 5 files changed, 46 insertions(+), 15 deletions(-)
