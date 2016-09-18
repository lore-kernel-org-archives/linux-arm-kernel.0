From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 18 Sep 2016 18:39:48 +0200
Subject: [GIT PULL 3/3] ARM: dts: exynos: pinctrl cleanup for v4.9
In-Reply-To: <1474216788-17282-1-git-send-email-krzk@kernel.org>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
Message-ID: <1474216788-17282-4-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,

A separate topic branch with DT cleanup.


Best regards,
Krzysztof


The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-pinctrl-4.9

for you to fetch changes up to d13799237dee34e1b9cd377f0ced7bee24ac810f:

  ARM: dts: s3c64xx: Use macros for pinctrl configuration (2016-09-16 13:32:27 +0200)

----------------------------------------------------------------
Topic branch for Samsung DeviceTree cleanup for 4.9.

Replace in DT sources hard-coded values for pinctrl configuration like pull
up/down, drive strength and function. This makes the DTS easier to read,
especially that some drive strengths values are quite non-obvious.

----------------------------------------------------------------
Krzysztof Kozlowski (17):
      pinctrl: dt-bindings: samsung: Add header with values used for configuration
      pinctrl: dt-bindings: samsung: Update documentation with new macros
      ARM: dts: exynos: Use common macros for pinctrl configuration
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos3250
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4210
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4x12
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos4415
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5250
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5260
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos5410
      ARM: dts: exynos: Use macros for pinctrl configuration on exynos542x/exynos5800
      ARM: dts: exynos: Fix mismatched value for SD4 pull up/down configuration on exynos4210
      ARM: dts: exynos: Fix mismatched values of SD drive strengh configuration on exynos4415
      ARM: dts: s3c64xx: Use common macros for pinctrl configuration
      ARM: dts: s5pv210: Use macros for pinctrl configuration
      ARM: dts: s3c2416: Use macros for pinctrl configuration
      ARM: dts: s3c64xx: Use macros for pinctrl configuration

 .../bindings/pinctrl/samsung-pinctrl.txt           |  44 +-
 MAINTAINERS                                        |   2 +
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 346 +++++++-------
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 458 +++++++++---------
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  12 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   8 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  14 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  12 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  12 +-
 arch/arm/boot/dts/exynos4415-pinctrl.dtsi          | 296 ++++++------
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 525 ++++++++++-----------
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 404 ++++++++--------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   6 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  76 +--
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   6 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  72 +--
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 280 ++++++-----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   6 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  30 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 182 +++----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |  10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   6 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 126 ++---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 356 +++++++-------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  18 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  18 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          | 126 ++---
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  38 +-
 arch/arm/boot/dts/s3c6410-mini6410.dts             |   4 +-
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 356 +++++++-------
 arch/arm/boot/dts/s5pv210-aquila.dts               |   4 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             | 476 +++++++++----------
 include/dt-bindings/pinctrl/samsung.h              |  57 +++
 35 files changed, 2223 insertions(+), 2171 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/samsung.h
