From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 13 Jan 2017 17:20:29 +0200
Subject: [GIT PULL 3/4] arm64: dts: exynos: DT for v4.11
In-Reply-To: <20170113152030.13586-1-krzk@kernel.org>
References: <20170113152030.13586-1-krzk@kernel.org>
Message-ID: <20170113152030.13586-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Important:
1. Unlike others, this is rebased on v4.10-rc2 because v4.10-rc1 was not
   building on arm64.
2. This contains pinctrl change (in header), acked by Linus Walleij.
   Although I kept it on separate branch and merged here, but I did not
   prepare a separate pull request for this one pinctrl change - it is
   just one patch. Anyway it sits on separate branch so this is still
   possible if you need it.

Best regards,
Krzysztof

Cc: Linus Walleij <linus.walleij@linaro.org>

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.11

for you to fetch changes up to e4e381133241a27d732e78be09973b89a193eaf7:

  arm64: dts: exynos: Enable HDMI/TV path on Exynos5433-TM2 (2017-01-11 18:20:28 +0200)

----------------------------------------------------------------
Samsung DeviceTree ARM64 update for v4.11:
1. Add bus frequency and voltage scalling on Exynos5433 TM2 device (along with
   necessary bus nodes and Platform Performance Monitoring Unit on Exynos5433).
2. Use macros for pinctrl settings on Exynos5433.
   This contains necessary header with bindings.
3. Minor cleanups in Exynos5433 DTSI and boards using it.
4. Create common DTSI betweem Exynos5433 TM2E and TM2E.
5. Add HDMI/TV to Exynos5433 TM2.

----------------------------------------------------------------
Andi Shyti (4):
      pinctrl: dt-bindings: samsung: add drive strength macros for Exynos5433
      arm64: dts: exynos: Use macros for pinctrl configuration on Exynos5433
      arm64: dts: exynos: Comply to the samsung pinctrl naming convention in TM2
      arm64: dts: exynos: Make TM2 and TM2E independent from each other

Andrzej Hajda (4):
      arm64: dts: exynos: Fix addresses in node names on Exynos5433
      arm64: dts: exynos: Add DECON_TV node to Exynos5433
      arm64: dts: exynos: Add HDMI node to Exynos5433
      arm64: dts: exynos: Enable HDMI/TV path on Exynos5433-TM2

Chanwoo Choi (4):
      arm64: dts: exynos: Add PPMU node to Exynos5433
      arm64: dts: exynos: Add bus nodes using VDD_INT for Exynos5433
      arm64: dts: exynos: Add support of bus frequency using VDD_INT on Exynos5433 TM2
      arm64: dts: exynos: Fix wrong values for ldo23 and ldo25 on TM2/TM2E

Krzysztof Kozlowski (2):
      Merge branch 'for-v4.11/pinctrl-macros' into next/dt64
      arm64: dts: exynos: Remove unsupported regulator-always-off property from TM2E

 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     |  197 ++++
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  373 +++---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1187 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1036 +----------------
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |   12 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  115 +-
 include/dt-bindings/pinctrl/samsung.h              |   14 +
 7 files changed, 1695 insertions(+), 1239 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
